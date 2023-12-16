`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 23:02:19
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
)
;
    reg             clk;
    wire            write_in; /* 1 if write, 0 if read */
    wire [2:0]      funct;
    wire [31:0]     write_data_in, read_data_out;
    wire            done_tlb, done_cache, write_out;
    wire [31:0]     read_data_in, write_data_out;
    wire [9:0]      addr_out;
    wire            Addr_prepared;
    wire            write_to_table;
    wire [5:0]      V_addr_PT_out;
    wire [1:0]      P_addr_PT_out;
    wire [9:0]      Physical_addr;
    wire [1:0]      phy_page_num;
    wire [13:0]     virtual_address;  
    
    processor cpu (hit, clk, write_in, funct, virtual_address, write_data_in);
    New_Cache cache (done_cache, write_in, Addr_prepared, funct, Physical_addr, read_data_in, write_data_in, hit, write_out, read_data_out, write_data_out, addr_out);
    TLB tlb (done_tlb, virtual_address, phy_page_num, write_in, TLB_hit, write_to_table, V_addr_PT_out, P_addr_PT_out, Physical_addr, Addr_prepared);
    Main_Memory mem (write_out, addr_out, write_data_out, read_data_in, done_cache);        
    PageTable pag_tb(write_to_table, P_addr_PT_out, V_addr_PT_out, done_tlb, phy_page_num, page_fault);       
    
    

    wire    [4:0]       Request_num = cpu.Request_num;
    wire                RW_test[5:0] = cpu.RW_test;
    wire    [2:0]       funct_test[5:0] = cpu.funct_test;
    wire    [13:0]      Address_test[5:0] = cpu.Address_test;
    wire    [31:0]      Writedata_test[5:0] = cpu.Writedata_test;
    
    wire                pos_done=cache.done;           
    wire    [1:0]       LRU=cache.LRU_ref;
    wire    [134:0]     cacheA[1:0]=cache.cache_setA;
    wire    [134:0]     cacheB[1:0]=cache.cache_setB;
    wire                setIndex=cache.setIndex;
    wire                validA=cache.valid_A, dirtyA=cache.dirty_A, validB=cache.valid_B, dirtyB=cache.dirty_B;
    wire                equal_A=cache.equal_A, equal_B=cache.equal_B;
    wire    [31:0]      lw_out=cache.lw_out, lb_out=cache.lb_out;
    wire    [134:0]     block_A=cache.block_A;
    wire    [134:0]     block_B=cache.block_B;
    
    wire 	[31:0]       memory[255:0]=mem.regs;

    wire    [15:0]       TLB[3:0]=tlb.TLB;  
    wire    [3:0]        Hit=tlb.Hit;              
    wire    [5:0]        VPN=tlb.VPN;   

    wire    [31:0] 	     pagetable[31:0] = pag_tb.pagetable;
   
    always #30 clk = ~clk;

    always @(posedge clk) begin
        $display("Request %d: ", cpu.Request_num);
        $display("page fault: %b", pag_tb.PageFault);
        $display("cache hit: %b",cache.hit);
        $display("data read posedge: %H", read_data_out);
        $display("contents in TLB: ");
        $display("block 00: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", TLB[3][9:4], TLB[3][15], TLB[3][14], TLB[3][13:12],TLB[3][1:0]);
        $display("block 01: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", TLB[2][9:4], TLB[2][15], TLB[2][14], TLB[2][13:12],TLB[2][1:0]);
        $display("block 10: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", TLB[1][9:4], TLB[1][15], TLB[1][14], TLB[1][13:12],TLB[1][1:0]);
        $display("block 11: tag: %2d, valid: %b, dirty: %b, reference: %b, VPN: %1d", TLB[0][9:4], TLB[0][15], TLB[0][14], TLB[0][13:12],TLB[0][1:0]);
        $display("contents in cache: ");
        $display("block 00: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cache.cache_setA[0][132-: 5], cache.cache_setA[0][134], cache.cache_setA[0][133],  cache.cache_setA[0][127:96],  cache.cache_setA[0][95:64],  cache.cache_setA[0][63:32],  cache.cache_setA[0][31:0]);
        $display("block 01: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cache.cache_setB[0][132-: 5], cache.cache_setB[0][134], cache.cache_setB[0][133],  cache.cache_setB[0][127:96],  cache.cache_setB[0][95:64],  cache.cache_setB[0][63:32],  cache.cache_setB[0][31:0]);
        $display("block 10: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cache.cache_setA[1][132-: 5], cache.cache_setA[1][134], cache.cache_setA[1][133],  cache.cache_setA[1][127:96],  cache.cache_setA[1][95:64],  cache.cache_setA[1][63:32],  cache.cache_setA[1][31:0]);
        $display("block 11: tag: %b, valid: %b, dirty: %b, word0: %H, word1: %H, word2: %H, word3: %H", cache.cache_setB[1][132-: 5], cache.cache_setB[1][134], cache.cache_setB[1][133],  cache.cache_setB[1][127:96],  cache.cache_setB[1][95:64],  cache.cache_setB[1][63:32],  cache.cache_setB[1][31:0]);
    end
    
    initial begin
        clk = 0;
    end
    
    initial #1000 $stop;
    
endmodule


module processor(
    input Miss,
    input clock,
    output RW,
    output [2:0] funct,
    output [13:0] Address,
    output [31:0] Writedata
);
    parameter Request = 13;
    reg [4:0] Request_num;
    reg RW_test[Request - 1:0];
    reg [2:0] funct_test[Request - 1:0];
    reg [13:0] Address_test[Request - 1:0]; //change to 14 bits
    reg [31:0] Writedata_test[Request - 1:0];
    
    
    
    initial begin
        Request_num = 0;
        RW_test[0]  = 1; funct_test[0] = 3'b010; Address_test[0]  = 14'b000100_100_0_1000; Writedata_test[0]  = 1;       // sw, virtual page  4, TLB miss, mapped to physical page 2, physical tag 10100, cache miss in set 0 block 0,
        RW_test[1]  = 1; funct_test[1] = 3'b010; Address_test[1]  = 14'b000000_100_1_1100; Writedata_test[1]  = 12'hdac; // sw, virtual page  0, TLB miss, mapped to physical page 1, physical tag 01100, cache miss in set 1 block 0,
        RW_test[2]  = 1; funct_test[2] = 3'b010; Address_test[2]  = 14'b000001_100_1_1000; Writedata_test[2]  = 12'hfac; // sw, virtual page  1, TLB miss, mapped to physical page 3, physical tag 11100, cache miss in set 1 block 1,
        RW_test[3]  = 1; funct_test[3] = 3'b000; Address_test[3]  = 14'b000000_100_1_0101; Writedata_test[3]  = 12'hfac; // sb, virtual page  0, TLB hit,  mapped to physical page 1, physical tag 01100, cache hit  in set 1 block 0,
        RW_test[4]  = 0; funct_test[4] = 3'b000; Address_test[4]  = 14'b000111_100_1_0101; Writedata_test[4]  = 0;       // lb, virtual page  7, TLB miss, mapped to physical page 1, physical tag 01100, cache hit  in set 1 block 0,
        RW_test[5]  = 0; funct_test[5] = 3'b000; Address_test[5]  = 14'b001000_110_1_0101; Writedata_test[5]  = 0;       // lb, virtual page  8, TLB miss, mapped to physical page 1, virtual page 4 replaced, write back entry with virtual tag 4,
                                                                                                         //                                                           physical tag 01110, cache miss in set 1, set 1 block 1 replaced and write back
        RW_test[6]  = 0; funct_test[6] = 3'b010; Address_test[6]  = 14'b000001_110_1_0100; Writedata_test[6]  = 0;       // lw, virtual page  1, TLB hit,  mapped to physical page 3, physical tag 11110, cache miss in set 1, set 1 block 0 replaced and write back
        RW_test[7]  = 1; funct_test[7] = 3'b000; Address_test[7]  = 14'b000111_100_1_0111; Writedata_test[7]  = 12'h148; // sb, virtual page  7, TLB hit,  mapped to physical page 1, physical tag 01100, cache miss in set 1, set 1 block 1 replaced
        RW_test[8]  = 0; funct_test[8] = 3'b010; Address_test[8]  = 14'b000000_100_1_1000; Writedata_test[8]  = 0;       // lw, virtual page  0, TLB hit,  mapped to physical page 1, physical tag 01100, cache hit  in set 1 block 1,
        RW_test[9]  = 0; funct_test[9] = 3'b010; Address_test[9]  = 14'b001010_100_1_0100; Writedata_test[9]  = 0;       // lw, virtual page 10, TLB miss, mapped to physical page 1, virtual page 8 replaced, write back entry with virtual tag 8,
                                                                                                                                                                  //  physical tag 01100, cache hit  in set 1 block 1,
        RW_test[10] = 0; funct_test[10] = 3'b010; Address_test[10] = 14'b000000_110_1_0100; Writedata_test[10] = 0;       // lw, virtual page  0, TLB hit,  mapped to physical page 1, physical tag 01110, cache miss in set 1, set 1 block 1 replaced
        RW_test[11] = 0; funct_test[11] = 3'b010; Address_test[11] = 14'b000100_100_0_1000; Writedata_test[11] = 0;       // lw, virtual page  4, TLB miss, mapped to physical page 2, virtual page 1 replaced, write back entry with virtual tag 1,
                                                                                                                                                                  //   physical tag 10100, cache hit  in set 1 block 0
        RW_test[12] = 0; funct_test[12] = 3'b010; Address_test[12] = 14'b000010_110_1_0100; Writedata_test[12] = 0;       // lw, virtual page  2, TLB miss, page fault
        /* extra test for fun; it is acceptable that you have different result after the request below */
        RW_test[13] = 0; funct_test[13] = 3'b010; Address_test[13] = 14'b000111_100_1_1100; Writedata_test[13] = 0;       // lw, virtual page  10, TLB hit, mapped to physical page 1, physcial tag 01100, cache hit in set 1 block 1
        
        /* add lines if necessary */
           
    end
    
    always @(posedge clock) begin
        if (Miss == 1) begin Request_num = Request_num + 1; end
        else begin Request_num = Request_num; end
    end
        assign funct = funct_test[Request_num];
        assign Address = Address_test[Request_num];
        assign RW = RW_test[Request_num];
        assign Writedata = Writedata_test[Request_num]; 
endmodule