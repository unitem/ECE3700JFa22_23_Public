`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/25 21:41:04
// Design Name: 
// Module Name: sim_DataMem
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


module sim_DataMem;
parameter half_period =3;
reg MemRead, MemWrite;
reg [31:0] addr;
reg [31:0] WriteData;
wire [31:0] ReadData;
reg clk;
DataMem uut_DataMem(MemRead, MemWrite, addr, WriteData, ReadData, clk);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 MemRead=0; MemWrite=1; WriteData=32'h000000ff; addr=4;
  #6 WriteData=32'h0000ff00; addr=16;
  #6 MemWrite=0; MemRead=1; 
  #6 WriteData=32'h0000ffff; addr=4;
  #6 MemRead=0; MemWrite=1;
  end
  initial #100 $stop;
endmodule
