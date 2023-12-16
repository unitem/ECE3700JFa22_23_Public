`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 20:01:55
// Design Name: 
// Module Name: ALU
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


module ALU(in1, in2, Aluctrl, zero, result);
    input [31:0] in1, in2;
    input [3:0] Aluctrl;
    output reg zero;
    output reg [31:0] result;
    
    always@(*) begin
        case(Aluctrl)
            4'b0000: result=in1&in2;
            4'b0001: result=in1|in2;
            4'b0010: result=in1+in2;
            4'b0110: result=in1-in2;
            4'b0111: result=in1-in2;
            default: result=0;
        endcase
        if(result!=0 && Aluctrl==4'b0111)
            zero=1;
        else if(result==0 && Aluctrl!=4'b0111)
            zero=1;
        else
            zero=0;
    end
    
endmodule
