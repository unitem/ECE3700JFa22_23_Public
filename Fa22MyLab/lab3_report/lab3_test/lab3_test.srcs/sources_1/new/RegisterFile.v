`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 17:58:38
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2, reg_write, clk);
    input [4:0] read_reg1, read_reg2, write_reg;
    input [31:0] write_data;
    input reg_write, clk;
    output [31:0] read_data1, read_data2;
    
    reg [31:0] regs [31:0];
    integer i;
    
    initial
        begin
            for(i=0;i<32;i=i+1)
                regs[i]<=32'b0;
        end
    
    always @ (posedge clk) begin
        if(reg_write && (write_reg!=5'b0)) regs[write_reg]=write_data;
    end
    assign read_data1=regs[read_reg1];
    assign read_data2=regs[read_reg2];
endmodule
