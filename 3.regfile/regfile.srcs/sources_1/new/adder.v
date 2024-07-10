`timescale 1ns / 1ps
module adder(
    input  [31:0] rdata1,
    input  [31:0] rdata2,
    output [31:0] result,
    output        cout
    );
    assign {cout,result} = rdata1 + rdata2;

endmodule

