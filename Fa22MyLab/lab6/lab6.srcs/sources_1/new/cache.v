`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/20 02:16:05
// Design Name: 
// Module Name: cache
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


module cache(
    input type_in, //1 for write, 0 for read
    input [9:0] addr_in,
    input [31:0] write_data_in,
    input [31:0] read_data_in,
    input done,
    output reg type_out,
    output reg [9:0] addr_out,
    output reg [31:0] write_data_out,
    output reg [31:0] read_data_out,
    output reg hit_miss //1 for hit, 0 for miss    
    );
    
    //4 blocks, 4 words per block
    reg valid [3:0];
    reg dirty [3:0];
    reg [3:0] tag [3:0];
    reg [31:0] data [15:0];
    
    //byte address
    wire [3:0] data_tag;
    wire [1:0] index;
    wire [1:0] word_offset;
    wire [1:0] byte_offset;
    assign data_tag = (addr_in >> 6);
    assign index = ((addr_in >> 4) & 2'b11);
    assign word_offset = ((addr_in >> 2) & 2'b11);
    assign byte_offset = (addr_in & 2'b11);    
    
    //load byte
    wire is_byte;
    assign is_byte=(byte_offset>0);
    
    integer i; //initialize
    initial begin
        for(i=0;i<4;i=i+1) begin
            valid[i]=0;
            dirty[i]=0;
            tag[i]=0;
            data[i]=0;
        end
    end

    always@(*) begin
        #2
        //Basicly, I divide it into 2 parts, write or read.
        //write
        if(type_in==1) begin
            //check if hit
            if(valid[index]==1'b1 && tag[index]==data_tag) hit_miss=1;
            //miss
            else begin
                hit_miss=0;
                //check if dirty
                if(dirty[index]==1'b1) begin
                    //write back the previous data
                    type_out=1;
                    addr_out={tag[index], index, {4{1'b0}}};
                    write_data_out=data[index*4];
                    #3;
                    for(i=1;i<4;i=i+1) begin
                        if(done==1) begin
                            addr_out=addr_out+4;
                            write_data_out=data[index*4+i];
                        end
                        #4;
                    end
                    #5;
                end
                //load the blocks into cache
                addr_out=(addr_in & 10'b1111110000);
                type_out=0;
                #1
                for(i=0;i<4;i=i+1) begin
                    #2;
                    if(done==1) begin
                        data[index*4+i]=read_data_in;
                        addr_out=addr_out+4;
                    end
                    #2;
                end
                valid[index]=1;
                tag[index]=data_tag;
            end
            //write data
            hit_miss=1;
            if(!is_byte) data[index*4+word_offset]=write_data_in; //word
            else data[index*4+word_offset][(byte_offset*4+7)-:8]=write_data_in;  //byte, little Endian
            dirty[index]=1;            
        end
        //read
        else begin
            //check if hit
            if(valid[index]==1'b1 && tag[index]==data_tag) hit_miss=1;
            else begin
                hit_miss=0;
                //check if dirty
                if(dirty[index]==1) begin
                    //write back the previous data
                    type_out=1;
                    addr_out={tag[index], index, {4{1'b0}}};
                    write_data_out=data[index*4];
                    #3;
                    for(i=1;i<4;i=i+1) begin
                        if(done==1) begin
                            addr_out=addr_out+4;
                            write_data_out=data[index*4+i];
                        end
                        #4;
                    end
                    dirty[index]=0;
                    #5;
                end
                //load the blocks into cache
                addr_out={addr_in[9:4], {4{1'b0}}};
                type_out=0;
                #1;
                for(i=0;i<4;i=i+1) begin
                    #2;
                    if(done==1) begin
                        data[index*4+i]=read_data_in;
                        addr_out=addr_out+4;
                    end
                    #2;
                end
                valid[index]=1;
                tag[index]=data_tag;       
            end
            //return data
            hit_miss=1;
            if(!is_byte) read_data_out=data[index*4+word_offset];//word
            else read_data_out={{24{1'b0}},data[index*4+word_offset][(byte_offset*8+7)-:8]};
        end
    end
    
        
endmodule
