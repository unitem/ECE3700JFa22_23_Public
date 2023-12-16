`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 17:51:29
// Design Name: 
// Module Name: InstMem
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


module InstMem(PC, Inst);
    input [31:0] PC;
    output [31:0] Inst;
    
    reg [31:0] regs[17:0];
    
    initial
        begin
            $readmemb("D:/campus/VE370/lab/lab3_test/Test.txt", regs);
        end
    assign Inst=regs[PC[31:2]];
endmodule
