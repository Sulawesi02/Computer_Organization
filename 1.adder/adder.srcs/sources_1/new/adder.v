`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/15 10:23:44
// Design Name: 
// Module Name: adder
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


module adder(
    input  [31:0] operand1_high,
    input  [31:0] operand1_low,
    input  [31:0] operand2_high,
    input  [31:0] operand2_low,
    input         cin,
    output [31:0] result_high,
    output [31:0] result_low,
    output        cout,
    wire cout_low_to_high 
    );
    assign {cout_low_to_high ,result_low}=operand1_low+ operand2_low+cin;
    assign {cout,result_high} =cout_low_to_high + operand1_high +operand2_high;
endmodule
