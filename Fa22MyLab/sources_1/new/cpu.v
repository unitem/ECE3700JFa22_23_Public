`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/12 17:02:20
// Design Name: 
// Module Name: cpu
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


module Pipeline_Plus(
    input                    clk
   
);

    wire        [31:0]          Instruct, Imm, Imm_shift, data_1, data_2, MUX_ALU, loadPC, JumpPC, W_data, Add_1, Add_2, Add_3;//ADD FOR PC
    wire        [31:0]          ALUResult, Read_Mem, JumpTo, ALUInput1, ALUInput2;
    wire        [31:0]          IF_ID_nextPC, IF_ID_currentPC, IF_ID_Instruct, Display_RF;
    wire        [31:0]          ID_EX_nextPC, ID_EX_currentPC, ID_EX_data_1, ID_EX_data_2, ID_EX_Imm, EX_MEM_Imm, MEM_WB_Imm;
    wire        [31:0]          EX_MEM_nextPC, EX_MEM_JumpTo, EX_MEM_ALUResult, EX_MEM_data_2, mem_write_content;
    wire        [31:0]          MEM_WB_nextPC, MEM_WB_Read_Mem, MEM_WB_ALUResult;
    wire        [31:0]          mux2_out, mux3_out; //FOR COM FORWARD
    wire        [4:0]           ID_EX_Reg_rd, ID_EX_Rs1_Addr, ID_EX_Rs2_Addr, EX_MEM_Rs2_Addr, EX_MEM_Reg_rd, MEM_WB_Reg_rd;
    wire        [3:0]           ALUControl, ID_EX_ALUInstruct;
    wire        [2:0]           EX_MEM_Funct3;
    wire        [1:0]           ALUOp, MemtoReg, ID_EX_ALUOp, ID_EX_MemtoReg, EX_MEM_MemtoReg, MEM_WB_MemtoReg;
    wire                        Branch, isBranch, MemRead, MemWrite, ALUSrc, isJump, RegWrite, isZero;
    wire                        IF_Flush, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_isJump, ID_EX_RegWrite;
    wire                        EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite, MEM_WB_RegWrite, MEM_WB_MemRead;//MEM_WB_MEMREAD NOT NECESSARY
    wire                        PC_write, IF_ID_write, Mux_Con; //HAZARD
    wire        [1:0]           ForwardA, ForwardB; //ALU FORWARD
    wire                        Forward_Com1, Forward_Com2, Forward_MemSrc;//COM FORWARD AND MEM FORWARD
    wire        [9:0]           allControlIn, allControlOut;//CONTROL HAZARD
    reg         [31:0]          PC;
    
    initial PC = 0;   
      
    assign Imm_shift = {Imm[30:0],1'b0}; 
//  allControl = {ALUOp, MemtoReg, Branch, MemRead, MemWrite, ALUSrc, Jump, RegWrite}
    assign RegWrite = allControlOut[0];
    assign isJump   = allControlOut[1]; 
    assign ALUSrc   = allControlOut[2];
    assign MemWrite = allControlOut[3];
    assign MemRead  = allControlOut[4];
    assign Branch   = allControlOut[5];
    assign MemtoReg = allControlOut[7:6];
    assign ALUOp    = allControlOut[9:8];
    
    always @ (posedge clk) 
        if (PC_write == 1'b1) PC <= loadPC;
        
    
    Hazard HD (
        .IF_ID_r1 (IF_ID_Instruct[19:15]),
        .IF_ID_r2 (IF_ID_Instruct[24:20]),
        .ID_EX_RegRd (ID_EX_Reg_rd),
        .EX_MEM_RegRd (EX_MEM_Reg_rd),
        .ID_EX_MemRead (ID_EX_MemRead),
        .EX_MEM_MemRead (EX_MEM_MemRead),
        .ID_branch (allControlIn[5]), 
        .ID_MemWrite (allControlIn[3]), 
        .ID_EX_RegWrite (ID_EX_RegWrite), 
        .PC_write (PC_write),
        .IF_ID_write (IF_ID_write),
        .mux_con (Mux_Con)
    );
    
    Forwarding FU (
        .ID_EX_r1 (ID_EX_Rs1_Addr),
        .ID_EX_r2 (ID_EX_Rs2_Addr),
        .IF_ID_r1 (IF_ID_Instruct[19:15]),
        .IF_ID_r2 (IF_ID_Instruct[24:20]),
        .EX_MEM_r2 (EX_MEM_Rs2_Addr),
        .MEM_WB_RegRd (MEM_WB_Reg_rd),
        .EX_MEM_RegRd (EX_MEM_Reg_rd),
        .ID_EX_RegRd (ID_EX_Reg_rd),
        .MEM_WB_RegWrite (MEM_WB_RegWrite),
        .EX_MEM_RegWrite (EX_MEM_RegWrite),
        .EX_MEM_MemWrite (EX_MEM_MemWrite),
        .MEM_WB_MemRead (MEM_WB_MemRead),
        .EX_MEM_MemRead (EX_MEM_MemRead),
        .ID_EX_MemRead (ID_EX_MemRead),
        .ID_EX_MemWrite (ID_EX_MemWrite),
        .ID_EX_RegWrite (ID_EX_RegWrite),
        .IF_ID_branch (Branch),
        .Forwarding_A (ForwardA),
        .Forwarding_B (ForwardB),
        .Forwarding_Com1 (Forward_Com1),
        .Forwarding_Com2 (Forward_Com2),
        .MemSrc (Forward_MemSrc)
    );
    
    Instruction_Memory InstructionMem (
        .instrct_out (Instruct),
        .addr (PC)
    );
    Control Control (
        .opcode (IF_ID_Instruct[6:0]),
        .allControl (allControlIn)
    );
    Register_File RegisterFile (
        .clock (clk),
        .W_en (MEM_WB_RegWrite),
        .W_data (W_data),
        .R_addr_1 (IF_ID_Instruct[19:15]),
        .R_addr_2 (IF_ID_Instruct[24:20]),
        .W_addr (MEM_WB_Reg_rd),
        .R_data_1 (data_1),
        .R_data_2 (data_2)
    );
    Comparator Compare (
        .func ({IF_ID_Instruct[2], IF_ID_Instruct[14:12]}),
        .in1 (mux2_out),
        .in2 (mux3_out),
        .isZero (isZero)
    );
    Immediate_Generator ImmGen (
        .In (IF_ID_Instruct),
        .Out (Imm)
    );
    ALU ALU (     
        .data1 (ALUInput1),
        .data2 (ALUInput2),
        .sel (ALUControl),
        .result (ALUResult)
    ); 
    ALU_Control ALU_Control (
        .ALU_op (ID_EX_ALUOp),
        .instruct (ID_EX_ALUInstruct),
        .ALU_sel (ALUControl)
    );
    Data_Memory DataMem (
        .W_en (EX_MEM_MemWrite),
        .R_en (EX_MEM_MemRead),
        .Funct3 (EX_MEM_Funct3),
        .addr (EX_MEM_ALUResult),
        .W_data (mem_write_content), 
        .R_data_out (Read_Mem)        
    );
    
    IF_ID_State_Reg IF_ID (
        .clock (clk),
        .IF_Flush (IF_Flush),
        .IF_ID_Write (IF_ID_write),
        .currentPC (PC),
        .nextPC (Add_1),
        .Instruct (Instruct),
        .currentPC_out (IF_ID_currentPC),
        .nextPC_out (IF_ID_nextPC),
        .Instruct_out (IF_ID_Instruct)
    );
    ID_EX_State_Reg ID_EX (
        .clock (clk),
        .RegWrite (RegWrite),
        .MemtoReg (MemtoReg),
        .MemRead (MemRead),
        .MemWrite (MemWrite),
        .Jump (isJump),
        .ALUSrc (ALUSrc),
        .ALUOp (ALUOp),
        .currentPC (IF_ID_currentPC),
        .nextPC (IF_ID_nextPC),
        .Reg_rs1 (data_1),
        .Reg_rs2 (data_2),
        .Reg_rs1_addr (IF_ID_Instruct[19:15]),
        .Reg_rs2_addr (IF_ID_Instruct[24:20]),
        .Imm_Gen (Imm),
        .Reg_rd (IF_ID_Instruct[11:7]),
        .ALU_Instruct ({IF_ID_Instruct[30],IF_ID_Instruct[14:12]}),
        .RegWrite_out (ID_EX_RegWrite),
        .MemtoReg_out (ID_EX_MemtoReg),
        .MemRead_out (ID_EX_MemRead),
        .MemWrite_out (ID_EX_MemWrite),
        .Jump_out (ID_EX_isJump),
        .ALUSrc_out (ID_EX_ALUSrc),
        .ALUOp_out (ID_EX_ALUOp),
        .currentPC_out (ID_EX_currentPC),
        .nextPC_out (ID_EX_nextPC),
        .Reg_rs1_out (ID_EX_data_1),
        .Reg_rs2_out (ID_EX_data_2),
        .Reg_rs1_addr_out (ID_EX_Rs1_Addr),
        .Reg_rs2_addr_out (ID_EX_Rs2_Addr),
        .Imm_Gen_out (ID_EX_Imm),
        .Reg_rd_out (ID_EX_Reg_rd),
        .ALU_Instruct_out (ID_EX_ALUInstruct)
    );
    EX_MEM_State_Reg EX_MEM (
        .clock (clk),
        .RegWrite (ID_EX_RegWrite),
        .MemtoReg (ID_EX_MemtoReg),
        .MemRead (ID_EX_MemRead),
        .MemWrite (ID_EX_MemWrite),
        .imm (ID_EX_Imm),
        .nextPC (ID_EX_nextPC),
        .ALUResult (ALUResult),
        .Reg_rs2 (ID_EX_data_2),
        .Funct3 (ID_EX_ALUInstruct[2:0]),
        .Reg_rd (ID_EX_Reg_rd),
        .Reg_rs2_addr (ID_EX_Rs2_Addr),
        .RegWrite_out (EX_MEM_RegWrite),
        .MemtoReg_out (EX_MEM_MemtoReg),
        .MemRead_out (EX_MEM_MemRead),
        .MemWrite_out (EX_MEM_MemWrite),
        .imm_out (EX_MEM_Imm),
        .nextPC_out (EX_MEM_nextPC),
        .ALUResult_out (EX_MEM_ALUResult),
        .Reg_rs2_out (EX_MEM_data_2),
        .Funct3_out (EX_MEM_Funct3),
        .Reg_rd_out (EX_MEM_Reg_rd),
        .Reg_rs2_addr_out (EX_MEM_Rs2_Addr)
    );
    MEM_WB_State_Reg MEM_WB (
        .clock (clk),
        .MemRead (EX_MEM_MemRead),
        .RegWrite (EX_MEM_RegWrite),
        .MemtoReg (EX_MEM_MemtoReg),
        .imm (EX_MEM_Imm),
        .nextPC (EX_MEM_nextPC),
        .ReadData (Read_Mem),
        .ALUResult (EX_MEM_ALUResult),
        .Reg_rd (EX_MEM_Reg_rd),
        .MemRead_out (MEM_WB_MemRead),
        .RegWrite_out (MEM_WB_RegWrite),
        .MemtoReg_out (MEM_WB_MemtoReg),
        .imm_out (MEM_WB_Imm),
        .nextPC_out (MEM_WB_nextPC),
        .ReadData_out (MEM_WB_Read_Mem),
        .ALUResult_out (MEM_WB_ALUResult),
        .Reg_rd_out (MEM_WB_Reg_rd)
    );
    
    and (isBranch, Branch, isZero); 
    or  (IF_Flush, isBranch, isJump); 
    
    Adder Adder_1(.data1(PC), .data2(32'h00000004), .result(Add_1)); //PC+4
    Adder Adder_2(.data1(IF_ID_currentPC), .data2(Imm_shift), .result(Add_2)); //PC+Imm 
    Adder Adder_3(.data1(data_1), .data2(Imm), .result(Add_3)); //Addr+Imm 

    MUX_4to1  Mux_1(.data1(Add_1), .data2(Add_2), .data3(Add_3), .data4(Add_2),.sel({isJump,isBranch}), .result(loadPC)); //judge pc
    MUX_2to1  Mux_2(.data1(data_1), .data2(EX_MEM_ALUResult), .sel(Forward_Com1), .result(mux2_out)); //comparator
    MUX_2to1  Mux_3(.data1(data_2), .data2(EX_MEM_ALUResult), .sel(Forward_Com2), .result(mux3_out)); //comparator
    MUX_4to1  Mux_4(.data1(MEM_WB_Read_Mem), .data2(MEM_WB_nextPC), .data3(MEM_WB_Imm), .data4(MEM_WB_ALUResult), .sel(MEM_WB_MemtoReg), .result(W_data)); //judge write data
    MUX_2to1  Mux_5(.data1(10'b0000000000), .data2(allControlIn), .sel(Mux_Con), .result(allControlOut)); //control hazard
    MUX_4to1  Mux_6(.data1(ID_EX_data_1), .data2(W_data), .data3(EX_MEM_ALUResult), .data4(EX_MEM_ALUResult), .sel(ForwardA), .result(ALUInput1)); //ALU forA source1
    MUX_4to1  Mux_7(.data1(ID_EX_data_2), .data2(W_data), .data3(EX_MEM_ALUResult), .data4(EX_MEM_ALUResult), .sel(ForwardB), .result(MUX_ALU)); //ALU forB
    MUX_2to1  Mux_8(.data1(MUX_ALU), .data2(ID_EX_Imm), .sel(ID_EX_ALUSrc), .result(ALUInput2)); //ALU source2
    MUX_2to1  Mux_9(.data1(EX_MEM_data_2), .data2(W_data), .sel(Forward_MemSrc), .result(mem_write_content)); // MEM for
     

 
    
endmodule





module Register_File 
(
    input                           clock, W_en,
    input       [31:0]              W_data,
    input       [4:0]               R_addr_1, R_addr_2, W_addr,
    output      [31:0]              R_data_1, R_data_2
);
    reg         [31:0]             data  [31:0];
    
    integer i;
    initial begin  
        for(i=0; i<32; i=i+1)  
            data[i] <= 0;
    end 
    
    always @ (negedge clock) begin
        if (W_en && W_addr!= 0) begin
            data[W_addr] = W_data;
        end  
    end
     
    assign R_data_1 = data[R_addr_1];
    assign R_data_2 = data[R_addr_2];  
    
endmodule

module Comparator #
(
    parameter BEQ = 4'b0000, parameter BNE = 4'b0001, parameter BLT = 4'b0100, parameter BGE = 4'b0101
)
(
    input       [3:0]           func,
    input       [31:0]          in1, in2,
    output reg                  isZero
);
    initial isZero = 1'b1;
    always @ (*) begin
        case (func)
                BEQ: isZero = (in1==in2)?1'b1:1'b0;
                BNE: isZero = (in1==in2)?1'b0:1'b1;
                BLT: isZero = ($signed(in1) < $signed(in2))?1'b1:1'b0; 
                BGE: isZero = ($signed(in1) < $signed(in2))?1'b0:1'b1; 
                default: isZero = 1'b1;
        endcase
    end
endmodule

module ALU #
(
    parameter ADD = 4'b0010, parameter SUB = 4'b1000, parameter BNE = 4'b1001,
    parameter XOR = 4'b0100, parameter  OR = 4'b0110, parameter AND = 4'b0111, parameter BLT = 4'b1100,
    parameter SLL = 4'b0001, parameter SRL = 4'b0101, parameter SRA = 4'b1101, parameter BGE = 4'b1110
)(
    input       [3:0]          sel,
    input       [31:0]         data1, data2,
    //output reg                 Zero,
    output reg  [31:0]         result
);
    
    always @ (*) begin
        case (sel)
            ADD:
                    begin
                        result =  data1 + data2; //add
                        //Zero = 1'b1; //jal & jalr
                    end
            SUB:     
                    begin
                         if (data1 == data2) begin
                             //Zero = 1; 
                             result =  0;
                         end 
                         else begin
                             //Zero = 0; 
                             result =  data1 - data2; //sub
                         end
                     end
            BNE:     
                         begin
                              if (data1 == data2) begin
                                  //Zero = 0; 
                                  result =  0;
                              end 
                              else begin
                                  //Zero =  1; 
                                  result =  data1 - data2; //sub
                              end
                          end                 
            BLT:    
                    begin
                        if ($signed(data1) < $signed(data2)) begin
                            //Zero = 1; 
                            result =  data1 - data2;
                        end 
                        else begin
                            //Zero = 0; 
                            result =  data1 - data2;
                        end
                    end
            BGE:
                    begin
                        if ($signed(data1) < $signed(data2)) begin
                            //Zero = 0; 
                            result =  data1 - data2;
                        end 
                        else begin
                            //Zero =  1;
                            result =  data1 - data2;
                        end
                    end                
            XOR:     result =  data1 ^ data2; //xor
             OR:     result =  data1 | data2; //or
            AND:     result =  data1 & data2; //and
            SLL:     result =  data1 <<data2; //sll
            SRL:     result =  data1 >>data2; //srl
            SRA:     result =  $signed(($signed(data1))>>>data2); //sra
            default: begin 
            result = 0; 
            //Zero = 0; 
            end
        endcase
    end

endmodule

module ALU_Control 
(
    input       [1:0]         ALU_op,
    input       [3:0]         instruct,
    output reg  [3:0]         ALU_sel 
);
    
    always @ (*) begin
        case (ALU_op)
            2'b00:  
                    begin
                        ALU_sel = 4'b0010; //Addition
                    end
            2'b01:  
                    begin
                        if (instruct[2:0] == 3'b101) 
                        begin 
                            ALU_sel = 4'b1110; 
                        end //bge
                        else 
                        begin 
                            ALU_sel = {1'b1, instruct[2:0]}; 
                        end //beq,bne,blt
                    end
            2'b10:  
                    begin
                        if (instruct == 0) 
                        begin 
                            ALU_sel = 4'b0010; 
                        end //add
                        else 
                        begin 
                            ALU_sel = instruct; 
                        end //aub,and,or,xor,sll,srl,sra
                    end
            2'b11:  
                    begin
                        if (instruct[2:0] == 0) 
                        begin 
                            ALU_sel = 4'b0010; 
                        end //addi
                        else 
                        begin 
                            ALU_sel = {1'b0, instruct[2:0]}; 
                        end //andi,slli,srli
                    end
            default:ALU_sel = 4'b0000;
        endcase
    end

endmodule

module Adder
(
    input       [31:0]          data1, data2,
    output reg  [31:0]          result
);
    
    always @ (*) begin
        result = data1 + data2;
    end
endmodule

module Immediate_Generator 
(
    input       [31:0]          In,
    output reg  [31:0]          Out
);
    
    always @ (*) begin
        case (In[6:0])
            //I-type: lw
            7'b0000011: 
                        begin 
                            Out = {{20{In[31]}}, In[31:20]}; 
                        end 
            //I-type: fence
            7'b0001111: 
                        begin 
                            Out = {{20{In[31]}}, In[31:20]}; 
                        end 
            //I-type: addi
            7'b0010011: 
                        begin 
                            Out = {{20{In[31]}}, In[31:20]}; 
                        end  
            //S-type: sw
            7'b0100011: 
                        begin 
                            Out = {{20{In[31]}}, In[31:25], In[11:7]}; 
                        end 
            //B-type: beq, bne
            7'b1100011: 
                        begin 
                            Out = {{21{In[31]}}, In[7], In[30:25], In[11:8]}; 
                        end 
            //I-type: jalr
            7'b1100111: 
                        begin 
                            Out = {{20{In[31]}}, In[31:20]}; 
                        end 
            //J-type: jal
            7'b1101111: 
                        begin 
                            Out = {{21{In[31]}}, In[19:12], In[20], In[30:21]};
                        end 

            default:    
                        begin 
                            Out[31:0]  = 0; 
                        end
        endcase
    end 
endmodule

module Control 
(
    input       [6:0]           opcode,
    
    output reg  [9:0]           allControl
//  output reg  [1:0]           ALUOp, MemtoReg, //MemtoReg to select among ALUResult, DataMemo, and PC+4.
//  output reg                  Branch, MemRead, MemWrite, ALUSrc, Jump, RegWrite //Jump for jalr.
);

    initial begin //Bug_09
        allControl <= 0;
    end

//  allControl = {ALUOp, MemtoReg, Branch, MemRead, MemWrite, ALUSrc, Jump, RegWrite}
    always @ (opcode) begin //NewBug_13 about MemtoReg
        case (opcode)
        //I-type,load
            7'b0000011: begin allControl[0] <= 1; allControl[1] <= 0; allControl[2] <= 1; allControl[3] <= 0; allControl[4] <= 1; allControl[5] <= 0; allControl[7:6] <= 2'b00; allControl[9:8] <= 2'b00;  end 
//          7'b0001111:
        //I-type,Im
            7'b0010011: begin allControl[0] <= 1; allControl[1] <= 0; allControl[2] <= 1; allControl[3] <= 0; allControl[4] <= 0; allControl[5] <= 0; allControl[7:6] <= 2'b11; allControl[9:8] <= 2'b11;  end 
//          7'b0010111:
        //S-type,sw
            7'b0100011: begin allControl[0] <= 0; allControl[1] <= 0; allControl[2] <= 1; allControl[3] <= 1; allControl[4] <= 0; allControl[5] <= 0; allControl[7:6] <= 2'b11; allControl[9:8] <= 2'b00;  end 
//          7'b0110111:
        //B-type,brnc
            7'b1100011: begin allControl[0] <= 0; allControl[1] <= 0; allControl[2] <= 0; allControl[3] <= 0; allControl[4] <= 0; allControl[5] <= 1; allControl[7:6] <= 2'b11; allControl[9:8] <= 2'b01;  end 
        //I-type,jal
            7'b1100111: begin allControl[0] <= 1; allControl[1] <= 1; allControl[2] <= 1; allControl[3] <= 0; allControl[4] <= 0; allControl[5] <= 0; allControl[7:6] <= 2'b01; allControl[9:8] <= 2'b00;  end 
        //J-type,jalr
            7'b1101111: begin allControl[0] <= 1; allControl[1] <= 1; allControl[2] <= 1; allControl[3] <= 0; allControl[4] <= 0; allControl[5] <= 1; allControl[7:6] <= 2'b01; allControl[9:8] <= 2'b00;  end 
//          7'b1110011:
        //R-type,cal
            7'b0110011: begin allControl[0] <= 1; allControl[1] <= 0; allControl[2] <= 0; allControl[3] <= 0; allControl[4] <= 0; allControl[5] <= 0; allControl[7:6] <= 2'b11; allControl[9:8] <= 2'b10;  end 
            default:    begin allControl    <= 0; end
        endcase
    end
endmodule


module MUX_2to1 
(
    input                       sel,
    input       [31:0]          data1, data2,
    output reg  [31:0]          result
);

    always @ (*) begin
        case (sel)
            1'b0:   result = data1;
            1'b1:   result = data2;
            default:    result = 0;
        endcase
    end
endmodule

module MUX_4to1 
(
    input       [1:0]           sel,
    input       [31:0]         data1, data2, data3, data4,
    output reg  [31:0]         result
);

    always @ (*) begin
        case (sel)
            2'b00:   result = data1;
            2'b01:   result = data2;
            2'b10:   result = data3;
            2'b11:   result = data4;
            default:    result = 0;
        endcase
    end
endmodule

module Instruction_Memory #
(
    parameter N = 32,
    parameter reg_rows = 32
)(
    input       [31:0]         addr,
    output reg  [31:0]         instrct_out
);
    reg         [31:0]         Instruction [127:0];
   
    initial begin
        Instruction[0]  = 32'b00111001100100000000001100010011;
        Instruction[1]  = 32'b00000000011000000010001000100011;
        Instruction[2]  = 32'b00000000010000000000001010000011;
        Instruction[3]  = 32'b00000000010100000010000000100011;
        Instruction[4]  = 32'b00000010000000110000000001100011;
        Instruction[5]  = 32'b00000000000000000010111000000011;
        Instruction[6]  = 32'b00000001110000101001110001100011;
        Instruction[7]  = 32'b00000001110000101000001110110011;
        Instruction[8]  = 32'b00000001110000111111001100110011;
        Instruction[9]  = 32'b00000000000000111111001100010011;
        Instruction[10] = 32'b01000000000000110000001010110011;
        Instruction[11] = 32'b00000000011000101101010001100011;
        Instruction[12] = 32'b00000000000000000000001110110011;
        Instruction[13] = 32'b00000000110000000000000011101111;
        Instruction[14] = 32'b00000001010000000000000011101111;
        Instruction[15] = 32'b00000000000000000000111000110011;
        Instruction[16] = 32'b00000000011111100110111000110011;
        Instruction[17] = 32'b00000000000000001000000001100111;
        Instruction[18] = 32'b00000100100000000000001100010011;
        Instruction[19] = 32'b00001010110000000000001010010011;
        
    end   
    always @ (*) begin
        instrct_out = Instruction[(addr>>2)];
    end
endmodule

module Data_Memory #
(
    parameter SW = 3'b010,parameter SB = 3'b000, parameter LBU = 3'b100,parameter LW = 3'b010,parameter LB = 3'b000
)(
    input                       W_en, R_en,
    input       [2:0]           Funct3,
    input       [31:0]         addr, W_data,
    output reg  [31:0]         R_data_out
);
    reg         [7:0]           data[127:0];
    
    //Write to Data Memory
    always @ (*) begin
        if (W_en) begin
            case (Funct3)
                SW: 
                    begin //save word
                        data[addr] = W_data[7:0]; 
                        data[addr+1] = W_data[15:8]; 
                        data[addr+2] = W_data[23:16]; 
                        data[addr+3] = W_data[31:24]; 
                    end
                 
                SB: 
                    begin //save byte
                        data[addr] = W_data[7:0];
                    end
                default: data[addr] = data[addr];
            endcase
        end
    end
    //Read from Data Memory
    always @ (*) begin    
        if (R_en) begin
            case (Funct3)
                LW: 
                    begin //load word
                        R_data_out = {data[addr+3], data[addr+2], data[addr+1], data[addr]};
                    end
                
                LB: 
                    begin //load byte
                         R_data_out = {{24{data[addr][7]}}, data[addr]};
                    end
                LBU:
                    begin //load byte unsigned
                        R_data_out = {{24{1'b0}}, data[addr]};
                    end
                default: R_data_out = R_data_out;
            endcase
        end
    end
endmodule

module IF_ID_State_Reg
(
    input                   clock, 
    input                   IF_Flush,       // new control
    input                   IF_ID_Write,    // new control
    input       [31:0]      currentPC,
    input       [31:0]      nextPC,
    input       [31:0]      Instruct,
    output reg  [31:0]      currentPC_out,
    output reg  [31:0]      nextPC_out,
    output reg  [31:0]      Instruct_out
);

    initial begin 
        currentPC_out = 0; 
        nextPC_out = 0; 
        Instruct_out = 0;
    end

    always @ (posedge clock) begin
        if (IF_Flush == 1'b1) begin 
            Instruct_out      = 0;
        end
        else if (IF_ID_Write == 1'b1) begin
            currentPC_out     = currentPC;
            nextPC_out        = nextPC;
            Instruct_out      = Instruct;
        end
    end
    
endmodule

module ID_EX_State_Reg
(
    input                   clock,
    input                   RegWrite,   
    input       [1:0]       MemtoReg,   
    input                   MemRead,    
    input                   MemWrite,   
    input                   Jump,       
    input                   ALUSrc,     
    input       [1:0]       ALUOp,      
    input       [31:0]      currentPC,
    input       [31:0]      nextPC,
    input       [31:0]      Reg_rs1,
    input       [31:0]      Reg_rs2,
    input       [4:0]       Reg_rs1_addr,
    input       [4:0]       Reg_rs2_addr,
    input       [31:0]      Imm_Gen,
    input       [4:0]       Reg_rd,
    input       [3:0]       ALU_Instruct,
    output reg              RegWrite_out,   
    output reg  [1:0]       MemtoReg_out,   
    output reg              MemRead_out,    
    output reg              MemWrite_out,   
    output reg              Jump_out,       
    output reg              ALUSrc_out,     
    output reg  [1:0]       ALUOp_out,      
    output reg  [31:0]      currentPC_out,
    output reg  [31:0]      nextPC_out,
    output reg  [31:0]      Reg_rs1_out,
    output reg  [31:0]      Reg_rs2_out,
    output reg  [4:0]       Reg_rs1_addr_out, //new for forward
    output reg  [4:0]       Reg_rs2_addr_out, //new for forward
    output reg  [31:0]      Imm_Gen_out,
    output reg  [4:0]       Reg_rd_out,
    output reg  [3:0]       ALU_Instruct_out
);

    initial begin //Bug_06
        RegWrite_out = 0; MemtoReg_out = 0; MemRead_out = 0; MemWrite_out = 0; Jump_out = 0; ALUSrc_out = 0; 
        ALUOp_out = 0; currentPC_out = 0; nextPC_out = 0; Reg_rs1_out = 0; Reg_rs2_out = 0; Imm_Gen_out = 0; 
        Reg_rd_out = 0; ALU_Instruct_out = 0; Reg_rs1_addr_out = 0; Reg_rs2_addr_out = 0;
    end

    always @ (posedge clock) begin
        RegWrite_out     = RegWrite;
        MemtoReg_out     = MemtoReg;
        MemRead_out      = MemRead;
        MemWrite_out     = MemWrite;
        Jump_out         = Jump;
        ALUSrc_out       = ALUSrc;
        ALUOp_out        = ALUOp;
        currentPC_out    = currentPC;
        nextPC_out       = nextPC;
        Reg_rs1_out      = Reg_rs1;
        Reg_rs2_out      = Reg_rs2;
        Reg_rs1_addr_out = Reg_rs1_addr;    //new for forward
        Reg_rs2_addr_out = Reg_rs2_addr;    //new for forward
        Reg_rd_out       = Reg_rd;
        Imm_Gen_out      = Imm_Gen;
        ALU_Instruct_out  = ALU_Instruct;
    end

endmodule

module EX_MEM_State_Reg
(
    input                   clock,
    input                   RegWrite,   
    input       [1:0]       MemtoReg,   
    input                   MemRead,    
    input                   MemWrite,   
    input       [31:0]      imm,
    input       [31:0]      nextPC,
    input       [31:0]      ALUResult,
    input       [31:0]      Reg_rs2,
    input       [2:0]       Funct3,
    input       [4:0]       Reg_rd,
    input       [4:0]       Reg_rs2_addr, //new for forward
    output reg              RegWrite_out,  
    output reg  [1:0]       MemtoReg_out,  
    output reg              MemRead_out,   
    output reg              MemWrite_out,  
    output reg  [31:0]      imm_out,
    output reg  [31:0]      nextPC_out,
    output reg  [31:0]      ALUResult_out,
    output reg  [31:0]      Reg_rs2_out,
    output reg  [2:0]       Funct3_out,
    output reg  [4:0]       Reg_rd_out,
    output reg  [4:0]       Reg_rs2_addr_out 
);

    initial begin //Bug_07
        RegWrite_out = 0; MemtoReg_out = 0; MemRead_out = 0; MemWrite_out = 0; nextPC_out = 0; 
        ALUResult_out = 0; Reg_rs2_out = 0; Funct3_out = 0; Reg_rd_out = 0; imm_out = 0;
    end

    always @ (posedge clock) begin
        RegWrite_out     = RegWrite;
        MemtoReg_out     = MemtoReg;
        MemRead_out      = MemRead;
        MemWrite_out     = MemWrite;
        imm_out          = imm;
        nextPC_out       = nextPC;
        ALUResult_out    = ALUResult;
        Reg_rs2_out      = Reg_rs2;
        Funct3_out       = Funct3;
        Reg_rd_out       = Reg_rd;
        Reg_rs2_addr_out = Reg_rs2_addr;
    end

endmodule

module MEM_WB_State_Reg
(
    input                   clock,
    input                   MemRead,    //new for forward
    input                   RegWrite,   
    input       [1:0]       MemtoReg,   
    input       [31:0]      imm,
    input       [31:0]      nextPC,
    input       [31:0]      ReadData,
    input       [31:0]      ALUResult,
    input       [4:0]       Reg_rd,
    output reg              MemRead_out,
    output reg              RegWrite_out,   
    output reg  [1:0]       MemtoReg_out,   
    output reg  [31:0]      imm_out,
    output reg  [31:0]      nextPC_out,
    output reg  [31:0]      ReadData_out,
    output reg  [31:0]      ALUResult_out,
    output reg  [4:0]       Reg_rd_out
);

    initial begin 
        MemRead_out = 0; RegWrite_out = 0; MemtoReg_out = 0; nextPC_out = 0; ReadData_out = 0; 
        ALUResult_out = 0; Reg_rd_out = 0; imm_out = 0;
    end

    always @ (posedge clock) begin
        MemRead_out      = MemRead;
        RegWrite_out     = RegWrite;
        MemtoReg_out     = MemtoReg;
        imm_out          = imm;
        nextPC_out       = nextPC;
        ReadData_out     = ReadData;
        ALUResult_out    = ALUResult;
        Reg_rd_out       = Reg_rd;
    end

endmodule