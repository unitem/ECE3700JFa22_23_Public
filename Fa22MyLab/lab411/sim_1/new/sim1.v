`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/31 15:17:24
// Design Name: 
// Module Name: sim1
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


module sim1(

    );
    reg clk;
        cpu test (
            clk
        );
    
        initial begin
            clk = 0; // Initialize Inputs
        end
    
        
        always #1 clk = ~clk;
        initial
                #3000 $stop;
endmodule
