`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/20 20:47:17
// Design Name: 
// Module Name: main_memory
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


module main_memory(
    input type, //1 for write, 0 for read
    input [9:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data,
    output reg done
    );
    
    //Main memory has 256 words
    reg [31:0] regs[255:0];
    
    integer i;
    initial begin
        for(i=0;i<256;i=i+1) regs[i]=2*i;
        done=0;
    end
    
    always@(type or addr) begin
        repeat(4) begin
        if(type==1'b1) begin
            regs[addr>>2]=write_data;
        end
        if(type==1'b0) begin
            read_data=regs[addr>>2];
        end
        #2 done=1;
        #2 done=0;
        end
    end
    
    
endmodule
