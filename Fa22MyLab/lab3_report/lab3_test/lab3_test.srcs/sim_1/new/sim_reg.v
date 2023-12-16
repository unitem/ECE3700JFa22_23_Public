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


module sim_reg;
parameter half_period =3;
reg [4:0] read_reg1, read_reg2, write_reg;
reg [31:0] write_data;
reg reg_write, clk;
wire [31:0] read_data1, read_data2;
reg clk;
RegisterFile rf(read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2, reg_write, clk);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  #6 reg_write=1; write_data=32'h000000ff; write_reg=5'b00010;
  #6 reg_write=0; write_data=32'h0000ff00; write_reg=5'b00100;
  #6 read_reg1=5'b00100;
  #6 reg_write=1;
  #6 read_reg2=5'b00010; 
  end
  initial #100 $stop;
endmodule
