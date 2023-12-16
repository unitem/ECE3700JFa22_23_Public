`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 20:54:14
// Design Name: 
// Module Name: sim_Adder
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


module sim_Adder;
parameter half_period =3;
reg [31:0] input1, input2;
wire [31:0] out;
reg clk;
Adder uut_Adder(input1, input2, out);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 input1=10;
  #6 input2=21;
  #6 input1=-30;
  #6 input2=-6;
  end
  initial #100 $stop;
endmodule
