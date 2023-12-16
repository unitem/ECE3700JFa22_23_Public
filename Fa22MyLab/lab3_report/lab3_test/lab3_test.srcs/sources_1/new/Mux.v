`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 18:56:07
// Design Name: 
// Module Name: Mux
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


module Mux(in0,in1,s,out);
    input [31:0] in0,in1;
    input s;
    output reg [31:0] out;
    
    always@(*) begin
        case(s)
            1'b0:out=in0;
            1'b1:out=in1;
            default: out=0;
        endcase
    end
    
endmodule
