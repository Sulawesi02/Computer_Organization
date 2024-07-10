//*************************************************************************
//   > �ļ���: adder_display.v
//   > ����  ���ӷ�����ʾģ�飬����FPGA���ϵ�IO�ӿںʹ�����
//   > ����  : LOONGSON
//   > ����  : 2016-04-14
//*************************************************************************
module adder_display(
    //ʱ���븴λ�ź�
     input clk,
    input resetn,    //��׺"n"����͵�ƽ��Ч

    //���뿪�أ�����ѡ���������Ͳ���cin
    input input_sel_num, //0:����Ϊ����1(add_operand1);1:����Ϊ����2(add_operand2)
    input input_sel_high_or_low, //0:����Ϊ��32λ;1:����Ϊ��32λ
    input sw_cin,

    //led�ƣ�������ʾcout
    output led_cout,
    
    //��������ؽӿڣ�����Ҫ����
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );

//-----{���üӷ�ģ��}begin
    reg  [31:0] adder_operand1_low; 
    reg  [31:0] adder_operand1_high; 
    reg  [31:0] adder_operand2_low;
    reg  [31:0] adder_operand2_high;
    wire        adder_cin;
    wire [31:0] adder_result_low;
    wire [31:0] adder_result_high;
    wire        adder_cout;
    adder adder_module(
    .operand1_high(adder_operand1_high), 
    .operand1_low(adder_operand1_low),    
    .operand2_high(adder_operand2_high), 
    .operand2_low(adder_operand2_low),   
    .cin     (adder_cin),   
    .result_low(adder_result_low),  
    .result_high(adder_result_high),    
    .cout    (adder_cout) 
);
assign adder_cin = sw_cin;
assign led_cout  = adder_cout;

//-----{���üӷ�ģ��}end

//---------------------{���ô�����ģ��}begin--------------------//
//-----{ʵ����������}begin
//��С�ڲ���Ҫ����
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),
 
        //���ô������Ľӿ�
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd��������ؽӿڣ�����Ҫ����
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 
//-----{ʵ����������}end

//-----{�Ӵ�������ȡ����}begin
//����ʵ����Ҫ��������޸Ĵ�С�ڣ�
//�����ÿһ���������룬��д����һ��always��
    //��input_selΪ0ʱ����ʾ������Ϊ����1����operand1
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand1_low <= 32'd0;
            adder_operand1_high <= 32'd0;
        end
        else if (input_valid && !input_sel_num && !input_sel_high_or_low)
        begin
            adder_operand1_low <= input_value;
        end
         else if (input_valid && !input_sel_num && input_sel_high_or_low)
        begin
            adder_operand1_high <= input_value;
        end
    end
    
    //��input_selΪ1ʱ����ʾ������Ϊ����2����operand2
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand2_low <= 32'd0;
            adder_operand2_high <= 32'd0;
        end
        else if (input_valid && input_sel_num && !input_sel_high_or_low)
        begin
            adder_operand2_low <= input_value;
        end
        else if (input_valid && input_sel_num && input_sel_high_or_low)
        begin
            adder_operand2_high <= input_value;
        end
    end
//-----{�Ӵ�������ȡ����}end

//-----{�������������ʾ}begin
//������Ҫ��ʾ�����޸Ĵ�С�ڣ�
//�������Ϲ���44����ʾ���򣬿���ʾ44��32λ����
//44����ʾ�����1��ʼ��ţ����Ϊ1~44��
    always @(posedge clk)
    begin
        case(display_number)
            6'd1 :
            begin
                display_valid <= 1'b1;
                display_name  <= "1_HIGH";
                display_value <= adder_operand1_high;
            end
            6'd2 :
            begin
                display_valid <= 1'b1;
                display_name  <= "1_LOW";
                display_value <= adder_operand1_low;
            end
            6'd3 :
            begin
                display_valid <= 1'b1;
                display_name  <= "2_HIGH";
                display_value <= adder_operand2_high;
            end
            6'd4 :
            begin
                display_valid <= 1'b1;
                display_name  <= "2_LOW";
                display_value <= adder_operand2_low;
            end
            6'd5 :
            begin
                display_valid <= 1'b1;
                display_name  <= "R_HIGH";
                display_value <= adder_result_high;
            end
            6'd6 :
            begin
                display_valid <= 1'b1;
                display_name  <= "R_LOW";
                display_value <= adder_result_low;
            end
            default :
            begin
                display_valid <= 1'b0;
                display_name  <= 40'd0;
                display_value <= 32'd0;
            end
        endcase
    end
//-----{�������������ʾ}end
//----------------------{���ô�����ģ��}end---------------------//
endmodule

