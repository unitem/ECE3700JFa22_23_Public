`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 19:02:36
// Design Name: 
// Module Name: ALUctrl
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


module ALUctrl(Inst, ALUop, Aluctrl);
    input [3:0] Inst;
    input [1:0] ALUop;
    output reg [3:0] Aluctrl;
    
    always@(*) begin
        case(ALUop)
            2'b00: begin
                Aluctrl=4'b0010;
                end
            2'b01: begin
                case(Inst[2:0])
                    3'b000: Aluctrl=4'b0110;
                    3'b001: Aluctrl=4'b0111;
                    default: Aluctrl=4'b1111;
                endcase
                end
            2'b10: begin
                case (Inst)
                    4'b0000: Aluctrl=4'b0010;
                    4'b1000: Aluctrl=4'b0110;
                    4'b0111: Aluctrl=4'b0000;
                    4'b0110: Aluctrl=4'b0001;
                    default: Aluctrl=4'b1111;
                endcase
            end
            default: Aluctrl=4'b1111;
        endcase
    end
    
endmodule
