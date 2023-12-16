`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UM-SJTU JI
// Engineer: Xu Weiqing
// 
// Create Date: 2022/10/14 21:33:21
// Design Name: 
// Module Name: test1
// Project Name: lab 4
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

module sim1;
parameter half_period =3;
reg clk;
SingleCycleProcessor SCP(clk);
  initial begin
  #3 clk=0;
  forever #half_period clk = ~clk;
  end
  initial begin
  forever #6 begin
    $display("time:",$time);
    $display("PC:%b",SCP.PC_cs);
    $display("Inst:",SCP.Inst);
    $display("x5(t0):%b",SCP.RF1.regs[5]);
    $display("x6(t1):%b",SCP.RF1.regs[6]);
    $display("x7(t2):%b",SCP.RF1.regs[7]);
    $display("x28(t3):%b",SCP.RF1.regs[28]);
    $display("x29(t4):%b",SCP.RF1.regs[29]);
    $display("x8(s0):%b",SCP.RF1.regs[8]);
    $display("x9(s1):%b",SCP.RF1.regs[9]);
    $display("Mem[0]:%b",{SCP.DataMem1.regs[3],SCP.DataMem1.regs[2],SCP.DataMem1.regs[1],SCP.DataMem1.regs[0]});
    $display("Mem[4]:%b",{SCP.DataMem1.regs[7],SCP.DataMem1.regs[6],SCP.DataMem1.regs[5],SCP.DataMem1.regs[4]});
  end
  end
  initial #110 $stop;
endmodule
