`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 21:26:58
// Design Name: 
// Module Name: sim_MUX
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


module sim_MUX;
parameter half_period =3;
reg [31:0] in0,in1;
reg s;
wire [31:0] out;
reg clk;
Mux uut_Mux(in0,in1,s,out);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 in0=10; in1=20; s=0;
  #6 s=1;
  #6 in1=30;
  end
  initial #100 $stop;
endmodule
