`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/08 11:48:09
// Design Name: 
// Module Name: reg_32
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


module reg_32(read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2, reg_write, clk);
    input [4:0] read_reg1, read_reg2, write_reg;
    input [31:0] write_data;
    input reg_write, clk;
    output reg [31:0] read_data1, read_data2;
    
    reg [31:0] regs [31:0];
    
    always @ (posedge clk) begin
        if(reg_write) regs[write_reg]=write_data;
        else begin
            read_data1=regs[read_reg1];
            read_data2=regs[read_reg2];
        end
    end
endmodule
