`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/08 12:00:14
// Design Name: 
// Module Name: test
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


module test1;
reg [31:0] ins;
wire [31:0] imm;
ImmGen IG(ins,imm);
  initial begin
  #0 ins=32'h005c8cb3;//R type
  #20 ins=32'hfff28293; //I type
  #20 ins=32'hff512823; //S type
  #20 ins=32'h00505463; //B type
  #20 ins=32'h0100006f; //J type
  #20 ins=32'hf7f7f037; //U type
  end
  initial #2000 $stop;
endmodule
