`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 18:20:13
// Design Name: 
// Module Name: Control
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


module Control(Inst, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);
    input [6:0] Inst;
    output reg Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
    output reg [1:0] ALUop;
    
    always@(*) begin
        Branch=0;
        MemRead=0;
        MemtoReg=0;
        MemWrite=0;
        ALUsrc=0;
        RegWrite=0;
        if(Inst==7'b1100011) begin//B type
            ALUop=2'b01;
            Branch=1;
        end
        else if(Inst==7'b0000011) begin//load
            MemRead=1;
            MemtoReg=1;
            ALUsrc=1;
            RegWrite=1;
            ALUop=2'b00;
        end
        else if(Inst==7'b0100011) begin//S type
            MemWrite=1;
            ALUsrc=1;
            ALUop=2'b00;
        end
        else if(Inst==7'b0010011) begin//addi
            ALUsrc=1;
            RegWrite=1;
            ALUop=2'b00;
        end
        else if(Inst==7'b0110011) begin//R type
            RegWrite=1;
            ALUop=2'b10;
        end
    end 
    
endmodule
