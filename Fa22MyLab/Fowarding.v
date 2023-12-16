`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/13 12:04:21
// Design Name: 
// Module Name: Fowarding
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


module Forwarding
(
    input [4:0] ID_EX_r1,
    input [4:0] ID_EX_r2,
    input [4:0] IF_ID_r1,
    input [4:0] IF_ID_r2,
    input [4:0] EX_MEM_r2, 
    
    input [4:0] MEM_WB_RegRd,
    input [4:0] EX_MEM_RegRd,
    input [4:0] ID_EX_RegRd,
    
    input MEM_WB_RegWrite, 
    input EX_MEM_RegWrite,
    input EX_MEM_MemWrite,

    input EX_MEM_MemRead,
    input MEM_WB_MemRead,
    
    input ID_EX_MemRead,
    input ID_EX_MemWrite,
    input ID_EX_RegWrite,
    input IF_ID_branch,
    
    output reg [1:0] Forwarding_A,
    output reg [1:0] Forwarding_B,
    output reg Forwarding_Eq1,
    output reg Forwarding_Eq2,
    output reg MemSrc
    );
    
    initial begin
        Forwarding_A = 2'b00;
        Forwarding_B = 2'b00;
        Forwarding_Eq1 = 1'b0;
        Forwarding_Eq2 = 1'b0;
        MemSrc = 1'b0; 
    end
    
    always @(*) begin
    //ForwardingA
        //EX
        if (EX_MEM_RegWrite && (EX_MEM_RegRd!=0) && EX_MEM_RegRd == ID_EX_r1 && !EX_MEM_MemRead && !ID_EX_MemRead && !ID_EX_MemWrite)
            Forwarding_A = 2'b10;
        //MEM
        else if (MEM_WB_RegWrite && (MEM_WB_RegRd!=0) && MEM_WB_RegRd == ID_EX_r1)
            Forwarding_A = 2'b01;
        else
            Forwarding_A = 2'b00;
    
    //ForwardingB
         //EX
        if (EX_MEM_RegWrite && (EX_MEM_RegRd!=0) && EX_MEM_RegRd == ID_EX_r2 && !EX_MEM_MemRead && !ID_EX_MemRead && !ID_EX_MemWrite) 
            Forwarding_B = 2'b10;
         //MEM
        else if (MEM_WB_RegWrite && (MEM_WB_RegRd!=0) && MEM_WB_RegRd == ID_EX_r2) 
            Forwarding_B = 2'b01;
        else
            Forwarding_B = 2'b00;
   
    //Memsrc
        if (MEM_WB_RegRd == EX_MEM_r2 && EX_MEM_MemWrite) 
            MemSrc = 1'b1;
        else
            MemSrc = 1'b0;

    //ForwardingEq
        if (EX_MEM_RegWrite && (EX_MEM_RegRd!=0) && EX_MEM_RegRd == IF_ID_r1 && IF_ID_branch)
            Forwarding_Eq1 = 1'b1;
        else
            Forwarding_Eq1 = 1'b0;
        
        if (EX_MEM_RegWrite && (EX_MEM_RegRd!=0) && EX_MEM_RegRd == IF_ID_r2 && IF_ID_branch)
            Forwarding_Eq2 = 1'b1; 
        else
            Forwarding_Eq2 = 1'b0; 

    end

endmodule
