`timescale 1ns / 1ps

module tb;
    //inputs
    reg clk;
    reg wen;//дʹ��
    reg  [4 :0] raddr1;//������������ַ
    reg  [4 :0] raddr2;
    reg  [4 :0] waddr;
    reg  [31:0] wdata;
    reg  [4 :0] test_addr;
    //outputs
    wire [31:0] rdata1;//��������
    wire [31:0] rdata2;    
    wire  [31:0] test_data;

    regfile uut (//����regfileģ�飬�Զ�������uut
        .clk   (clk   ),
        .wen   (wen   ),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .waddr (waddr ),
        .wdata (wdata ),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .test_addr(test_addr),
        .test_data(test_data)
    );
//-----{���üӷ�ģ��}begin
    wire [31:0] result;
    wire        cout;
    adder adder_module(
        .rdata1(rdata1),
        .rdata2(rdata2),
        .result(result),
        .cout  (cout)
    );
    
    initial begin
    clk = 0;
    wen=0;
    raddr1=0;
    raddr2=0;
    waddr=0;
    wdata=0;
    test_addr=0;
    #100;
    wen=1;
    waddr=12;
    wdata=32'Hc9a6b4d5;
    raddr1=12;
    #100;
    waddr=13;
    wdata=32'Hb4d5c9a6;
    raddr2=13;
    #100;

    end
   always #5 clk = ~clk;

endmodule
