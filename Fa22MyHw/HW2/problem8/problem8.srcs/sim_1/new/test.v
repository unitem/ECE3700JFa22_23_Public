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
parameter half_period =3;
reg [4:0] read_reg1, read_reg2, write_reg;
reg [31:0] write_data;
reg reg_write, clk;
wire [31:0] read_data1, read_data2;
reg_32  regfile(read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2, reg_write, clk );
  initial begin
  #0 clk=0; write_reg=0;
  #20 reg_write=1; write_reg=7; write_data=32'hffff7777;
  #40 reg_write=0; write_reg=9;
  #60 reg_write=1;
  #80 write_data=32'h7777ffff;
  #100 write_reg=11;
  #120 read_reg1=7;
  #140 reg_write=0;
  #160 read_reg2=9;
  end
  always #half_period clk = ~clk;
  initial #2000 $stop;
endmodule
