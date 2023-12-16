`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/08 10:23:23
// Design Name: 
// Module Name: mux
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


module MUX_4 (
    input [1:0] s,
    input [31:0] MUXinput1, 
    input [31:0] MUXinput2, 
    input [31:0] MUXinput3, 
    input [31:0] MUXinput4,
    output reg [31:0] MUXoutput
);
    initial begin MUXoutput = 0; end

    always @ (*) begin
        case (s)
            2'b00: begin MUXoutput = MUXinput1; end
            2'b01: begin MUXoutput = MUXinput2; end
            2'b10: begin MUXoutput = MUXinput3; end
            2'b11: begin MUXoutput = MUXinput4; end
            default: begin MUXoutput = 0; end
        endcase
    end
endmodule

module MUX_8 (
    input [1:0] s,
    input [31:0] MUXinput1, 
    input [31:0] MUXinput2, 
    input [31:0] MUXinput3, 
    input [31:0] MUXinput4,
    input [31:0] MUXinput5, 
    input [31:0] MUXinput6, 
    input [31:0] MUXinput7, 
    input [31:0] MUXinput8,
    output reg [31:0] MUXoutput
);
    initial begin MUXoutput = 0; end

    always @ (*) begin
        case (s)
            3'b000: begin MUXoutput = MUXinput1; end
            3'b001: begin MUXoutput = MUXinput2; end
            3'b010: begin MUXoutput = MUXinput3; end
            3'b011: begin MUXoutput = MUXinput4; end
            3'b100: begin MUXoutput = MUXinput5; end 
            3'b101: begin MUXoutput = MUXinput6; end 
            3'b110: begin MUXoutput = MUXinput7; end 
            3'b111: begin MUXoutput = MUXinput8; end
            default: begin MUXoutput = 0; end
        endcase
    end
endmodule

