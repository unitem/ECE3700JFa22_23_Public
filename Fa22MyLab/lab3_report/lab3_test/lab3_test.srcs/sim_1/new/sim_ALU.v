`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 19:33:31
// Design Name: 
// Module Name: sim_reg
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


module sim_ALU;
parameter half_period =3;
reg [31:0] in1, in2;
reg [3:0] Aluctrl;
wire zero;
wire [31:0] result;
reg clk;
ALU uut_ALU(in1, in2, Aluctrl, zero, result);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 in1=10; in2=7; Aluctrl=5'b0010;
  #6 Aluctrl=4'b0000;
  #6 Aluctrl=4'b0001;
  #6 in1=3; in2=12;
  #6 Aluctrl=4'b0110; 
  #6 in1=12;
  end
  initial #100 $stop;
endmodule
