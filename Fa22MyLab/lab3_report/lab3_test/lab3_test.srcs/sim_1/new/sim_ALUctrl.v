`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 21:18:07
// Design Name: 
// Module Name: sim_ALUctrl
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


module sim_ALUctrl;
parameter half_period =3;
reg [3:0] Inst;
reg [1:0] ALUop;
wire [3:0] Aluctrl;
reg clk;
ALUctrl uut_AC(Inst, ALUop, Aluctrl);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 ALUop=0;
  #6 Inst=4'b0010;
  #6 Inst=4'b0000;
  #6 ALUop=1; Inst=4'b0000;
  #6 Inst=4'b0001;
  #6 ALUop=2; Inst=4'b0000;
  #6 Inst=4'b1000;
  #6 Inst=4'b0111;
  #6 Inst=4'b0110;
  end
  initial #100 $stop;
endmodule
