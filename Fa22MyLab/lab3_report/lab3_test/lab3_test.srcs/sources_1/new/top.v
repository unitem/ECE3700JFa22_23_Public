`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 19:48:15
// Design Name: 
// Module Name: SingleCycleProcessor
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


module SingleCycleProcessor(clock);
    input clock;
    
    wire [31:0] PC_cs, PC_ns, PC_add4, Inst, WriteData, ReadData1, ReadData2, ALUresult, ReadData, Imm, ALUin, ImmShift, PC_offset;
    wire Branch, MemRead, MemWrite, ALUsrc, MemtoReg, RegWrite, zero, PC_s;
    wire [1:0] ALUop;
    wire [3:0] Aluctrl;
    
    
    PC PC1(PC_ns, PC_cs, clock);
    Adder Adder1(PC_cs, 32'h00000004, PC_add4);
    InstMem InstMem1(PC_cs, Inst);
    Control Control1(Inst[6:0], Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);
    RegisterFile RF1(Inst[19:15], Inst[24:20], Inst[11:7], WriteData, ReadData1, ReadData2, RegWrite, clock);
    ImmGen IG1(Inst, Imm);
    ALUctrl AC1({Inst[30], Inst[14:12]}, ALUop, Aluctrl);
    Mux Mux1(ReadData2, Imm, ALUsrc, ALUin);
    ALU ALU1(ReadData1, ALUin, Aluctrl, zero, ALUresult);
    DataMem DataMem1(MemRead, MemWrite, ALUresult, ReadData2, ReadData, clock);
    Mux Mux2(ALUresult, ReadData, MemtoReg, WriteData);
    Shifter Shifter1(Imm, ImmShift);
    Adder Adder2(PC_cs, ImmShift, PC_offset);
    assign PC_s=  Branch && zero;
    Mux Mux3(PC_add4, PC_offset, PC_s, PC_ns);
    
endmodule
