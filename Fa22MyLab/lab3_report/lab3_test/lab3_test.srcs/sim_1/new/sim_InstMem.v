`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 21:32:22
// Design Name: 
// Module Name: sim_InstMem
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


module sim_InstMem;
parameter half_period =3;
reg [31:0] PC;
wire [31:0] Inst;
reg clk;
InstMem uut_InstMem(PC, Inst);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  PC=0;
  forever #6 PC=PC+4;
  end
  initial #100 $stop;
endmodule

