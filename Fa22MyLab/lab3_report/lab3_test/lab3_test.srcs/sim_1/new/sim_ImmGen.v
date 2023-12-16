`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 21:01:00
// Design Name: 
// Module Name: sim_ImmGen
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


module sim_ImmGen;
parameter half_period =3;
reg [31:0] ins;
wire [31:0] imm;
reg clk;
ImmGen uut_ImmGen(ins, imm);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 ins=32'b11111111100001000010001010000011;
  #6 ins=32'b11111111011000101000001100010011;
  #6 ins=32'b00000010100000010010000000100011;
  #6 ins=32'b00000001000101000000001110010011;
  end
  initial #100 $stop;
endmodule
