`timescale 1ns / 1ps

module CPU (
    input  hit_miss, // 1 for hit
    input  clock,
    input  [31:0]Read_Data,
    output read_write, // 1 for write
    output [9:0] address,
    output [31:0] write_data
);
    parameter  request_total = 12; 
    reg [4:0]  request_num;
    reg        read_write_test[request_total-1:0];
    reg [9:0]  address_test[request_total-1:0];
    reg [31:0] write_data_test[request_total-1:0]; 
    initial begin
        /* test cases */
        #10 request_num = 0;
        read_write_test[0] = 1; address_test[0] = 10'b0110101000; write_data_test[0] = 10'h3ab; //write miss + empty dirty=0
        read_write_test[1] = 0; address_test[1] = 10'b0110101000; write_data_test[1] = 0; //                                                h3ab
        read_write_test[2] = 1; address_test[2] = 10'b0110101000; write_data_test[2] = 10'h3ac;//write hit
        read_write_test[3] = 0; address_test[3] = 10'b0110101000; write_data_test[3] = 0;//read hit                                         h3ac
        read_write_test[4] = 0; address_test[4] = 10'b0100001000; write_data_test[4] = 0;//read miss + empty dirty=0   block 0              0000
        read_write_test[5] = 0; address_test[5] = 10'b0100101000; write_data_test[5] = 0;//read miss + write back dirty=1                   0000
        read_write_test[6] = 0; address_test[6] = 10'b0110101000; write_data_test[6] = 0;//check write back dirty=0                         h3ac 
        read_write_test[7] = 1; address_test[7] = 10'b0110101000; write_data_test[7] = 10'h3ad;//write hit
        read_write_test[8] = 1; address_test[8] = 10'b0101101000; write_data_test[8] = 10'h3ae;//write miss + write back dirty=1
        read_write_test[9] = 0; address_test[9] = 10'b0101101000; write_data_test[9] = 0;//check write                                      h3ae
        read_write_test[10] = 0; address_test[10] = 10'b0110101000; write_data_test[10] = 0;//check write back dirty=0                      h3ad
        read_write_test[11] = 0; address_test[11] = 10'b0110101001; write_data_test[11] = 0;//check load byte                               h003              
    end
    always @(posedge clock) begin
        if (hit_miss == 1) request_num = request_num + 1;
        else request_num = request_num;
    end
    assign address      = address_test[request_num];
    assign read_write   = read_write_test[request_num];
    assign write_data   = write_data_test[request_num]; 
endmodule