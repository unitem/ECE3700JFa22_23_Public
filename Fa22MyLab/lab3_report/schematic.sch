# File saved with Nlview 7.0r6  2020-01-29 bk=1.5227 VDI=41 GEI=36 GUI=JA:9.0 non-TLS-threadsafe
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 15
property maxzoom 6.25
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #ff6666
property objecthighlight4 #0000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 15
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new SingleCycleProcessor work:SingleCycleProcessor:NOFILE -nosplit
load symbol ALUctrl work:ALUctrl:NOFILE HIERBOX pinBus ALUop input.left [1:0] pinBus Aluctrl output.right [3:0] pinBus Inst input.left [3:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol ALU work:ALU:NOFILE HIERBOX pin zero output.right pinBus Aluctrl input.left [3:0] pinBus in1 input.left [31:0] pinBus in2 input.left [31:0] pinBus result output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Adder work:Adder:NOFILE HIERBOX pinBus input1 input.left [31:0] pinBus input2 input.left [31:0] pinBus out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Adder work:abstract:NOFILE HIERBOX pinBus input1 input.left [31:0] pinBus input2 input.left [31:0] pinBus out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Control work:Control:NOFILE HIERBOX pin ALUsrc output.right pin Branch output.right pin MemRead output.right pin MemWrite output.right pin MemtoReg output.right pin RegWrite output.right pinBus ALUop output.right [1:0] pinBus Inst input.left [6:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol DataMem work:DataMem:NOFILE HIERBOX pin MemRead input.left pin MemWrite input.left pin clock input.left pinBus ReadData output.right [31:0] pinBus WriteData input.left [31:0] pinBus addr input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol ImmGen work:ImmGen:NOFILE HIERBOX pinBus imm output.right [31:0] pinBus ins input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol InstMem work:InstMem:NOFILE HIERBOX pinBus Inst output.right [31:0] pinBus PC input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Mux work:Mux:NOFILE HIERBOX pin s input.left pinBus in0 input.left [31:0] pinBus in1 input.left [31:0] pinBus out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Mux work:abstract:NOFILE HIERBOX pin s input.left pinBus in0 input.left [31:0] pinBus in1 input.left [31:0] pinBus out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol PC work:PC:NOFILE HIERBOX pin clock input.left pinBus PC_in input.left [31:0] pinBus PC_out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_AND work AND pin I0 input pin I1 input pin O output fillcolor 1
load symbol RegisterFile work:RegisterFile:NOFILE HIERBOX pin clk input.left pin reg_write input.left pinBus read_data1 output.right [31:0] pinBus read_data2 output.right [31:0] pinBus read_reg1 input.left [4:0] pinBus read_reg2 input.left [4:0] pinBus write_data input.left [31:0] pinBus write_reg input.left [4:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Shifter work:Shifter:NOFILE HIERBOX pinBus in input.left [31:0] pinBus out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load port clock input -pg 1 -lvl 0 -x 0 -y 380
load inst AC1 ALUctrl work:ALUctrl:NOFILE -autohide -attr @cell(#000000) ALUctrl -pinBusAttr ALUop @name ALUop[1:0] -pinBusAttr Aluctrl @name Aluctrl[3:0] -pinBusAttr Inst @name Inst[3:0] -pg 1 -lvl 10 -x 2870 -y 250
load inst ALU1 ALU work:ALU:NOFILE -autohide -attr @cell(#000000) ALU -pinBusAttr Aluctrl @name Aluctrl[3:0] -pinBusAttr in1 @name in1[31:0] -pinBusAttr in2 @name in2[31:0] -pinBusAttr result @name result[31:0] -pg 1 -lvl 4 -x 1170 -y 370
load inst Adder1 Adder work:Adder:NOFILE -autohide -attr @cell(#000000) Adder -pinBusAttr input1 @name input1[31:0] -pinBusAttr input2 @name input2[31:0] -pinBusAttr input2 @attr V=X\"00000004\" -pinBusAttr out @name out[31:0] -pg 1 -lvl 5 -x 1530 -y 590
load inst Adder2 Adder work:abstract:NOFILE -autohide -attr @cell(#000000) Adder -pinBusAttr input1 @name input1[31:0] -pinBusAttr input2 @name input2[31:0] -pinBusAttr out @name out[31:0] -pg 1 -lvl 5 -x 1530 -y 730
load inst Control1 Control work:Control:NOFILE -autohide -attr @cell(#000000) Control -pinBusAttr ALUop @name ALUop[1:0] -pinBusAttr Inst @name Inst[6:0] -pg 1 -lvl 9 -x 2490 -y 50
load inst DataMem1 DataMem work:DataMem:NOFILE -autohide -attr @cell(#000000) DataMem -pinBusAttr ReadData @name ReadData[31:0] -pinBusAttr WriteData @name WriteData[31:0] -pinBusAttr addr @name addr[31:0] -pg 1 -lvl 1 -x 180 -y 290
load inst IG1 ImmGen work:ImmGen:NOFILE -autohide -attr @cell(#000000) ImmGen -pinBusAttr imm @name imm[31:0] -pinBusAttr ins @name ins[31:0] -pg 1 -lvl 2 -x 500 -y 570
load inst InstMem1 InstMem work:InstMem:NOFILE -autohide -attr @cell(#000000) InstMem -pinBusAttr Inst @name Inst[31:0] -pinBusAttr PC @name PC[31:0] -pg 1 -lvl 8 -x 2260 -y 570
load inst Mux1 Mux work:Mux:NOFILE -autohide -attr @cell(#000000) Mux -pinBusAttr in0 @name in0[31:0] -pinBusAttr in1 @name in1[31:0] -pinBusAttr out @name out[31:0] -pg 1 -lvl 3 -x 850 -y 570
load inst Mux2 Mux work:abstract:NOFILE -autohide -attr @cell(#000000) Mux -pinBusAttr in0 @name in0[31:0] -pinBusAttr in1 @name in1[31:0] -pinBusAttr out @name out[31:0] -pg 1 -lvl 2 -x 500 -y 410
load inst Mux3 Mux work:abstract:NOFILE -autohide -attr @cell(#000000) Mux -pinBusAttr in0 @name in0[31:0] -pinBusAttr in1 @name in1[31:0] -pinBusAttr out @name out[31:0] -pg 1 -lvl 6 -x 1770 -y 590
load inst PC1 PC work:PC:NOFILE -autohide -attr @cell(#000000) PC -pinBusAttr PC_in @name PC_in[31:0] -pinBusAttr PC_out @name PC_out[31:0] -pg 1 -lvl 7 -x 2010 -y 610
load inst PC_s_i RTL_AND work -attr @cell(#000000) RTL_AND -pg 1 -lvl 5 -x 1530 -y 390
load inst RF1 RegisterFile work:RegisterFile:NOFILE -autohide -attr @cell(#000000) RegisterFile -pinBusAttr read_data1 @name read_data1[31:0] -pinBusAttr read_data2 @name read_data2[31:0] -pinBusAttr read_reg1 @name read_reg1[4:0] -pinBusAttr read_reg2 @name read_reg2[4:0] -pinBusAttr write_data @name write_data[31:0] -pinBusAttr write_reg @name write_reg[4:0] -pg 1 -lvl 3 -x 850 -y 350
load inst Shifter1 Shifter work:Shifter:NOFILE -autohide -attr @cell(#000000) Shifter -pinBusAttr in @name in[31:0] -pinBusAttr out @name out[31:0] -pg 1 -lvl 4 -x 1170 -y 750
load net <const0> -ground -pin Adder1 input2[31] -pin Adder1 input2[30] -pin Adder1 input2[29] -pin Adder1 input2[28] -pin Adder1 input2[27] -pin Adder1 input2[26] -pin Adder1 input2[25] -pin Adder1 input2[24] -pin Adder1 input2[23] -pin Adder1 input2[22] -pin Adder1 input2[21] -pin Adder1 input2[20] -pin Adder1 input2[19] -pin Adder1 input2[18] -pin Adder1 input2[17] -pin Adder1 input2[16] -pin Adder1 input2[15] -pin Adder1 input2[14] -pin Adder1 input2[13] -pin Adder1 input2[12] -pin Adder1 input2[11] -pin Adder1 input2[10] -pin Adder1 input2[9] -pin Adder1 input2[8] -pin Adder1 input2[7] -pin Adder1 input2[6] -pin Adder1 input2[5] -pin Adder1 input2[4] -pin Adder1 input2[3] -pin Adder1 input2[1] -pin Adder1 input2[0]
load net <const1> -power -attr @rip 2 -pin Adder1 input2[2]
load net ALUin[0] -attr @rip out[0] -pin ALU1 in2[0] -pin Mux1 out[0]
load net ALUin[10] -attr @rip out[10] -pin ALU1 in2[10] -pin Mux1 out[10]
load net ALUin[11] -attr @rip out[11] -pin ALU1 in2[11] -pin Mux1 out[11]
load net ALUin[12] -attr @rip out[12] -pin ALU1 in2[12] -pin Mux1 out[12]
load net ALUin[13] -attr @rip out[13] -pin ALU1 in2[13] -pin Mux1 out[13]
load net ALUin[14] -attr @rip out[14] -pin ALU1 in2[14] -pin Mux1 out[14]
load net ALUin[15] -attr @rip out[15] -pin ALU1 in2[15] -pin Mux1 out[15]
load net ALUin[16] -attr @rip out[16] -pin ALU1 in2[16] -pin Mux1 out[16]
load net ALUin[17] -attr @rip out[17] -pin ALU1 in2[17] -pin Mux1 out[17]
load net ALUin[18] -attr @rip out[18] -pin ALU1 in2[18] -pin Mux1 out[18]
load net ALUin[19] -attr @rip out[19] -pin ALU1 in2[19] -pin Mux1 out[19]
load net ALUin[1] -attr @rip out[1] -pin ALU1 in2[1] -pin Mux1 out[1]
load net ALUin[20] -attr @rip out[20] -pin ALU1 in2[20] -pin Mux1 out[20]
load net ALUin[21] -attr @rip out[21] -pin ALU1 in2[21] -pin Mux1 out[21]
load net ALUin[22] -attr @rip out[22] -pin ALU1 in2[22] -pin Mux1 out[22]
load net ALUin[23] -attr @rip out[23] -pin ALU1 in2[23] -pin Mux1 out[23]
load net ALUin[24] -attr @rip out[24] -pin ALU1 in2[24] -pin Mux1 out[24]
load net ALUin[25] -attr @rip out[25] -pin ALU1 in2[25] -pin Mux1 out[25]
load net ALUin[26] -attr @rip out[26] -pin ALU1 in2[26] -pin Mux1 out[26]
load net ALUin[27] -attr @rip out[27] -pin ALU1 in2[27] -pin Mux1 out[27]
load net ALUin[28] -attr @rip out[28] -pin ALU1 in2[28] -pin Mux1 out[28]
load net ALUin[29] -attr @rip out[29] -pin ALU1 in2[29] -pin Mux1 out[29]
load net ALUin[2] -attr @rip out[2] -pin ALU1 in2[2] -pin Mux1 out[2]
load net ALUin[30] -attr @rip out[30] -pin ALU1 in2[30] -pin Mux1 out[30]
load net ALUin[31] -attr @rip out[31] -pin ALU1 in2[31] -pin Mux1 out[31]
load net ALUin[3] -attr @rip out[3] -pin ALU1 in2[3] -pin Mux1 out[3]
load net ALUin[4] -attr @rip out[4] -pin ALU1 in2[4] -pin Mux1 out[4]
load net ALUin[5] -attr @rip out[5] -pin ALU1 in2[5] -pin Mux1 out[5]
load net ALUin[6] -attr @rip out[6] -pin ALU1 in2[6] -pin Mux1 out[6]
load net ALUin[7] -attr @rip out[7] -pin ALU1 in2[7] -pin Mux1 out[7]
load net ALUin[8] -attr @rip out[8] -pin ALU1 in2[8] -pin Mux1 out[8]
load net ALUin[9] -attr @rip out[9] -pin ALU1 in2[9] -pin Mux1 out[9]
load net ALUop[0] -attr @rip ALUop[0] -pin AC1 ALUop[0] -pin Control1 ALUop[0]
load net ALUop[1] -attr @rip ALUop[1] -pin AC1 ALUop[1] -pin Control1 ALUop[1]
load net ALUresult[0] -attr @rip result[0] -pin ALU1 result[0] -pin DataMem1 addr[0] -pin Mux2 in0[0]
load net ALUresult[10] -attr @rip result[10] -pin ALU1 result[10] -pin DataMem1 addr[10] -pin Mux2 in0[10]
load net ALUresult[11] -attr @rip result[11] -pin ALU1 result[11] -pin DataMem1 addr[11] -pin Mux2 in0[11]
load net ALUresult[12] -attr @rip result[12] -pin ALU1 result[12] -pin DataMem1 addr[12] -pin Mux2 in0[12]
load net ALUresult[13] -attr @rip result[13] -pin ALU1 result[13] -pin DataMem1 addr[13] -pin Mux2 in0[13]
load net ALUresult[14] -attr @rip result[14] -pin ALU1 result[14] -pin DataMem1 addr[14] -pin Mux2 in0[14]
load net ALUresult[15] -attr @rip result[15] -pin ALU1 result[15] -pin DataMem1 addr[15] -pin Mux2 in0[15]
load net ALUresult[16] -attr @rip result[16] -pin ALU1 result[16] -pin DataMem1 addr[16] -pin Mux2 in0[16]
load net ALUresult[17] -attr @rip result[17] -pin ALU1 result[17] -pin DataMem1 addr[17] -pin Mux2 in0[17]
load net ALUresult[18] -attr @rip result[18] -pin ALU1 result[18] -pin DataMem1 addr[18] -pin Mux2 in0[18]
load net ALUresult[19] -attr @rip result[19] -pin ALU1 result[19] -pin DataMem1 addr[19] -pin Mux2 in0[19]
load net ALUresult[1] -attr @rip result[1] -pin ALU1 result[1] -pin DataMem1 addr[1] -pin Mux2 in0[1]
load net ALUresult[20] -attr @rip result[20] -pin ALU1 result[20] -pin DataMem1 addr[20] -pin Mux2 in0[20]
load net ALUresult[21] -attr @rip result[21] -pin ALU1 result[21] -pin DataMem1 addr[21] -pin Mux2 in0[21]
load net ALUresult[22] -attr @rip result[22] -pin ALU1 result[22] -pin DataMem1 addr[22] -pin Mux2 in0[22]
load net ALUresult[23] -attr @rip result[23] -pin ALU1 result[23] -pin DataMem1 addr[23] -pin Mux2 in0[23]
load net ALUresult[24] -attr @rip result[24] -pin ALU1 result[24] -pin DataMem1 addr[24] -pin Mux2 in0[24]
load net ALUresult[25] -attr @rip result[25] -pin ALU1 result[25] -pin DataMem1 addr[25] -pin Mux2 in0[25]
load net ALUresult[26] -attr @rip result[26] -pin ALU1 result[26] -pin DataMem1 addr[26] -pin Mux2 in0[26]
load net ALUresult[27] -attr @rip result[27] -pin ALU1 result[27] -pin DataMem1 addr[27] -pin Mux2 in0[27]
load net ALUresult[28] -attr @rip result[28] -pin ALU1 result[28] -pin DataMem1 addr[28] -pin Mux2 in0[28]
load net ALUresult[29] -attr @rip result[29] -pin ALU1 result[29] -pin DataMem1 addr[29] -pin Mux2 in0[29]
load net ALUresult[2] -attr @rip result[2] -pin ALU1 result[2] -pin DataMem1 addr[2] -pin Mux2 in0[2]
load net ALUresult[30] -attr @rip result[30] -pin ALU1 result[30] -pin DataMem1 addr[30] -pin Mux2 in0[30]
load net ALUresult[31] -attr @rip result[31] -pin ALU1 result[31] -pin DataMem1 addr[31] -pin Mux2 in0[31]
load net ALUresult[3] -attr @rip result[3] -pin ALU1 result[3] -pin DataMem1 addr[3] -pin Mux2 in0[3]
load net ALUresult[4] -attr @rip result[4] -pin ALU1 result[4] -pin DataMem1 addr[4] -pin Mux2 in0[4]
load net ALUresult[5] -attr @rip result[5] -pin ALU1 result[5] -pin DataMem1 addr[5] -pin Mux2 in0[5]
load net ALUresult[6] -attr @rip result[6] -pin ALU1 result[6] -pin DataMem1 addr[6] -pin Mux2 in0[6]
load net ALUresult[7] -attr @rip result[7] -pin ALU1 result[7] -pin DataMem1 addr[7] -pin Mux2 in0[7]
load net ALUresult[8] -attr @rip result[8] -pin ALU1 result[8] -pin DataMem1 addr[8] -pin Mux2 in0[8]
load net ALUresult[9] -attr @rip result[9] -pin ALU1 result[9] -pin DataMem1 addr[9] -pin Mux2 in0[9]
load net ALUsrc -pin Control1 ALUsrc -pin Mux1 s
netloc ALUsrc 1 2 8 730 660 1080J 520 NJ 520 NJ 520 NJ 520 NJ 520 NJ 520 2750
load net Aluctrl[0] -attr @rip Aluctrl[0] -pin AC1 Aluctrl[0] -pin ALU1 Aluctrl[0]
load net Aluctrl[1] -attr @rip Aluctrl[1] -pin AC1 Aluctrl[1] -pin ALU1 Aluctrl[1]
load net Aluctrl[2] -attr @rip Aluctrl[2] -pin AC1 Aluctrl[2] -pin ALU1 Aluctrl[2]
load net Aluctrl[3] -attr @rip Aluctrl[3] -pin AC1 Aluctrl[3] -pin ALU1 Aluctrl[3]
load net Branch -pin Control1 Branch -pin PC_s_i I0
netloc Branch 1 4 6 1350 340 NJ 340 NJ 340 NJ 340 NJ 340 2730
load net ImmShift[0] -attr @rip out[0] -pin Adder2 input2[0] -pin Shifter1 out[0]
load net ImmShift[10] -attr @rip out[10] -pin Adder2 input2[10] -pin Shifter1 out[10]
load net ImmShift[11] -attr @rip out[11] -pin Adder2 input2[11] -pin Shifter1 out[11]
load net ImmShift[12] -attr @rip out[12] -pin Adder2 input2[12] -pin Shifter1 out[12]
load net ImmShift[13] -attr @rip out[13] -pin Adder2 input2[13] -pin Shifter1 out[13]
load net ImmShift[14] -attr @rip out[14] -pin Adder2 input2[14] -pin Shifter1 out[14]
load net ImmShift[15] -attr @rip out[15] -pin Adder2 input2[15] -pin Shifter1 out[15]
load net ImmShift[16] -attr @rip out[16] -pin Adder2 input2[16] -pin Shifter1 out[16]
load net ImmShift[17] -attr @rip out[17] -pin Adder2 input2[17] -pin Shifter1 out[17]
load net ImmShift[18] -attr @rip out[18] -pin Adder2 input2[18] -pin Shifter1 out[18]
load net ImmShift[19] -attr @rip out[19] -pin Adder2 input2[19] -pin Shifter1 out[19]
load net ImmShift[1] -attr @rip out[1] -pin Adder2 input2[1] -pin Shifter1 out[1]
load net ImmShift[20] -attr @rip out[20] -pin Adder2 input2[20] -pin Shifter1 out[20]
load net ImmShift[21] -attr @rip out[21] -pin Adder2 input2[21] -pin Shifter1 out[21]
load net ImmShift[22] -attr @rip out[22] -pin Adder2 input2[22] -pin Shifter1 out[22]
load net ImmShift[23] -attr @rip out[23] -pin Adder2 input2[23] -pin Shifter1 out[23]
load net ImmShift[24] -attr @rip out[24] -pin Adder2 input2[24] -pin Shifter1 out[24]
load net ImmShift[25] -attr @rip out[25] -pin Adder2 input2[25] -pin Shifter1 out[25]
load net ImmShift[26] -attr @rip out[26] -pin Adder2 input2[26] -pin Shifter1 out[26]
load net ImmShift[27] -attr @rip out[27] -pin Adder2 input2[27] -pin Shifter1 out[27]
load net ImmShift[28] -attr @rip out[28] -pin Adder2 input2[28] -pin Shifter1 out[28]
load net ImmShift[29] -attr @rip out[29] -pin Adder2 input2[29] -pin Shifter1 out[29]
load net ImmShift[2] -attr @rip out[2] -pin Adder2 input2[2] -pin Shifter1 out[2]
load net ImmShift[30] -attr @rip out[30] -pin Adder2 input2[30] -pin Shifter1 out[30]
load net ImmShift[31] -attr @rip out[31] -pin Adder2 input2[31] -pin Shifter1 out[31]
load net ImmShift[3] -attr @rip out[3] -pin Adder2 input2[3] -pin Shifter1 out[3]
load net ImmShift[4] -attr @rip out[4] -pin Adder2 input2[4] -pin Shifter1 out[4]
load net ImmShift[5] -attr @rip out[5] -pin Adder2 input2[5] -pin Shifter1 out[5]
load net ImmShift[6] -attr @rip out[6] -pin Adder2 input2[6] -pin Shifter1 out[6]
load net ImmShift[7] -attr @rip out[7] -pin Adder2 input2[7] -pin Shifter1 out[7]
load net ImmShift[8] -attr @rip out[8] -pin Adder2 input2[8] -pin Shifter1 out[8]
load net ImmShift[9] -attr @rip out[9] -pin Adder2 input2[9] -pin Shifter1 out[9]
load net Imm[0] -attr @rip imm[0] -pin IG1 imm[0] -pin Mux1 in1[0] -pin Shifter1 in[0]
load net Imm[10] -attr @rip imm[10] -pin IG1 imm[10] -pin Mux1 in1[10] -pin Shifter1 in[10]
load net Imm[11] -attr @rip imm[11] -pin IG1 imm[11] -pin Mux1 in1[11] -pin Shifter1 in[11]
load net Imm[12] -attr @rip imm[12] -pin IG1 imm[12] -pin Mux1 in1[12] -pin Shifter1 in[12]
load net Imm[13] -attr @rip imm[13] -pin IG1 imm[13] -pin Mux1 in1[13] -pin Shifter1 in[13]
load net Imm[14] -attr @rip imm[14] -pin IG1 imm[14] -pin Mux1 in1[14] -pin Shifter1 in[14]
load net Imm[15] -attr @rip imm[15] -pin IG1 imm[15] -pin Mux1 in1[15] -pin Shifter1 in[15]
load net Imm[16] -attr @rip imm[16] -pin IG1 imm[16] -pin Mux1 in1[16] -pin Shifter1 in[16]
load net Imm[17] -attr @rip imm[17] -pin IG1 imm[17] -pin Mux1 in1[17] -pin Shifter1 in[17]
load net Imm[18] -attr @rip imm[18] -pin IG1 imm[18] -pin Mux1 in1[18] -pin Shifter1 in[18]
load net Imm[19] -attr @rip imm[19] -pin IG1 imm[19] -pin Mux1 in1[19] -pin Shifter1 in[19]
load net Imm[1] -attr @rip imm[1] -pin IG1 imm[1] -pin Mux1 in1[1] -pin Shifter1 in[1]
load net Imm[20] -attr @rip imm[20] -pin IG1 imm[20] -pin Mux1 in1[20] -pin Shifter1 in[20]
load net Imm[21] -attr @rip imm[21] -pin IG1 imm[21] -pin Mux1 in1[21] -pin Shifter1 in[21]
load net Imm[22] -attr @rip imm[22] -pin IG1 imm[22] -pin Mux1 in1[22] -pin Shifter1 in[22]
load net Imm[23] -attr @rip imm[23] -pin IG1 imm[23] -pin Mux1 in1[23] -pin Shifter1 in[23]
load net Imm[24] -attr @rip imm[24] -pin IG1 imm[24] -pin Mux1 in1[24] -pin Shifter1 in[24]
load net Imm[25] -attr @rip imm[25] -pin IG1 imm[25] -pin Mux1 in1[25] -pin Shifter1 in[25]
load net Imm[26] -attr @rip imm[26] -pin IG1 imm[26] -pin Mux1 in1[26] -pin Shifter1 in[26]
load net Imm[27] -attr @rip imm[27] -pin IG1 imm[27] -pin Mux1 in1[27] -pin Shifter1 in[27]
load net Imm[28] -attr @rip imm[28] -pin IG1 imm[28] -pin Mux1 in1[28] -pin Shifter1 in[28]
load net Imm[29] -attr @rip imm[29] -pin IG1 imm[29] -pin Mux1 in1[29] -pin Shifter1 in[29]
load net Imm[2] -attr @rip imm[2] -pin IG1 imm[2] -pin Mux1 in1[2] -pin Shifter1 in[2]
load net Imm[30] -attr @rip imm[30] -pin IG1 imm[30] -pin Mux1 in1[30] -pin Shifter1 in[30]
load net Imm[31] -attr @rip imm[31] -pin IG1 imm[31] -pin Mux1 in1[31] -pin Shifter1 in[31]
load net Imm[3] -attr @rip imm[3] -pin IG1 imm[3] -pin Mux1 in1[3] -pin Shifter1 in[3]
load net Imm[4] -attr @rip imm[4] -pin IG1 imm[4] -pin Mux1 in1[4] -pin Shifter1 in[4]
load net Imm[5] -attr @rip imm[5] -pin IG1 imm[5] -pin Mux1 in1[5] -pin Shifter1 in[5]
load net Imm[6] -attr @rip imm[6] -pin IG1 imm[6] -pin Mux1 in1[6] -pin Shifter1 in[6]
load net Imm[7] -attr @rip imm[7] -pin IG1 imm[7] -pin Mux1 in1[7] -pin Shifter1 in[7]
load net Imm[8] -attr @rip imm[8] -pin IG1 imm[8] -pin Mux1 in1[8] -pin Shifter1 in[8]
load net Imm[9] -attr @rip imm[9] -pin IG1 imm[9] -pin Mux1 in1[9] -pin Shifter1 in[9]
load net Inst[0] -attr @rip Inst[0] -pin Control1 Inst[0] -pin IG1 ins[0] -pin InstMem1 Inst[0]
load net Inst[10] -attr @rip Inst[10] -pin IG1 ins[10] -pin InstMem1 Inst[10] -pin RF1 write_reg[3]
load net Inst[11] -attr @rip Inst[11] -pin IG1 ins[11] -pin InstMem1 Inst[11] -pin RF1 write_reg[4]
load net Inst[12] -attr @rip Inst[12] -pin AC1 Inst[0] -pin IG1 ins[12] -pin InstMem1 Inst[12]
load net Inst[13] -attr @rip Inst[13] -pin AC1 Inst[1] -pin IG1 ins[13] -pin InstMem1 Inst[13]
load net Inst[14] -attr @rip Inst[14] -pin AC1 Inst[2] -pin IG1 ins[14] -pin InstMem1 Inst[14]
load net Inst[15] -attr @rip Inst[15] -pin IG1 ins[15] -pin InstMem1 Inst[15] -pin RF1 read_reg1[0]
load net Inst[16] -attr @rip Inst[16] -pin IG1 ins[16] -pin InstMem1 Inst[16] -pin RF1 read_reg1[1]
load net Inst[17] -attr @rip Inst[17] -pin IG1 ins[17] -pin InstMem1 Inst[17] -pin RF1 read_reg1[2]
load net Inst[18] -attr @rip Inst[18] -pin IG1 ins[18] -pin InstMem1 Inst[18] -pin RF1 read_reg1[3]
load net Inst[19] -attr @rip Inst[19] -pin IG1 ins[19] -pin InstMem1 Inst[19] -pin RF1 read_reg1[4]
load net Inst[1] -attr @rip Inst[1] -pin Control1 Inst[1] -pin IG1 ins[1] -pin InstMem1 Inst[1]
load net Inst[20] -attr @rip Inst[20] -pin IG1 ins[20] -pin InstMem1 Inst[20] -pin RF1 read_reg2[0]
load net Inst[21] -attr @rip Inst[21] -pin IG1 ins[21] -pin InstMem1 Inst[21] -pin RF1 read_reg2[1]
load net Inst[22] -attr @rip Inst[22] -pin IG1 ins[22] -pin InstMem1 Inst[22] -pin RF1 read_reg2[2]
load net Inst[23] -attr @rip Inst[23] -pin IG1 ins[23] -pin InstMem1 Inst[23] -pin RF1 read_reg2[3]
load net Inst[24] -attr @rip Inst[24] -pin IG1 ins[24] -pin InstMem1 Inst[24] -pin RF1 read_reg2[4]
load net Inst[25] -attr @rip Inst[25] -pin IG1 ins[25] -pin InstMem1 Inst[25]
load net Inst[26] -attr @rip Inst[26] -pin IG1 ins[26] -pin InstMem1 Inst[26]
load net Inst[27] -attr @rip Inst[27] -pin IG1 ins[27] -pin InstMem1 Inst[27]
load net Inst[28] -attr @rip Inst[28] -pin IG1 ins[28] -pin InstMem1 Inst[28]
load net Inst[29] -attr @rip Inst[29] -pin IG1 ins[29] -pin InstMem1 Inst[29]
load net Inst[2] -attr @rip Inst[2] -pin Control1 Inst[2] -pin IG1 ins[2] -pin InstMem1 Inst[2]
load net Inst[30] -attr @rip Inst[30] -pin AC1 Inst[3] -pin IG1 ins[30] -pin InstMem1 Inst[30]
load net Inst[31] -attr @rip Inst[31] -pin IG1 ins[31] -pin InstMem1 Inst[31]
load net Inst[3] -attr @rip Inst[3] -pin Control1 Inst[3] -pin IG1 ins[3] -pin InstMem1 Inst[3]
load net Inst[4] -attr @rip Inst[4] -pin Control1 Inst[4] -pin IG1 ins[4] -pin InstMem1 Inst[4]
load net Inst[5] -attr @rip Inst[5] -pin Control1 Inst[5] -pin IG1 ins[5] -pin InstMem1 Inst[5]
load net Inst[6] -attr @rip Inst[6] -pin Control1 Inst[6] -pin IG1 ins[6] -pin InstMem1 Inst[6]
load net Inst[7] -attr @rip Inst[7] -pin IG1 ins[7] -pin InstMem1 Inst[7] -pin RF1 write_reg[0]
load net Inst[8] -attr @rip Inst[8] -pin IG1 ins[8] -pin InstMem1 Inst[8] -pin RF1 write_reg[1]
load net Inst[9] -attr @rip Inst[9] -pin IG1 ins[9] -pin InstMem1 Inst[9] -pin RF1 write_reg[2]
load net MemRead -pin Control1 MemRead -pin DataMem1 MemRead
netloc MemRead 1 0 10 20 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 NJ 220 2710
load net MemWrite -pin Control1 MemWrite -pin DataMem1 MemWrite
netloc MemWrite 1 0 10 60 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 NJ 240 2690
load net MemtoReg -pin Control1 MemtoReg -pin Mux2 s
netloc MemtoReg 1 1 9 420 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 NJ 260 2670
load net PC_add4[0] -attr @rip out[0] -pin Adder1 out[0] -pin Mux3 in0[0]
load net PC_add4[10] -attr @rip out[10] -pin Adder1 out[10] -pin Mux3 in0[10]
load net PC_add4[11] -attr @rip out[11] -pin Adder1 out[11] -pin Mux3 in0[11]
load net PC_add4[12] -attr @rip out[12] -pin Adder1 out[12] -pin Mux3 in0[12]
load net PC_add4[13] -attr @rip out[13] -pin Adder1 out[13] -pin Mux3 in0[13]
load net PC_add4[14] -attr @rip out[14] -pin Adder1 out[14] -pin Mux3 in0[14]
load net PC_add4[15] -attr @rip out[15] -pin Adder1 out[15] -pin Mux3 in0[15]
load net PC_add4[16] -attr @rip out[16] -pin Adder1 out[16] -pin Mux3 in0[16]
load net PC_add4[17] -attr @rip out[17] -pin Adder1 out[17] -pin Mux3 in0[17]
load net PC_add4[18] -attr @rip out[18] -pin Adder1 out[18] -pin Mux3 in0[18]
load net PC_add4[19] -attr @rip out[19] -pin Adder1 out[19] -pin Mux3 in0[19]
load net PC_add4[1] -attr @rip out[1] -pin Adder1 out[1] -pin Mux3 in0[1]
load net PC_add4[20] -attr @rip out[20] -pin Adder1 out[20] -pin Mux3 in0[20]
load net PC_add4[21] -attr @rip out[21] -pin Adder1 out[21] -pin Mux3 in0[21]
load net PC_add4[22] -attr @rip out[22] -pin Adder1 out[22] -pin Mux3 in0[22]
load net PC_add4[23] -attr @rip out[23] -pin Adder1 out[23] -pin Mux3 in0[23]
load net PC_add4[24] -attr @rip out[24] -pin Adder1 out[24] -pin Mux3 in0[24]
load net PC_add4[25] -attr @rip out[25] -pin Adder1 out[25] -pin Mux3 in0[25]
load net PC_add4[26] -attr @rip out[26] -pin Adder1 out[26] -pin Mux3 in0[26]
load net PC_add4[27] -attr @rip out[27] -pin Adder1 out[27] -pin Mux3 in0[27]
load net PC_add4[28] -attr @rip out[28] -pin Adder1 out[28] -pin Mux3 in0[28]
load net PC_add4[29] -attr @rip out[29] -pin Adder1 out[29] -pin Mux3 in0[29]
load net PC_add4[2] -attr @rip out[2] -pin Adder1 out[2] -pin Mux3 in0[2]
load net PC_add4[30] -attr @rip out[30] -pin Adder1 out[30] -pin Mux3 in0[30]
load net PC_add4[31] -attr @rip out[31] -pin Adder1 out[31] -pin Mux3 in0[31]
load net PC_add4[3] -attr @rip out[3] -pin Adder1 out[3] -pin Mux3 in0[3]
load net PC_add4[4] -attr @rip out[4] -pin Adder1 out[4] -pin Mux3 in0[4]
load net PC_add4[5] -attr @rip out[5] -pin Adder1 out[5] -pin Mux3 in0[5]
load net PC_add4[6] -attr @rip out[6] -pin Adder1 out[6] -pin Mux3 in0[6]
load net PC_add4[7] -attr @rip out[7] -pin Adder1 out[7] -pin Mux3 in0[7]
load net PC_add4[8] -attr @rip out[8] -pin Adder1 out[8] -pin Mux3 in0[8]
load net PC_add4[9] -attr @rip out[9] -pin Adder1 out[9] -pin Mux3 in0[9]
load net PC_cs[0] -attr @rip PC_out[0] -pin Adder1 input1[0] -pin Adder2 input1[0] -pin InstMem1 PC[0] -pin PC1 PC_out[0]
load net PC_cs[10] -attr @rip PC_out[10] -pin Adder1 input1[10] -pin Adder2 input1[10] -pin InstMem1 PC[10] -pin PC1 PC_out[10]
load net PC_cs[11] -attr @rip PC_out[11] -pin Adder1 input1[11] -pin Adder2 input1[11] -pin InstMem1 PC[11] -pin PC1 PC_out[11]
load net PC_cs[12] -attr @rip PC_out[12] -pin Adder1 input1[12] -pin Adder2 input1[12] -pin InstMem1 PC[12] -pin PC1 PC_out[12]
load net PC_cs[13] -attr @rip PC_out[13] -pin Adder1 input1[13] -pin Adder2 input1[13] -pin InstMem1 PC[13] -pin PC1 PC_out[13]
load net PC_cs[14] -attr @rip PC_out[14] -pin Adder1 input1[14] -pin Adder2 input1[14] -pin InstMem1 PC[14] -pin PC1 PC_out[14]
load net PC_cs[15] -attr @rip PC_out[15] -pin Adder1 input1[15] -pin Adder2 input1[15] -pin InstMem1 PC[15] -pin PC1 PC_out[15]
load net PC_cs[16] -attr @rip PC_out[16] -pin Adder1 input1[16] -pin Adder2 input1[16] -pin InstMem1 PC[16] -pin PC1 PC_out[16]
load net PC_cs[17] -attr @rip PC_out[17] -pin Adder1 input1[17] -pin Adder2 input1[17] -pin InstMem1 PC[17] -pin PC1 PC_out[17]
load net PC_cs[18] -attr @rip PC_out[18] -pin Adder1 input1[18] -pin Adder2 input1[18] -pin InstMem1 PC[18] -pin PC1 PC_out[18]
load net PC_cs[19] -attr @rip PC_out[19] -pin Adder1 input1[19] -pin Adder2 input1[19] -pin InstMem1 PC[19] -pin PC1 PC_out[19]
load net PC_cs[1] -attr @rip PC_out[1] -pin Adder1 input1[1] -pin Adder2 input1[1] -pin InstMem1 PC[1] -pin PC1 PC_out[1]
load net PC_cs[20] -attr @rip PC_out[20] -pin Adder1 input1[20] -pin Adder2 input1[20] -pin InstMem1 PC[20] -pin PC1 PC_out[20]
load net PC_cs[21] -attr @rip PC_out[21] -pin Adder1 input1[21] -pin Adder2 input1[21] -pin InstMem1 PC[21] -pin PC1 PC_out[21]
load net PC_cs[22] -attr @rip PC_out[22] -pin Adder1 input1[22] -pin Adder2 input1[22] -pin InstMem1 PC[22] -pin PC1 PC_out[22]
load net PC_cs[23] -attr @rip PC_out[23] -pin Adder1 input1[23] -pin Adder2 input1[23] -pin InstMem1 PC[23] -pin PC1 PC_out[23]
load net PC_cs[24] -attr @rip PC_out[24] -pin Adder1 input1[24] -pin Adder2 input1[24] -pin InstMem1 PC[24] -pin PC1 PC_out[24]
load net PC_cs[25] -attr @rip PC_out[25] -pin Adder1 input1[25] -pin Adder2 input1[25] -pin InstMem1 PC[25] -pin PC1 PC_out[25]
load net PC_cs[26] -attr @rip PC_out[26] -pin Adder1 input1[26] -pin Adder2 input1[26] -pin InstMem1 PC[26] -pin PC1 PC_out[26]
load net PC_cs[27] -attr @rip PC_out[27] -pin Adder1 input1[27] -pin Adder2 input1[27] -pin InstMem1 PC[27] -pin PC1 PC_out[27]
load net PC_cs[28] -attr @rip PC_out[28] -pin Adder1 input1[28] -pin Adder2 input1[28] -pin InstMem1 PC[28] -pin PC1 PC_out[28]
load net PC_cs[29] -attr @rip PC_out[29] -pin Adder1 input1[29] -pin Adder2 input1[29] -pin InstMem1 PC[29] -pin PC1 PC_out[29]
load net PC_cs[2] -attr @rip PC_out[2] -pin Adder1 input1[2] -pin Adder2 input1[2] -pin InstMem1 PC[2] -pin PC1 PC_out[2]
load net PC_cs[30] -attr @rip PC_out[30] -pin Adder1 input1[30] -pin Adder2 input1[30] -pin InstMem1 PC[30] -pin PC1 PC_out[30]
load net PC_cs[31] -attr @rip PC_out[31] -pin Adder1 input1[31] -pin Adder2 input1[31] -pin InstMem1 PC[31] -pin PC1 PC_out[31]
load net PC_cs[3] -attr @rip PC_out[3] -pin Adder1 input1[3] -pin Adder2 input1[3] -pin InstMem1 PC[3] -pin PC1 PC_out[3]
load net PC_cs[4] -attr @rip PC_out[4] -pin Adder1 input1[4] -pin Adder2 input1[4] -pin InstMem1 PC[4] -pin PC1 PC_out[4]
load net PC_cs[5] -attr @rip PC_out[5] -pin Adder1 input1[5] -pin Adder2 input1[5] -pin InstMem1 PC[5] -pin PC1 PC_out[5]
load net PC_cs[6] -attr @rip PC_out[6] -pin Adder1 input1[6] -pin Adder2 input1[6] -pin InstMem1 PC[6] -pin PC1 PC_out[6]
load net PC_cs[7] -attr @rip PC_out[7] -pin Adder1 input1[7] -pin Adder2 input1[7] -pin InstMem1 PC[7] -pin PC1 PC_out[7]
load net PC_cs[8] -attr @rip PC_out[8] -pin Adder1 input1[8] -pin Adder2 input1[8] -pin InstMem1 PC[8] -pin PC1 PC_out[8]
load net PC_cs[9] -attr @rip PC_out[9] -pin Adder1 input1[9] -pin Adder2 input1[9] -pin InstMem1 PC[9] -pin PC1 PC_out[9]
load net PC_ns[0] -attr @rip out[0] -pin Mux3 out[0] -pin PC1 PC_in[0]
load net PC_ns[10] -attr @rip out[10] -pin Mux3 out[10] -pin PC1 PC_in[10]
load net PC_ns[11] -attr @rip out[11] -pin Mux3 out[11] -pin PC1 PC_in[11]
load net PC_ns[12] -attr @rip out[12] -pin Mux3 out[12] -pin PC1 PC_in[12]
load net PC_ns[13] -attr @rip out[13] -pin Mux3 out[13] -pin PC1 PC_in[13]
load net PC_ns[14] -attr @rip out[14] -pin Mux3 out[14] -pin PC1 PC_in[14]
load net PC_ns[15] -attr @rip out[15] -pin Mux3 out[15] -pin PC1 PC_in[15]
load net PC_ns[16] -attr @rip out[16] -pin Mux3 out[16] -pin PC1 PC_in[16]
load net PC_ns[17] -attr @rip out[17] -pin Mux3 out[17] -pin PC1 PC_in[17]
load net PC_ns[18] -attr @rip out[18] -pin Mux3 out[18] -pin PC1 PC_in[18]
load net PC_ns[19] -attr @rip out[19] -pin Mux3 out[19] -pin PC1 PC_in[19]
load net PC_ns[1] -attr @rip out[1] -pin Mux3 out[1] -pin PC1 PC_in[1]
load net PC_ns[20] -attr @rip out[20] -pin Mux3 out[20] -pin PC1 PC_in[20]
load net PC_ns[21] -attr @rip out[21] -pin Mux3 out[21] -pin PC1 PC_in[21]
load net PC_ns[22] -attr @rip out[22] -pin Mux3 out[22] -pin PC1 PC_in[22]
load net PC_ns[23] -attr @rip out[23] -pin Mux3 out[23] -pin PC1 PC_in[23]
load net PC_ns[24] -attr @rip out[24] -pin Mux3 out[24] -pin PC1 PC_in[24]
load net PC_ns[25] -attr @rip out[25] -pin Mux3 out[25] -pin PC1 PC_in[25]
load net PC_ns[26] -attr @rip out[26] -pin Mux3 out[26] -pin PC1 PC_in[26]
load net PC_ns[27] -attr @rip out[27] -pin Mux3 out[27] -pin PC1 PC_in[27]
load net PC_ns[28] -attr @rip out[28] -pin Mux3 out[28] -pin PC1 PC_in[28]
load net PC_ns[29] -attr @rip out[29] -pin Mux3 out[29] -pin PC1 PC_in[29]
load net PC_ns[2] -attr @rip out[2] -pin Mux3 out[2] -pin PC1 PC_in[2]
load net PC_ns[30] -attr @rip out[30] -pin Mux3 out[30] -pin PC1 PC_in[30]
load net PC_ns[31] -attr @rip out[31] -pin Mux3 out[31] -pin PC1 PC_in[31]
load net PC_ns[3] -attr @rip out[3] -pin Mux3 out[3] -pin PC1 PC_in[3]
load net PC_ns[4] -attr @rip out[4] -pin Mux3 out[4] -pin PC1 PC_in[4]
load net PC_ns[5] -attr @rip out[5] -pin Mux3 out[5] -pin PC1 PC_in[5]
load net PC_ns[6] -attr @rip out[6] -pin Mux3 out[6] -pin PC1 PC_in[6]
load net PC_ns[7] -attr @rip out[7] -pin Mux3 out[7] -pin PC1 PC_in[7]
load net PC_ns[8] -attr @rip out[8] -pin Mux3 out[8] -pin PC1 PC_in[8]
load net PC_ns[9] -attr @rip out[9] -pin Mux3 out[9] -pin PC1 PC_in[9]
load net PC_offset[0] -attr @rip out[0] -pin Adder2 out[0] -pin Mux3 in1[0]
load net PC_offset[10] -attr @rip out[10] -pin Adder2 out[10] -pin Mux3 in1[10]
load net PC_offset[11] -attr @rip out[11] -pin Adder2 out[11] -pin Mux3 in1[11]
load net PC_offset[12] -attr @rip out[12] -pin Adder2 out[12] -pin Mux3 in1[12]
load net PC_offset[13] -attr @rip out[13] -pin Adder2 out[13] -pin Mux3 in1[13]
load net PC_offset[14] -attr @rip out[14] -pin Adder2 out[14] -pin Mux3 in1[14]
load net PC_offset[15] -attr @rip out[15] -pin Adder2 out[15] -pin Mux3 in1[15]
load net PC_offset[16] -attr @rip out[16] -pin Adder2 out[16] -pin Mux3 in1[16]
load net PC_offset[17] -attr @rip out[17] -pin Adder2 out[17] -pin Mux3 in1[17]
load net PC_offset[18] -attr @rip out[18] -pin Adder2 out[18] -pin Mux3 in1[18]
load net PC_offset[19] -attr @rip out[19] -pin Adder2 out[19] -pin Mux3 in1[19]
load net PC_offset[1] -attr @rip out[1] -pin Adder2 out[1] -pin Mux3 in1[1]
load net PC_offset[20] -attr @rip out[20] -pin Adder2 out[20] -pin Mux3 in1[20]
load net PC_offset[21] -attr @rip out[21] -pin Adder2 out[21] -pin Mux3 in1[21]
load net PC_offset[22] -attr @rip out[22] -pin Adder2 out[22] -pin Mux3 in1[22]
load net PC_offset[23] -attr @rip out[23] -pin Adder2 out[23] -pin Mux3 in1[23]
load net PC_offset[24] -attr @rip out[24] -pin Adder2 out[24] -pin Mux3 in1[24]
load net PC_offset[25] -attr @rip out[25] -pin Adder2 out[25] -pin Mux3 in1[25]
load net PC_offset[26] -attr @rip out[26] -pin Adder2 out[26] -pin Mux3 in1[26]
load net PC_offset[27] -attr @rip out[27] -pin Adder2 out[27] -pin Mux3 in1[27]
load net PC_offset[28] -attr @rip out[28] -pin Adder2 out[28] -pin Mux3 in1[28]
load net PC_offset[29] -attr @rip out[29] -pin Adder2 out[29] -pin Mux3 in1[29]
load net PC_offset[2] -attr @rip out[2] -pin Adder2 out[2] -pin Mux3 in1[2]
load net PC_offset[30] -attr @rip out[30] -pin Adder2 out[30] -pin Mux3 in1[30]
load net PC_offset[31] -attr @rip out[31] -pin Adder2 out[31] -pin Mux3 in1[31]
load net PC_offset[3] -attr @rip out[3] -pin Adder2 out[3] -pin Mux3 in1[3]
load net PC_offset[4] -attr @rip out[4] -pin Adder2 out[4] -pin Mux3 in1[4]
load net PC_offset[5] -attr @rip out[5] -pin Adder2 out[5] -pin Mux3 in1[5]
load net PC_offset[6] -attr @rip out[6] -pin Adder2 out[6] -pin Mux3 in1[6]
load net PC_offset[7] -attr @rip out[7] -pin Adder2 out[7] -pin Mux3 in1[7]
load net PC_offset[8] -attr @rip out[8] -pin Adder2 out[8] -pin Mux3 in1[8]
load net PC_offset[9] -attr @rip out[9] -pin Adder2 out[9] -pin Mux3 in1[9]
load net PC_s -pin Mux3 s -pin PC_s_i O
netloc PC_s 1 5 1 1670 390n
load net ReadData1[0] -attr @rip read_data1[0] -pin ALU1 in1[0] -pin RF1 read_data1[0]
load net ReadData1[10] -attr @rip read_data1[10] -pin ALU1 in1[10] -pin RF1 read_data1[10]
load net ReadData1[11] -attr @rip read_data1[11] -pin ALU1 in1[11] -pin RF1 read_data1[11]
load net ReadData1[12] -attr @rip read_data1[12] -pin ALU1 in1[12] -pin RF1 read_data1[12]
load net ReadData1[13] -attr @rip read_data1[13] -pin ALU1 in1[13] -pin RF1 read_data1[13]
load net ReadData1[14] -attr @rip read_data1[14] -pin ALU1 in1[14] -pin RF1 read_data1[14]
load net ReadData1[15] -attr @rip read_data1[15] -pin ALU1 in1[15] -pin RF1 read_data1[15]
load net ReadData1[16] -attr @rip read_data1[16] -pin ALU1 in1[16] -pin RF1 read_data1[16]
load net ReadData1[17] -attr @rip read_data1[17] -pin ALU1 in1[17] -pin RF1 read_data1[17]
load net ReadData1[18] -attr @rip read_data1[18] -pin ALU1 in1[18] -pin RF1 read_data1[18]
load net ReadData1[19] -attr @rip read_data1[19] -pin ALU1 in1[19] -pin RF1 read_data1[19]
load net ReadData1[1] -attr @rip read_data1[1] -pin ALU1 in1[1] -pin RF1 read_data1[1]
load net ReadData1[20] -attr @rip read_data1[20] -pin ALU1 in1[20] -pin RF1 read_data1[20]
load net ReadData1[21] -attr @rip read_data1[21] -pin ALU1 in1[21] -pin RF1 read_data1[21]
load net ReadData1[22] -attr @rip read_data1[22] -pin ALU1 in1[22] -pin RF1 read_data1[22]
load net ReadData1[23] -attr @rip read_data1[23] -pin ALU1 in1[23] -pin RF1 read_data1[23]
load net ReadData1[24] -attr @rip read_data1[24] -pin ALU1 in1[24] -pin RF1 read_data1[24]
load net ReadData1[25] -attr @rip read_data1[25] -pin ALU1 in1[25] -pin RF1 read_data1[25]
load net ReadData1[26] -attr @rip read_data1[26] -pin ALU1 in1[26] -pin RF1 read_data1[26]
load net ReadData1[27] -attr @rip read_data1[27] -pin ALU1 in1[27] -pin RF1 read_data1[27]
load net ReadData1[28] -attr @rip read_data1[28] -pin ALU1 in1[28] -pin RF1 read_data1[28]
load net ReadData1[29] -attr @rip read_data1[29] -pin ALU1 in1[29] -pin RF1 read_data1[29]
load net ReadData1[2] -attr @rip read_data1[2] -pin ALU1 in1[2] -pin RF1 read_data1[2]
load net ReadData1[30] -attr @rip read_data1[30] -pin ALU1 in1[30] -pin RF1 read_data1[30]
load net ReadData1[31] -attr @rip read_data1[31] -pin ALU1 in1[31] -pin RF1 read_data1[31]
load net ReadData1[3] -attr @rip read_data1[3] -pin ALU1 in1[3] -pin RF1 read_data1[3]
load net ReadData1[4] -attr @rip read_data1[4] -pin ALU1 in1[4] -pin RF1 read_data1[4]
load net ReadData1[5] -attr @rip read_data1[5] -pin ALU1 in1[5] -pin RF1 read_data1[5]
load net ReadData1[6] -attr @rip read_data1[6] -pin ALU1 in1[6] -pin RF1 read_data1[6]
load net ReadData1[7] -attr @rip read_data1[7] -pin ALU1 in1[7] -pin RF1 read_data1[7]
load net ReadData1[8] -attr @rip read_data1[8] -pin ALU1 in1[8] -pin RF1 read_data1[8]
load net ReadData1[9] -attr @rip read_data1[9] -pin ALU1 in1[9] -pin RF1 read_data1[9]
load net ReadData2[0] -attr @rip read_data2[0] -pin DataMem1 WriteData[0] -pin Mux1 in0[0] -pin RF1 read_data2[0]
load net ReadData2[10] -attr @rip read_data2[10] -pin DataMem1 WriteData[10] -pin Mux1 in0[10] -pin RF1 read_data2[10]
load net ReadData2[11] -attr @rip read_data2[11] -pin DataMem1 WriteData[11] -pin Mux1 in0[11] -pin RF1 read_data2[11]
load net ReadData2[12] -attr @rip read_data2[12] -pin DataMem1 WriteData[12] -pin Mux1 in0[12] -pin RF1 read_data2[12]
load net ReadData2[13] -attr @rip read_data2[13] -pin DataMem1 WriteData[13] -pin Mux1 in0[13] -pin RF1 read_data2[13]
load net ReadData2[14] -attr @rip read_data2[14] -pin DataMem1 WriteData[14] -pin Mux1 in0[14] -pin RF1 read_data2[14]
load net ReadData2[15] -attr @rip read_data2[15] -pin DataMem1 WriteData[15] -pin Mux1 in0[15] -pin RF1 read_data2[15]
load net ReadData2[16] -attr @rip read_data2[16] -pin DataMem1 WriteData[16] -pin Mux1 in0[16] -pin RF1 read_data2[16]
load net ReadData2[17] -attr @rip read_data2[17] -pin DataMem1 WriteData[17] -pin Mux1 in0[17] -pin RF1 read_data2[17]
load net ReadData2[18] -attr @rip read_data2[18] -pin DataMem1 WriteData[18] -pin Mux1 in0[18] -pin RF1 read_data2[18]
load net ReadData2[19] -attr @rip read_data2[19] -pin DataMem1 WriteData[19] -pin Mux1 in0[19] -pin RF1 read_data2[19]
load net ReadData2[1] -attr @rip read_data2[1] -pin DataMem1 WriteData[1] -pin Mux1 in0[1] -pin RF1 read_data2[1]
load net ReadData2[20] -attr @rip read_data2[20] -pin DataMem1 WriteData[20] -pin Mux1 in0[20] -pin RF1 read_data2[20]
load net ReadData2[21] -attr @rip read_data2[21] -pin DataMem1 WriteData[21] -pin Mux1 in0[21] -pin RF1 read_data2[21]
load net ReadData2[22] -attr @rip read_data2[22] -pin DataMem1 WriteData[22] -pin Mux1 in0[22] -pin RF1 read_data2[22]
load net ReadData2[23] -attr @rip read_data2[23] -pin DataMem1 WriteData[23] -pin Mux1 in0[23] -pin RF1 read_data2[23]
load net ReadData2[24] -attr @rip read_data2[24] -pin DataMem1 WriteData[24] -pin Mux1 in0[24] -pin RF1 read_data2[24]
load net ReadData2[25] -attr @rip read_data2[25] -pin DataMem1 WriteData[25] -pin Mux1 in0[25] -pin RF1 read_data2[25]
load net ReadData2[26] -attr @rip read_data2[26] -pin DataMem1 WriteData[26] -pin Mux1 in0[26] -pin RF1 read_data2[26]
load net ReadData2[27] -attr @rip read_data2[27] -pin DataMem1 WriteData[27] -pin Mux1 in0[27] -pin RF1 read_data2[27]
load net ReadData2[28] -attr @rip read_data2[28] -pin DataMem1 WriteData[28] -pin Mux1 in0[28] -pin RF1 read_data2[28]
load net ReadData2[29] -attr @rip read_data2[29] -pin DataMem1 WriteData[29] -pin Mux1 in0[29] -pin RF1 read_data2[29]
load net ReadData2[2] -attr @rip read_data2[2] -pin DataMem1 WriteData[2] -pin Mux1 in0[2] -pin RF1 read_data2[2]
load net ReadData2[30] -attr @rip read_data2[30] -pin DataMem1 WriteData[30] -pin Mux1 in0[30] -pin RF1 read_data2[30]
load net ReadData2[31] -attr @rip read_data2[31] -pin DataMem1 WriteData[31] -pin Mux1 in0[31] -pin RF1 read_data2[31]
load net ReadData2[3] -attr @rip read_data2[3] -pin DataMem1 WriteData[3] -pin Mux1 in0[3] -pin RF1 read_data2[3]
load net ReadData2[4] -attr @rip read_data2[4] -pin DataMem1 WriteData[4] -pin Mux1 in0[4] -pin RF1 read_data2[4]
load net ReadData2[5] -attr @rip read_data2[5] -pin DataMem1 WriteData[5] -pin Mux1 in0[5] -pin RF1 read_data2[5]
load net ReadData2[6] -attr @rip read_data2[6] -pin DataMem1 WriteData[6] -pin Mux1 in0[6] -pin RF1 read_data2[6]
load net ReadData2[7] -attr @rip read_data2[7] -pin DataMem1 WriteData[7] -pin Mux1 in0[7] -pin RF1 read_data2[7]
load net ReadData2[8] -attr @rip read_data2[8] -pin DataMem1 WriteData[8] -pin Mux1 in0[8] -pin RF1 read_data2[8]
load net ReadData2[9] -attr @rip read_data2[9] -pin DataMem1 WriteData[9] -pin Mux1 in0[9] -pin RF1 read_data2[9]
load net ReadData[0] -attr @rip ReadData[0] -pin DataMem1 ReadData[0] -pin Mux2 in1[0]
load net ReadData[10] -attr @rip ReadData[10] -pin DataMem1 ReadData[10] -pin Mux2 in1[10]
load net ReadData[11] -attr @rip ReadData[11] -pin DataMem1 ReadData[11] -pin Mux2 in1[11]
load net ReadData[12] -attr @rip ReadData[12] -pin DataMem1 ReadData[12] -pin Mux2 in1[12]
load net ReadData[13] -attr @rip ReadData[13] -pin DataMem1 ReadData[13] -pin Mux2 in1[13]
load net ReadData[14] -attr @rip ReadData[14] -pin DataMem1 ReadData[14] -pin Mux2 in1[14]
load net ReadData[15] -attr @rip ReadData[15] -pin DataMem1 ReadData[15] -pin Mux2 in1[15]
load net ReadData[16] -attr @rip ReadData[16] -pin DataMem1 ReadData[16] -pin Mux2 in1[16]
load net ReadData[17] -attr @rip ReadData[17] -pin DataMem1 ReadData[17] -pin Mux2 in1[17]
load net ReadData[18] -attr @rip ReadData[18] -pin DataMem1 ReadData[18] -pin Mux2 in1[18]
load net ReadData[19] -attr @rip ReadData[19] -pin DataMem1 ReadData[19] -pin Mux2 in1[19]
load net ReadData[1] -attr @rip ReadData[1] -pin DataMem1 ReadData[1] -pin Mux2 in1[1]
load net ReadData[20] -attr @rip ReadData[20] -pin DataMem1 ReadData[20] -pin Mux2 in1[20]
load net ReadData[21] -attr @rip ReadData[21] -pin DataMem1 ReadData[21] -pin Mux2 in1[21]
load net ReadData[22] -attr @rip ReadData[22] -pin DataMem1 ReadData[22] -pin Mux2 in1[22]
load net ReadData[23] -attr @rip ReadData[23] -pin DataMem1 ReadData[23] -pin Mux2 in1[23]
load net ReadData[24] -attr @rip ReadData[24] -pin DataMem1 ReadData[24] -pin Mux2 in1[24]
load net ReadData[25] -attr @rip ReadData[25] -pin DataMem1 ReadData[25] -pin Mux2 in1[25]
load net ReadData[26] -attr @rip ReadData[26] -pin DataMem1 ReadData[26] -pin Mux2 in1[26]
load net ReadData[27] -attr @rip ReadData[27] -pin DataMem1 ReadData[27] -pin Mux2 in1[27]
load net ReadData[28] -attr @rip ReadData[28] -pin DataMem1 ReadData[28] -pin Mux2 in1[28]
load net ReadData[29] -attr @rip ReadData[29] -pin DataMem1 ReadData[29] -pin Mux2 in1[29]
load net ReadData[2] -attr @rip ReadData[2] -pin DataMem1 ReadData[2] -pin Mux2 in1[2]
load net ReadData[30] -attr @rip ReadData[30] -pin DataMem1 ReadData[30] -pin Mux2 in1[30]
load net ReadData[31] -attr @rip ReadData[31] -pin DataMem1 ReadData[31] -pin Mux2 in1[31]
load net ReadData[3] -attr @rip ReadData[3] -pin DataMem1 ReadData[3] -pin Mux2 in1[3]
load net ReadData[4] -attr @rip ReadData[4] -pin DataMem1 ReadData[4] -pin Mux2 in1[4]
load net ReadData[5] -attr @rip ReadData[5] -pin DataMem1 ReadData[5] -pin Mux2 in1[5]
load net ReadData[6] -attr @rip ReadData[6] -pin DataMem1 ReadData[6] -pin Mux2 in1[6]
load net ReadData[7] -attr @rip ReadData[7] -pin DataMem1 ReadData[7] -pin Mux2 in1[7]
load net ReadData[8] -attr @rip ReadData[8] -pin DataMem1 ReadData[8] -pin Mux2 in1[8]
load net ReadData[9] -attr @rip ReadData[9] -pin DataMem1 ReadData[9] -pin Mux2 in1[9]
load net RegWrite -pin Control1 RegWrite -pin RF1 reg_write
netloc RegWrite 1 2 8 730 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 NJ 300 2650
load net WriteData[0] -attr @rip out[0] -pin Mux2 out[0] -pin RF1 write_data[0]
load net WriteData[10] -attr @rip out[10] -pin Mux2 out[10] -pin RF1 write_data[10]
load net WriteData[11] -attr @rip out[11] -pin Mux2 out[11] -pin RF1 write_data[11]
load net WriteData[12] -attr @rip out[12] -pin Mux2 out[12] -pin RF1 write_data[12]
load net WriteData[13] -attr @rip out[13] -pin Mux2 out[13] -pin RF1 write_data[13]
load net WriteData[14] -attr @rip out[14] -pin Mux2 out[14] -pin RF1 write_data[14]
load net WriteData[15] -attr @rip out[15] -pin Mux2 out[15] -pin RF1 write_data[15]
load net WriteData[16] -attr @rip out[16] -pin Mux2 out[16] -pin RF1 write_data[16]
load net WriteData[17] -attr @rip out[17] -pin Mux2 out[17] -pin RF1 write_data[17]
load net WriteData[18] -attr @rip out[18] -pin Mux2 out[18] -pin RF1 write_data[18]
load net WriteData[19] -attr @rip out[19] -pin Mux2 out[19] -pin RF1 write_data[19]
load net WriteData[1] -attr @rip out[1] -pin Mux2 out[1] -pin RF1 write_data[1]
load net WriteData[20] -attr @rip out[20] -pin Mux2 out[20] -pin RF1 write_data[20]
load net WriteData[21] -attr @rip out[21] -pin Mux2 out[21] -pin RF1 write_data[21]
load net WriteData[22] -attr @rip out[22] -pin Mux2 out[22] -pin RF1 write_data[22]
load net WriteData[23] -attr @rip out[23] -pin Mux2 out[23] -pin RF1 write_data[23]
load net WriteData[24] -attr @rip out[24] -pin Mux2 out[24] -pin RF1 write_data[24]
load net WriteData[25] -attr @rip out[25] -pin Mux2 out[25] -pin RF1 write_data[25]
load net WriteData[26] -attr @rip out[26] -pin Mux2 out[26] -pin RF1 write_data[26]
load net WriteData[27] -attr @rip out[27] -pin Mux2 out[27] -pin RF1 write_data[27]
load net WriteData[28] -attr @rip out[28] -pin Mux2 out[28] -pin RF1 write_data[28]
load net WriteData[29] -attr @rip out[29] -pin Mux2 out[29] -pin RF1 write_data[29]
load net WriteData[2] -attr @rip out[2] -pin Mux2 out[2] -pin RF1 write_data[2]
load net WriteData[30] -attr @rip out[30] -pin Mux2 out[30] -pin RF1 write_data[30]
load net WriteData[31] -attr @rip out[31] -pin Mux2 out[31] -pin RF1 write_data[31]
load net WriteData[3] -attr @rip out[3] -pin Mux2 out[3] -pin RF1 write_data[3]
load net WriteData[4] -attr @rip out[4] -pin Mux2 out[4] -pin RF1 write_data[4]
load net WriteData[5] -attr @rip out[5] -pin Mux2 out[5] -pin RF1 write_data[5]
load net WriteData[6] -attr @rip out[6] -pin Mux2 out[6] -pin RF1 write_data[6]
load net WriteData[7] -attr @rip out[7] -pin Mux2 out[7] -pin RF1 write_data[7]
load net WriteData[8] -attr @rip out[8] -pin Mux2 out[8] -pin RF1 write_data[8]
load net WriteData[9] -attr @rip out[9] -pin Mux2 out[9] -pin RF1 write_data[9]
load net clock -pin DataMem1 clock -pin PC1 clock -pin RF1 clk -port clock
netloc clock 1 0 7 20 520 NJ 520 670 800 NJ 800 NJ 800 NJ 800 1910J
load net zero -pin ALU1 zero -pin PC_s_i I1
netloc zero 1 4 1 N 400
load netBundle @Aluctrl 4 Aluctrl[3] Aluctrl[2] Aluctrl[1] Aluctrl[0] -autobundled
netbloc @Aluctrl 1 3 8 1040 320 NJ 320 NJ 320 NJ 320 NJ 320 NJ 320 NJ 320 3020
load netBundle @ALUresult 32 ALUresult[31] ALUresult[30] ALUresult[29] ALUresult[28] ALUresult[27] ALUresult[26] ALUresult[25] ALUresult[24] ALUresult[23] ALUresult[22] ALUresult[21] ALUresult[20] ALUresult[19] ALUresult[18] ALUresult[17] ALUresult[16] ALUresult[15] ALUresult[14] ALUresult[13] ALUresult[12] ALUresult[11] ALUresult[10] ALUresult[9] ALUresult[8] ALUresult[7] ALUresult[6] ALUresult[5] ALUresult[4] ALUresult[3] ALUresult[2] ALUresult[1] ALUresult[0] -autobundled
netbloc @ALUresult 1 0 5 60 440 400 360 650J 280 NJ 280 1330
load netBundle @PC_add4 32 PC_add4[31] PC_add4[30] PC_add4[29] PC_add4[28] PC_add4[27] PC_add4[26] PC_add4[25] PC_add4[24] PC_add4[23] PC_add4[22] PC_add4[21] PC_add4[20] PC_add4[19] PC_add4[18] PC_add4[17] PC_add4[16] PC_add4[15] PC_add4[14] PC_add4[13] PC_add4[12] PC_add4[11] PC_add4[10] PC_add4[9] PC_add4[8] PC_add4[7] PC_add4[6] PC_add4[5] PC_add4[4] PC_add4[3] PC_add4[2] PC_add4[1] PC_add4[0] -autobundled
netbloc @PC_add4 1 5 1 N 600
load netBundle @PC_offset 32 PC_offset[31] PC_offset[30] PC_offset[29] PC_offset[28] PC_offset[27] PC_offset[26] PC_offset[25] PC_offset[24] PC_offset[23] PC_offset[22] PC_offset[21] PC_offset[20] PC_offset[19] PC_offset[18] PC_offset[17] PC_offset[16] PC_offset[15] PC_offset[14] PC_offset[13] PC_offset[12] PC_offset[11] PC_offset[10] PC_offset[9] PC_offset[8] PC_offset[7] PC_offset[6] PC_offset[5] PC_offset[4] PC_offset[3] PC_offset[2] PC_offset[1] PC_offset[0] -autobundled
netbloc @PC_offset 1 5 1 1690 620n
load netBundle @ALUop 2 ALUop[1] ALUop[0] -autobundled
netbloc @ALUop 1 9 1 2770 60n
load netBundle @ReadData 32 ReadData[31] ReadData[30] ReadData[29] ReadData[28] ReadData[27] ReadData[26] ReadData[25] ReadData[24] ReadData[23] ReadData[22] ReadData[21] ReadData[20] ReadData[19] ReadData[18] ReadData[17] ReadData[16] ReadData[15] ReadData[14] ReadData[13] ReadData[12] ReadData[11] ReadData[10] ReadData[9] ReadData[8] ReadData[7] ReadData[6] ReadData[5] ReadData[4] ReadData[3] ReadData[2] ReadData[1] ReadData[0] -autobundled
netbloc @ReadData 1 1 1 360 340n
load netBundle @Imm 32 Imm[31] Imm[30] Imm[29] Imm[28] Imm[27] Imm[26] Imm[25] Imm[24] Imm[23] Imm[22] Imm[21] Imm[20] Imm[19] Imm[18] Imm[17] Imm[16] Imm[15] Imm[14] Imm[13] Imm[12] Imm[11] Imm[10] Imm[9] Imm[8] Imm[7] Imm[6] Imm[5] Imm[4] Imm[3] Imm[2] Imm[1] Imm[0] -autobundled
netbloc @Imm 1 2 2 650 760 NJ
load netBundle @Inst 32 Inst[31] Inst[30] Inst[29] Inst[28] Inst[27] Inst[26] Inst[25] Inst[24] Inst[23] Inst[22] Inst[21] Inst[20] Inst[19] Inst[18] Inst[17] Inst[16] Inst[15] Inst[14] Inst[13] Inst[12] Inst[11] Inst[10] Inst[9] Inst[8] Inst[7] Inst[6] Inst[5] Inst[4] Inst[3] Inst[2] Inst[1] Inst[0] -autobundled
netbloc @Inst 1 1 9 420 500 710 500 NJ 500 NJ 500 NJ 500 NJ 500 NJ 500 2410 280 2710J
load netBundle @ALUin 32 ALUin[31] ALUin[30] ALUin[29] ALUin[28] ALUin[27] ALUin[26] ALUin[25] ALUin[24] ALUin[23] ALUin[22] ALUin[21] ALUin[20] ALUin[19] ALUin[18] ALUin[17] ALUin[16] ALUin[15] ALUin[14] ALUin[13] ALUin[12] ALUin[11] ALUin[10] ALUin[9] ALUin[8] ALUin[7] ALUin[6] ALUin[5] ALUin[4] ALUin[3] ALUin[2] ALUin[1] ALUin[0] -autobundled
netbloc @ALUin 1 3 1 1060 420n
load netBundle @WriteData 32 WriteData[31] WriteData[30] WriteData[29] WriteData[28] WriteData[27] WriteData[26] WriteData[25] WriteData[24] WriteData[23] WriteData[22] WriteData[21] WriteData[20] WriteData[19] WriteData[18] WriteData[17] WriteData[16] WriteData[15] WriteData[14] WriteData[13] WriteData[12] WriteData[11] WriteData[10] WriteData[9] WriteData[8] WriteData[7] WriteData[6] WriteData[5] WriteData[4] WriteData[3] WriteData[2] WriteData[1] WriteData[0] -autobundled
netbloc @WriteData 1 2 1 N 440
load netBundle @PC_ns 32 PC_ns[31] PC_ns[30] PC_ns[29] PC_ns[28] PC_ns[27] PC_ns[26] PC_ns[25] PC_ns[24] PC_ns[23] PC_ns[22] PC_ns[21] PC_ns[20] PC_ns[19] PC_ns[18] PC_ns[17] PC_ns[16] PC_ns[15] PC_ns[14] PC_ns[13] PC_ns[12] PC_ns[11] PC_ns[10] PC_ns[9] PC_ns[8] PC_ns[7] PC_ns[6] PC_ns[5] PC_ns[4] PC_ns[3] PC_ns[2] PC_ns[1] PC_ns[0] -autobundled
netbloc @PC_ns 1 6 1 N 620
load netBundle @PC_cs 32 PC_cs[31] PC_cs[30] PC_cs[29] PC_cs[28] PC_cs[27] PC_cs[26] PC_cs[25] PC_cs[24] PC_cs[23] PC_cs[22] PC_cs[21] PC_cs[20] PC_cs[19] PC_cs[18] PC_cs[17] PC_cs[16] PC_cs[15] PC_cs[14] PC_cs[13] PC_cs[12] PC_cs[11] PC_cs[10] PC_cs[9] PC_cs[8] PC_cs[7] PC_cs[6] PC_cs[5] PC_cs[4] PC_cs[3] PC_cs[2] PC_cs[1] PC_cs[0] -autobundled
netbloc @PC_cs 1 4 4 1330 680 NJ 680 NJ 680 2180
load netBundle @ReadData1 32 ReadData1[31] ReadData1[30] ReadData1[29] ReadData1[28] ReadData1[27] ReadData1[26] ReadData1[25] ReadData1[24] ReadData1[23] ReadData1[22] ReadData1[21] ReadData1[20] ReadData1[19] ReadData1[18] ReadData1[17] ReadData1[16] ReadData1[15] ReadData1[14] ReadData1[13] ReadData1[12] ReadData1[11] ReadData1[10] ReadData1[9] ReadData1[8] ReadData1[7] ReadData1[6] ReadData1[5] ReadData1[4] ReadData1[3] ReadData1[2] ReadData1[1] ReadData1[0] -autobundled
netbloc @ReadData1 1 3 1 N 400
load netBundle @ReadData2 32 ReadData2[31] ReadData2[30] ReadData2[29] ReadData2[28] ReadData2[27] ReadData2[26] ReadData2[25] ReadData2[24] ReadData2[23] ReadData2[22] ReadData2[21] ReadData2[20] ReadData2[19] ReadData2[18] ReadData2[17] ReadData2[16] ReadData2[15] ReadData2[14] ReadData2[13] ReadData2[12] ReadData2[11] ReadData2[10] ReadData2[9] ReadData2[8] ReadData2[7] ReadData2[6] ReadData2[5] ReadData2[4] ReadData2[3] ReadData2[2] ReadData2[1] ReadData2[0] -autobundled
netbloc @ReadData2 1 0 4 40 420 380J 340 690 520 1040
load netBundle @ImmShift 32 ImmShift[31] ImmShift[30] ImmShift[29] ImmShift[28] ImmShift[27] ImmShift[26] ImmShift[25] ImmShift[24] ImmShift[23] ImmShift[22] ImmShift[21] ImmShift[20] ImmShift[19] ImmShift[18] ImmShift[17] ImmShift[16] ImmShift[15] ImmShift[14] ImmShift[13] ImmShift[12] ImmShift[11] ImmShift[10] ImmShift[9] ImmShift[8] ImmShift[7] ImmShift[6] ImmShift[5] ImmShift[4] ImmShift[3] ImmShift[2] ImmShift[1] ImmShift[0] -autobundled
netbloc @ImmShift 1 4 1 NJ 760
levelinfo -pg 1 0 180 500 850 1170 1530 1770 2010 2260 2490 2870 3040
pagesize -pg 1 -db -bbox -sgen -90 0 3040 810
show
fullfit
#
# initialize ictrl to current module SingleCycleProcessor work:SingleCycleProcessor:NOFILE
ictrl init topinfo |
