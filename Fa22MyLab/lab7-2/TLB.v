`timescale 1ns / 1ps
module TLB(
    input [13:0] virtual_address,
    input [1:0] input_physical_page, // Only tag.
    input update_page,
    output reg [9:0] physical_address,
    output reg search_page_table,
    output reg write_back,
    output reg [5:0] index,
    output reg [1:0] output_physical_page
);
    integer i, j, record;
    reg valid [3:0];
    reg [1:0] reference [3:0];
    reg hit;
    reg dirty [3:0];
    reg already_written;
    wire [5:0] tag_temp;
    reg [5:0] tag [3:0];
    reg [1:0] translation [3:0];
    assign tag_temp = virtual_address[13:8];

    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            valid[i] = 0;
            reference[i] = 0;
            dirty[i] = 0;
        end
    end

always @ (*) begin
    hit = 0;
    already_written = 0;
    record = 4;
    write_back = 0;
    search_page_table = 1; // 0
    for (i = 0; i < 4; i = i + 1) begin
        if (valid[i] == 1 && tag_temp == tag[i]) begin // HIT
            hit = 1;
            record = i;
        end
    end
    if (hit == 1) begin
        #2
        reference[record] = 2'b11;
        for (j = 0; j < 4; j = j + 1) begin
            if ((j != record) && (reference[j] != 0)) reference[j] = reference[j] - 1;
        end
        physical_address = {translation[record], virtual_address[7:0]};
    end else if (update_page == 1) begin
        search_page_table = 1;// added
        #2
        
        for (i = 0; i < 4; i = i + 1) begin
            if (valid[i] == 0 && already_written == 0) begin
                record = i;
                already_written = 1;
            end
        end
        for (i = 0; i < 4; i = i + 1) begin
            if (reference[i] == 2'b00 && already_written == 0) begin
                record = i;
                already_written = 1;
            end
        end
        if (dirty[record] == 1'b1) begin
            write_back = 1;
            index = tag[record];
            output_physical_page = translation[record];
        end
        valid[record] = 1;
        tag[record] = tag_temp;
        translation[record] = input_physical_page;
        reference[record] = 2'b11;
        for (j = 0; j < 4; j = j + 1) begin
            if ((j != record) && (reference[j] != 0)) reference[j] = reference[j] - 1;
        end
        physical_address = {input_physical_page, virtual_address[7:0]};
        dirty[record] = 1'b1;
    end else search_page_table = 1;
end
endmodule

module Page_table(
    input [13:0] virtual_address,
    input [1:0] input_physical_page, // output_physical_page from TLB
    input [5:0] index,
    input write_back,
    input search_page_table,
    output reg [1:0] output_physical_page,
    output reg update_page,
    output reg page_fault
);
    reg [31:0] page_table [31:0];
    wire [5:0] tag_temp;
    assign tag_temp = virtual_address[13:8];

    initial begin
        page_table[0] = {1'b1, 29'b0, 2'd1};
        page_table[1] = {1'b1, 29'b0, 2'd3};
        page_table[2] = {1'b0, 29'b0, 2'd2};
        page_table[3] = {1'b1, 29'b0, 2'd3};
        page_table[4] = {1'b1, 29'b0, 2'd2};
        page_table[5] = 32'b0;
        page_table[6] = 32'b0;
        page_table[7] = {1'b1, 29'b0, 2'd1}; 
        page_table[8] = {1'b1, 29'b0, 2'd1};
        page_table[9] = 32'b0;
        page_table[10] = {1'b1, 29'b0, 2'd1};
        page_fault = 0;
    end

    always @ (virtual_address) begin
        update_page = 0;
        page_fault = 0;
        if (search_page_table) begin
            if (tag_temp < 11) begin
                if (page_table[tag_temp][31] == 1) begin
                    update_page = 1;
                    output_physical_page = page_table[tag_temp][1:0];
                end else page_fault = 1;
            end else page_fault = 1;
        end else if (write_back) begin
            page_table[index] = {1'b1, 29'b0, input_physical_page};
        end
    end

endmodule

module main_memory(
    input type, //1 for write, 0 for read
    input [9:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data,
    output reg done
);
    
    //Main memory has 256 words
    //reg [31:0] regs[255:0];
    reg [153:0] regs[63:0];
    
    integer i;
    initial begin
        //for(i=0;i<256;i=i+1) regs[i]=0;
        done=0;
            regs[0] = {26'b0, 32'hA, 32'hE, 32'hF, 32'h55555555};
        regs[1] = 154'b0;
        regs[2] = 154'b0;
        regs[3] = 154'b0;
        regs[4] = {26'b0, 32'hBBBBBBBB, 32'hAAAAAAAA, 32'hEEEEEEEE, 32'hCCCCCCCC};
        regs[5] = 154'b0;
        regs[6] = 154'b0;
        regs[7] = 154'b0;
        regs[8] = 154'b0;
        regs[9] = 154'b0;
        regs[10] = 154'b0;
        regs[11] = 154'b0;
        regs[12] = 154'b0;
        regs[13] = 154'b0;
        regs[14] = 154'b0;
        regs[15] = 154'b0;
        regs[16] = {26'b0, 32'h11111111, 32'h22222222, 32'h33333333, 32'h44444444};
        regs[17] = 154'b0;
        regs[18] = 154'b0;
        regs[19] = 154'b0;
        regs[20] = {26'b0, 32'h281, 32'h285, 32'h0, 32'h28d};
        regs[21] = {26'b0, 32'h281, 32'h285, 32'h0, 32'h28d};
        regs[22] = 154'b0;
        regs[23] = 154'b0;
        regs[24] = 154'b0;
        regs[25] = {26'b0, 32'h191, 32'h195, 32'h199, 32'h191};
        regs[26] = 154'b0;
        regs[27] = 154'b0;
        regs[28] = 154'b0;
        regs[29] = {26'b0, 32'h1d1, 32'h1d5, 32'h1d9, 32'h1dd};
        regs[30] = 154'b0;
        regs[31] = 154'b0;
        regs[32] = 154'b0;
        regs[33] = {26'b0, 32'h55555555, 32'h66666666, 32'h77777777, 32'h88888888};
        regs[34] = 154'b0;
        regs[35] = 154'b0;
        regs[36] = 154'b0;
        regs[37] = 154'b0;
        regs[38] = 154'b0;
        regs[39] = 154'b0;
        regs[40] = {26'b0, 32'h281, 32'h0, 32'h285, 32'h28d};
        regs[41] = 154'b0;
        regs[42] = 154'b0;
        regs[43] = 154'b0;
        regs[44] = 154'b0;
        regs[45] = 154'b0;
        regs[46] = 154'b0;
        regs[47] = 154'b0;
        regs[48] = {26'b0, 32'h55555555, 32'h66666666, 32'h77777777, 32'h88888888};
        regs[49] = {26'b0, 32'h55555555, 32'h66666666, 32'h77777777, 32'h88888888};
        regs[50] = 154'b0;
        regs[51] = 154'b0;
        regs[52] = 154'b0;
        regs[53] = 154'b0;
        regs[54] = 154'b0;
        regs[55] = 154'b0;
        regs[56] = 154'b0;
        regs[57] = {26'b0, 32'h391, 32'h0, 32'h395, 32'h39d};
        regs[58] = 154'b0;
        regs[59] = 154'b0;
        regs[60] = 154'b0;
        regs[61] = {26'b0, 32'h3d1, 32'h3d5, 32'h3d9, 32'h3dd};
        regs[62] = 154'b0;
        regs[63] = 154'b0;
    end
    
    always@(type or addr) begin

        if(type==1'b1) begin
            regs[addr[9:4]][31:0]=write_data;
        end
        if(type==1'b0) begin
            read_data=regs[addr[9:4]][31:0];//read_data=regs[addr>>2]
        end
        #2 done=1;
        #2 done=0;

        if(type==1'b1) begin
            regs[addr[9:4]][63:32]=write_data;
        end
        if(type==1'b0) begin
            read_data=regs[addr[9:4]][63:32];//read_data=regs[addr>>2]
        end
        #2 done=1;
        #2 done=0;
        
        if(type==1'b1) begin
            regs[addr[9:4]][95:64]=write_data;
        end
        if(type==1'b0) begin
            read_data=regs[addr[9:4]][95:64];//read_data=regs[addr>>2]
        end
        #2 done=1;
        #2 done=0;
                
        if(type==1'b1) begin
            regs[addr[9:4]][127:96]=write_data;
        end
        if(type==1'b0) begin
            read_data=regs[addr[9:4]][127:96];//read_data=regs[addr>>2]
        end
        #2 done=1;
        #2 done=0;
    end
    
endmodule

module processor (
    input  hit_miss,
    input  clock,
    output read_write,
    output [13:0] address,
    output [31:0] write_data
);
    parameter  request_total = 12; // change this number to how many requests you want in your testbench
    reg [4:0]  request_num;
    reg        read_write_test[request_total-1:0];
    reg [13:0]  address_test[request_total-1:0];
    reg [31:0] write_data_test[request_total-1:0]; 
    initial begin
        #0 request_num = 0;
        read_write_test[0]  = 1; address_test[0]  = 14'b000100_100_0_1000; write_data_test[0]  = 1;       // sw, virtual page  4, TLB miss, mapped to physical page 2, physical tag 10100, cache miss in set 0 block 0,
        read_write_test[1]  = 1; address_test[1]  = 14'b000000_100_1_1100; write_data_test[1]  = 12'hdac; // sw, virtual page  0, TLB miss, mapped to physical page 1, physical tag 01100, cache miss in set 1 block 0,
        read_write_test[2]  = 1; address_test[2]  = 14'b000001_100_1_1000; write_data_test[2]  = 12'hfac; // sw, virtual page  1, TLB miss, mapped to physical page 3, physical tag 11100, cache miss in set 1 block 1,
        read_write_test[3]  = 1; address_test[3]  = 14'b000000_100_1_1001; write_data_test[3]  = 12'hfac; // sb, virtual page  0, TLB hit,  mapped to physical page 1, physical tag 01100, cache hit  in set 1 block 0,
        read_write_test[4]  = 0; address_test[4]  = 14'b000111_100_1_0101; write_data_test[4]  = 0;       // lb, virtual page  7, TLB miss, mapped to physical page 1, physical tag 01100, cache hit  in set 1 block 0,
        read_write_test[5]  = 0; address_test[5]  = 14'b001000_110_1_0101; write_data_test[5]  = 0;       // lb, virtual page  8, TLB miss, mapped to physical page 1, virtual page 4 replaced, write back entry with virtual tag 4,
                                                                                                          //                                                           physical tag 01110, cache miss in set 1, set 1 block 1 replaced and write back
        read_write_test[6]  = 0; address_test[6]  = 14'b000001_110_1_0100; write_data_test[6]  = 0;       // lw, virtual page  1, TLB hit,  mapped to physical page 3, physical tag 11110, cache miss in set 1, set 1 block 0 replaced and write back
        read_write_test[7]  = 1; address_test[7]  = 14'b000111_100_1_0111; write_data_test[7]  = 12'h148; // sb, virtual page  7, TLB hit,  mapped to physical page 1, physical tag 01100, cache miss in set 1, set 1 block 1 replaced
        read_write_test[8]  = 0; address_test[8]  = 14'b000000_100_1_1000; write_data_test[8]  = 0;       // lw, virtual page  0, TLB hit,  mapped to physical page 1, physical tag 01100, cache hit  in set 1 block 1,
        read_write_test[9]  = 0; address_test[9]  = 14'b001010_100_1_0100; write_data_test[9]  = 0;       // lw, virtual page 10, TLB miss, mapped to physical page 1, virtual page 8 replaced, write back entry with virtual tag 8,
                                                                                                          //                                                           physical tag 01100, cache hit  in set 1 block 1,
        read_write_test[10] = 0; address_test[10] = 14'b000000_110_1_0100; write_data_test[10] = 0;       // lw, virtual page  0, TLB hit,  mapped to physical page 1, physical tag 01110, cache miss in set 1, set 1 block 1 replaced
        read_write_test[11] = 0; address_test[11] = 14'b000100_100_0_1000; write_data_test[11] = 0;       // lw, virtual page  4, TLB miss, mapped to physical page 2, virtual page 1 replaced, write back entry with virtual tag 1,
                                                                                                          //                                                           physical tag 10100, cache hit  in set 1 block 0
        read_write_test[12] = 0; address_test[12] = 14'b000010_110_1_0100; write_data_test[12] = 0;       // lw, virtual page  2, TLB miss, page fault

        /* extra test for fun; it is acceptable that you have different result after the request below */
        read_write_test[13] = 0; address_test[13] = 14'b000111_100_1_1100; write_data_test[13] = 0;       // lw, virtual page  10, TLB hit, mapped to physical page 1, physcial tag 01100, cache hit in set 1 block 1
        // Notes: actually in this lab you are not required to handle page fault, but ideally you may just skip the request with page fault and deal with the next request normally (it only applies to this lab!!!)
        // In other words, nothing should be changed when there is a page fault in this lab, including TLB, page table, cache and memory.
        // But such requirement is cancelled considering your workload :)
    end
    always @(posedge clock) begin
        if (hit_miss == 1) request_num = request_num + 1; // hit_miss indicates the page fault in TLB.
        else request_num = request_num;
    end
    assign address      = address_test[request_num];
    assign read_write   = read_write_test[request_num];
    assign write_data   = write_data_test[request_num]; 
endmodule

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
    reg [4:0] tag [3:0];
    reg [31:0] data [15:0];
    reg reference [3:0];
    
    //byte address
    //reg [9:0] addr_in;
    
//    always @ (addr_in_) begin
//        if (addr_in_[3:2] == 2'b10) addr_in = {addr_in_[9:4], 2'b01, addr_in_[1:0]};
//        else if (addr_in_[3:2] == 2'b01) addr_in = {addr_in_[9:4], 2'b10, addr_in_[1:0]};
//        else addr_in = addr_in_;
//    end
    
    wire [4:0] data_tag;
    wire index;
    //reg [1:0] real_word;
    wire [1:0] word_offset;
    wire [1:0] byte_offset;
    assign data_tag = addr_in[9:5];
    assign index = addr_in[4];
    assign word_offset = addr_in[3:2];
    assign byte_offset = addr_in[1:0];

    
    //load byte
    wire is_byte;
    assign is_byte=(byte_offset>0);

    reg already_written;
    
    integer i, record; //initialize
    initial begin
        for(i=0;i<4;i=i+1) begin
            valid[i]=0;
            dirty[i]=0;
            tag[i]=0;
            data[i]=0;
            reference[i]=0;
        end
    end

    always@(*) begin
        #3;//#2;
        //Basicly, I divide it into 2 parts, write or read.
        already_written = 0;
        record = 4;

        if(type_in==1) begin //write
            //check if hit
            if (index == 0) begin
                if(valid[0]==1 && tag[0]==data_tag) begin
                    hit_miss=1;
                    reference[0] = 1;
                    reference[1] = 0;
                    record = 0;
                    already_written = 1;
                end else if (valid[1]==1 && tag[1]==data_tag) begin
                    hit_miss=1;
                    reference[0] = 0;
                    reference[1] = 1;
                    record = 1;
                    already_written = 1;
                end else hit_miss = 0;
            end else begin
                if(valid[2]==1 && tag[2]==data_tag) begin
                    hit_miss=1;
                    reference[2] = 1;
                    reference[3] = 0;
                    record = 2;
                    already_written = 1;
                end else if (valid[3]==1 && tag[3]==data_tag) begin
                    hit_miss=1;
                    reference[2] = 0;
                    reference[3] = 1;
                    record = 3;
                    already_written = 1;
                end else hit_miss = 0;
            end
            //check valid
            #2;
            if (hit_miss == 0) begin
                if (index == 0) begin 
                    if ((valid[0] == 0 && already_written == 0) || (valid[0] == 1 && valid[1] == 1 && already_written == 0 && reference[0] == 0)) begin
                        already_written = 1;
                        record = 0;
                        reference[0] = 1;
                        reference[1] = 0;
                    end else if ((valid[1] == 0 && already_written == 0) || (valid[0] == 1 && valid[1] == 1 && already_written == 0 && reference[1] == 0)) begin
                        already_written = 1;
                        record = 1;
                        reference[0] = 0;
                        reference[1] = 1;
                    end
                end else begin
                    if ((valid[2] == 0 && already_written == 0) || (valid[2] == 1 && valid[3] == 1 && already_written == 0 && reference[2] == 0)) begin
                        already_written = 1;
                        record = 2;
                        reference[2] = 1;
                        reference[3] = 0;
                    end else if ((valid[3] == 0 && already_written == 0) || (valid[2] == 1 && valid[3] == 1 && already_written == 0 && reference[3] == 0)) begin
                        already_written = 1;
                        record = 3;
                        reference[2] = 0;
                        reference[3] = 1;
                    end
                end
            end
            //check if dirty
            if(dirty[record]==1'b1) begin
                //write back the previous data
                type_out=1;
                addr_out={tag[record], index, {4{1'b0}}};
                write_data_out=data[record*4];
                #3;                    
                for(i=1;i<4;i=i+1) begin
                    if(done==1) begin
                        addr_out=addr_out+4;
                        write_data_out=data[record*4+i];
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
                        data[record*4+i]=read_data_in;
                        addr_out=addr_out+4;
                    end
                    #2;
                end
                valid[record]=1;
                tag[record]=data_tag;
            //write data
            hit_miss=1;
            
            if(!is_byte) data[record*4+word_offset]=write_data_in; //word
            else if (byte_offset == 2'b00) data[record*4+word_offset][7:0]=write_data_in[7:0];  //byte, little Endian
            else if (byte_offset == 2'b01) data[record*4+word_offset][15:8]=write_data_in[7:0];
            else if (byte_offset == 2'b10) data[record*4+word_offset][23:16]=write_data_in[7:0];
            else if (byte_offset == 2'b11) data[record*4+word_offset][31:24]=write_data_in[7:0];
            dirty[record]=1;            
        end
        //read
        else begin
            //check if hit
            if (index == 0) begin
                if(valid[0]==1 && tag[0]==data_tag) begin
                    hit_miss=1;
                    reference[0] = 1;
                    reference[1] = 0;
                    record = 0;
                    already_written = 1;
                end else if (valid[1]==1 && tag[1]==data_tag) begin
                    hit_miss=1;
                    reference[0] = 0;
                    reference[1] = 1;
                    record = 1;
                    already_written = 1;
                end else hit_miss = 0;
            end else begin
                if(valid[2]==1 && tag[2]==data_tag) begin
                    hit_miss=1;
                    reference[2] = 1;
                    reference[3] = 0;
                    record = 2;
                    already_written = 1;
                end else if (valid[3]==1 && tag[3]==data_tag) begin
                    hit_miss=1;
                    reference[2] = 0;
                    reference[3] = 1;
                    record = 3;
                    already_written = 1;
                end else hit_miss = 0;
            end
            //check valid
            if (hit_miss == 0) begin
                if (index == 0) begin 
                    if ((valid[0] == 0 && already_written == 0) || (valid[0] == 1 && valid[1] == 1 && already_written == 0 && reference[0] == 0)) begin
                        already_written = 1;
                        record = 0;
                        reference[0] = 1;
                        reference[1] = 0;
                    end else if ((valid[1] == 0 && already_written == 0) || (valid[0] == 1 && valid[1] == 1 && already_written == 0 && reference[1] == 0)) begin
                        already_written = 1;
                        record = 1;
                        reference[0] = 0;
                        reference[1] = 1;
                    end
                end else begin
                    if ((valid[2] == 0 && already_written == 0) || (valid[2] == 1 && valid[3] == 1 && already_written == 0 && reference[2] == 0)) begin
                        already_written = 1;
                        record = 2;
                        reference[2] = 1;
                        reference[3] = 0;
                    end else if ((valid[3] == 0 && already_written == 0) || (valid[2] == 1 && valid[3] == 1 && already_written == 0 && reference[3] == 0)) begin
                        already_written = 1;
                        record = 3;
                        reference[2] = 0;
                        reference[3] = 1;
                    end
                end
            end
            //check if dirty
            if(dirty[record]==1'b1) begin
                //write back the previous data
                type_out=1;
                addr_out={tag[record], index, {4{1'b0}}};
                write_data_out=data[record*4];
                #3;                    
                for(i=1;i<4;i=i+1) begin
                    if(done==1) begin
                        addr_out=addr_out+4;
                        write_data_out=data[record*4+i];
                    end
                    #4;                    
                end
                #5;
            end
                //load the blocks into cache
                addr_out={addr_in[9:4], {4{1'b0}}};
                type_out=0;
                #1;
                for(i=0;i<4;i=i+1) begin
                    #2;
                    if(done==1) begin
                        data[record*4+i]=read_data_in;
                        addr_out=addr_out+4;
                    end
                    #2;
                end
                valid[record]=1;
                tag[record]=data_tag;       
            //return data
            hit_miss=1;
            
//            if (word_offset == 2'b10) real_word = 2'b01;
//            else if (word_offset == 2'b10) real_word = 2'b10;
//            else real_word = word_offset;
            if(!is_byte) read_data_out=data[record*4+word_offset];//word_offset
            else read_data_out={{24{1'b0}},data[record*4+word_offset][(byte_offset*8+7)-:8]};
        end
    end    
        
endmodule