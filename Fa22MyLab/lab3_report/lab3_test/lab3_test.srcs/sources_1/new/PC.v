`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 17:42:37
// Design Name: 
// Module Name: PC
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


module PC(PC_in, PC_out, clock);
    input [31:0] PC_in;
    input clock;
    output reg [31:0] PC_out;
    initial begin
        PC_out = 32'b0;
    end
    
    always@(posedge clock) begin
        PC_out <= PC_in;
    end

endmodule
