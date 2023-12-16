`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/13 12:00:10
// Design Name: 
// Module Name: Hazard
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


module Hazard
(
    input [4:0] IF_ID_r1,
    input [4:0] IF_ID_r2,
    input [4:0] ID_EX_RegRd,
    input [4:0] EX_MEM_RegRd,
    input ID_EX_MemRead,
    input EX_MEM_MemRead,
    input ID_branch,//for b_type hazard
    input ID_MemWrite,
    input ID_EX_RegWrite,
    output reg PC_write, IF_ID_write, mux_con 
    );

    initial begin
        PC_write=1'b1; 
        IF_ID_write=1'b1; 
        mux_con=1'b1;
    end

    always @(*) begin 
        if (ID_EX_MemRead && !ID_MemWrite) begin//LW HAZARD
            if (ID_EX_RegRd == IF_ID_r1 || ID_EX_RegRd == IF_ID_r2) begin
                PC_write=1'b0; 
                IF_ID_write=1'b0; 
                mux_con=1'b0;
            end
            else begin
                PC_write=1'b1; 
                IF_ID_write=1'b1; 
                mux_con=1'b1;
            end  
        end
        else if (ID_branch && ID_EX_RegWrite) begin//BEQ HAZARD FOR R/LW 
            if ((ID_EX_RegRd!=0) && (IF_ID_r1 == ID_EX_RegRd || IF_ID_r2 == ID_EX_RegRd)) begin
                PC_write=1'b0; 
                IF_ID_write=1'b0;
                mux_con=1'b0;
            end
            else begin
                PC_write=1'b1; 
                IF_ID_write=1'b1;
                mux_con=1'b1;
            end  
        end
        else if (ID_branch && EX_MEM_MemRead) begin//BEQ HAZARD FOR LW (ADD THE SECOND NOP)
            if ((EX_MEM_RegRd!=0) && (IF_ID_r1 == EX_MEM_RegRd || IF_ID_r2 == EX_MEM_RegRd)) begin
                PC_write=1'b0; 
                IF_ID_write=1'b0;
                mux_con=1'b0;
            end
            else begin
                PC_write=1'b1; 
                IF_ID_write=1'b1;
                mux_con=1'b1;
            end  
        end
        else begin
            PC_write=1'b1; 
            IF_ID_write=1'b1; 
            mux_con=1'b1;
        end
    end
endmodule
