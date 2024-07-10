`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 10:29:17
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;

    // Inputs
    reg [31:0] operand1_low;
    reg [31:0] operand1_high;   
    reg [31:0] operand2_low;   
    reg [31:0] operand2_high;
    reg cin;

    // Outputs
    wire [31:0] result_low;   
    wire [31:0] result_high; 
    wire cout;
    // Instantiate the Unit Under Test (UUT)
    adder uut (
        .operand1_low(operand1_low),        
        .operand1_high(operand1_high),       
        .operand2_low(operand2_low),        
        .operand2_high(operand2_high),        
        .cin(cin),       
        .result_high(result_high),        
        .result_low(result_low),        
        .cout(cout) 

    );
    initial begin
        // Initialize Inputs
        operand1_high = 0;        
        operand1_low = 0;        
        operand2_low = 0;        
        operand2_high = 0;
        cin = 0;
        // Wait 100 ns for global reset to finish
        #100;
        // Add stimulus here
    end
    always #10  operand1_low  = $random;  //$random为系统任务，产生一个随机的32位数
    always #10  operand1_high  = $random; 
    always #10  operand2_low  = $random;  //#10 表示等待10个单位时间(10ns)，即每过10ns，赋值一个随机的32位数
    always #10  operand2_high  = $random;
    always #10 cin = {$random} % 2; //加了拼接符，{$random}产生一个非负数，除2取余得到0或1
endmodule
