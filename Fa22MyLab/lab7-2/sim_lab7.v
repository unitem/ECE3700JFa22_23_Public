`timescale 1ns / 1ps

module sim_lab7;
reg clk, address_done;
wire [13:0] virtual_address; //reg
wire [1:0] input_physical_page, output_physical_page;
wire [9:0] physical_address;
wire [5:0] index;
wire [31:0] write_data_in, write_data_out, addr, write_data, read_data;
wire update_page, update_page_, page_fault, search_page_table, write_back, type_new, hit_miss, mem_done;
TLB tlb(virtual_address,
        output_physical_page, // Only tag.
        update_page_,
        physical_address,
        search_page_table,
        write_back,
        index,
        input_physical_page
);
Page_table tb(virtual_address,
              input_physical_page, // output_physical_page from TLB
              index,
              write_back,
              search_page_table,
              output_physical_page,
              update_page_,
              page_fault
);
cache cash(
    update_page, //1 for write, 0 for read
    physical_address,
    write_data_in,
    read_data,
    mem_done,
    type_new,
    addr,
    write_data,
    write_data_out,
    hit_miss //1 for hit, 0 for miss    
);
//New_Cache cash(mem_done,
//    update_page,
//    address_done,
//    funct,
//    physical_address,
//    read_data,
//    write_data_in,
//    hit_miss,
//    type_new,
//    read_data_out,
//    write_data,
//    write_data_out
//    );
main_memory me(
    type_new, //1 for write, 0 for read
    addr,
    write_data,
    read_data,
    mem_done
);
processor psor(
    hit_miss,
    clk,
    update_page,
    virtual_address,
    write_data_in
);

    always @(posedge clk) begin
    $display("Request %d: ", psor.request_num);
    $display("page fault: %b", tb.page_fault);
    $display("data read posedge: %H", write_data_out);
    $display("contents in TLB: ");
    $display("block 00: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", tlb.tag[0], tlb.valid[0], tlb.dirty[0], tlb.reference[0], tlb.translation[0]);
    $display("block 01: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", tlb.tag[1], tlb.valid[1], tlb.dirty[1], tlb.reference[1], tlb.translation[1]);
    $display("block 10: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", tlb.tag[2], tlb.valid[2], tlb.dirty[2], tlb.reference[2], tlb.translation[2]);
    $display("block 11: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", tlb.tag[3], tlb.valid[3], tlb.dirty[3], tlb.reference[3], tlb.translation[3]);
    $display("contents in cache: ");
    $display("block 00: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cash.tag[0], cash.valid[0], cash.dirty[0], cash.data[0], cash.data[1], cash.data[2], cash.data[3]);
    $display("block 01: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cash.tag[1], cash.valid[1], cash.dirty[1], cash.data[4], cash.data[5], cash.data[6], cash.data[7]);
    $display("block 10: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cash.tag[2], cash.valid[2], cash.dirty[2], cash.data[8], cash.data[9], cash.data[10], cash.data[11]);
    $display("block 11: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cash.tag[3], cash.valid[3], cash.dirty[3], cash.data[12], cash.data[13], cash.data[14], cash.data[15]);
end

initial begin
//    #2 virtual_address = 14'b00010010001000;
//    #2 virtual_address = 14'b00000010011100;
//    #2 virtual_address = 14'b00000110011000;
//    #2 virtual_address = 14'b00000010010101;
//    #2 virtual_address = 14'b00011110010101;
//    #2 virtual_address = 14'b00100011010101;
//    #2 virtual_address = 14'b000001_110_1_0100;
//    #2 virtual_address = 14'b000111_100_1_0111;
//    #2 virtual_address = 14'b000000_100_1_1000;
//    #2 virtual_address = 14'b001010_100_1_0100;
    #10 clk = 0;
    
    #1000  $stop;
end

always #25 clk = ~clk;

endmodule
