`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 18:07:16
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(ins,imm);
    input [31:0] ins;
    output reg [31:0] imm;
    integer k;
    always @(*) begin
        if(ins[6:0]==7'b1101111) begin //J type
            imm[19]=ins[31];
            imm[9:0]=ins[30:21];
            imm[10]=ins[20];
            imm[18:11]=ins[19:12];
            for(k=20;k<32;k=k+1)
                imm[k]=imm[19];
        end
        else if(ins[6:0]==7'b0010111 || ins[6:0]==7'b0110111) begin //U type
            imm[31:12]=ins[31:12];
            for(k=11;k>=0;k=k-1)
                imm[k]=0;
        end        
        else if(ins[6:4]==3'b000 || ins[6:4]==3'b001 || ins[6:4]==3'b111 || ins[6:0]==7'b1100111) begin //I type
            imm[11:0]=ins[31:20];
            for(k=12;k<32;k=k+1)
                imm[k]=imm[11];
        end
        else if(ins[6:4]==3'b010) begin //S type
            imm[11:5]=ins[31:25];
            imm[4:0]=ins[11:7];
            for(k=12;k<32;k=k+1)
                imm[k]=imm[11];
        end
        else if(ins[6:4]==3'b110) begin //B type
            imm[11]=ins[31];
            imm[9:4]=ins[30:25];
            imm[3:0]=ins[11:8];
            imm[10]=ins[7];
            for(k=12;k<32;k=k+1)
                imm[k]=imm[11];
        end
        else
            imm='bz;
    end
endmodule
