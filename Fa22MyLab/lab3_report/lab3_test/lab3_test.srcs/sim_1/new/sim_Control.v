`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 21:10:44
// Design Name: 
// Module Name: sim_Control
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

module sim_Control;
parameter half_period =3;
reg [6:0] Inst;
wire Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
wire [1:0] ALUop;
reg clk;
Control uut_Control(Inst, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 Inst=7'b0110011;
  #6 Inst=7'b0010011;
  #6 Inst=7'b1100011;
  #6 Inst=7'b0000011;
  #6 Inst=7'b0100011;
  end
  initial #100 $stop;
endmodule
