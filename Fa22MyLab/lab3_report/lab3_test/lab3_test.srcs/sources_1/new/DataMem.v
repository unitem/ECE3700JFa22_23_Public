`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 19:26:31
// Design Name: 
// Module Name: DataMem
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


module DataMem(MemRead, MemWrite, addr, WriteData, ReadData, clock);
    input MemRead, MemWrite, clock;
    input [31:0] addr;
    input [31:0] WriteData;
    output [31:0] ReadData;
    
    reg [7:0] regs[127:0];
    integer i;
    
    initial begin
        for(i=0;i<128;i=i+1)
            regs[i]=8'b00000000;
    end
    
    assign ReadData=(MemRead==1'b1)?{regs[addr+3], regs[addr+2], regs[addr+1], regs[addr]}:0;
    
    always@(posedge clock) begin
        if(MemWrite) begin
            regs[addr+3]<=WriteData[31:24];
            regs[addr+2]<=WriteData[23:16];
            regs[addr+1]<=WriteData[15:8];
            regs[addr]<=WriteData[7:0];
        end
    end
    
endmodule
