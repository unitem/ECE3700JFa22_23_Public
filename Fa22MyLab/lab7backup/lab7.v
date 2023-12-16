`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 23:01:24
// Design Name: 
// Module Name: lab7
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


module New_Cache #(
    parameter   index_exp  = 1,                         // Total blocks in cache = 2^index_exp
    parameter   words_exp  = 2,                         // Size (words) in each block = 2^words_exp
    parameter   addr_width = 10,                        // Width of address
    ////////////////////////////////////////////////////// You don't need to modify the following.~
    parameter   index_rows = 2 ** index_exp,                            // 2
    parameter   tag_length = addr_width - index_exp - words_exp  - 2,   // 5
    parameter   cache_width = 32 * (2 ** words_exp) + tag_length + 2,   // 135
    parameter   n = cache_width, r = addr_width, tag = tag_length
)(
    input                           done,               // From main memory
    input                           write_read,           // From CPU request, 1'b1 for write, 1'b0 for read
    input                           address_done,      // From TLB address
    input       [2:0]               funct,              // From CPU request, for differentiating lw,lb (,lbu )
                                                        // 000 for lb/sb, 010 for lw/sw
    input       [9:0]    address_req,          // From physicalTLB 
    input       [31:0]              read_data_in,       // From main memory
    input       [31:0]              write_data_in,      // From CPU request
    
    output                          hit,                // To CPU request, 1'b1 for hit,   1'b0 for miss 
    output reg                      write_read_out,          // To main memory, 1'b1 for write, 1'b0 for read 
    output      [31:0]              read_data_out,      // To CPU request
    output reg  [31:0]              write_data_out,     // To main memory
    output reg  [addr_width-1:0]    addr_out            // To main memory
);
    
    reg                             pos_done;           // NEW
    reg         [1:0]   LRU_ref;
    reg         [134:0]   cache_setA          [1:0];
    reg         [134:0]   cache_setB          [1:0];
    ////////////////////////////////////////////////////// 7 MSB of cache is V(1'b)+D(1'b)+Tag(5'b) // NEW

    wire                            hit_setA, hit_setB, equal_A, equal_B; // NEW
    wire        [31:0]              data_A, data_B, lw_out, lb_out; //, lbu_out;
    wire        [134:0]   block_A, block_B; // NEW
    
    ////////////////////////////////////////////////////// for simplicity by WL and CWQ
    wire                            setIndex; // NEW (Change From 2 bits To 1 bit)
    wire        [4:0]           tagContent_A, tagContent_B; // NEW (Change From 4 bits To 5 bits)
    wire                            valid_A, dirty_A, valid_B, dirty_B; // NEW

    integer i;
    initial begin
        pos_done = 0; addr_out = 0; 
        write_read_out = 0; write_data_out = 0; 
        for (i = 0; i < index_rows; i = i + 1) begin
            cache_setA[i] = 0; cache_setB[i] = 0; LRU_ref[i] = 0;
        end
    end
    
    assign  setIndex = address_req[4];
    assign  block_A = cache_setA[setIndex];
    assign  block_B = cache_setB[setIndex];
    assign  tagContent_A = block_A[(n-3)-: tag];
    assign  tagContent_B = block_B[(n-3)-: tag];
    assign  equal_A = (tagContent_A == address_req[(r-1)-: tag]);
    assign  equal_B = (tagContent_B == address_req[(r-1)-: tag]);
    assign  valid_A = block_A[n-1];
    assign  valid_B = block_B[n-1];
    assign  dirty_A = block_A[n-2];
    assign  dirty_B = block_B[n-2];
    
    ////////////////////////////////////////////////////// To CPU request
    or  (hit, hit_setA, hit_setB);
    and (hit_setA, valid_A, equal_A);
    and (hit_setB, valid_B, equal_B);

    MUX_4 Mux_CacheOut1(address_req[3:2], block_A[31-: 32], block_A[63-: 32], block_A[95-: 32], block_A[127-:32], data_A);
    MUX_4 Mux_CacheOut2(address_req[3:2], block_B[31-: 32], block_B[63-: 32], block_B[95-: 32], block_B[127-:32], data_B);
    MUX_8 Mux_CacheData({write_read,hit_setB, hit_setA}, lw_out, data_A, data_B, lw_out,lw_out,lw_out,lw_out,lw_out, lw_out);
    
    //MUX_4 Mux_Cache_lb (address_req[1:0], {{24{lw_out[7]}}, lw_out[7:0]}, {{24{lw_out[7]}}, lw_out[15:8]}, {{24{lw_out[7]}}, lw_out[23:16]}, {{24{lw_out[7]}}, lw_out[31:24]}, lb_out);
    MUX_4 Mux_Cache_lb (address_req[1:0], {{24{0}}, lw_out[7:0]}, {{24{0}}, lw_out[15:8]}, {{24{0}}, lw_out[23:16]}, {{24{0}}, lw_out[31:24]}, lb_out);
    MUX_8 Mux_Data_Out (.s(funct), .MUXinput1(lb_out), .MUXinput2(read_data_out), .MUXinput3(lw_out), .MUXinput4(read_data_out),
                                    .MUXinput5(read_data_out), .MUXinput6(read_data_out), .MUXinput7(read_data_out), .MUXinput8(read_data_out), .MUXoutput(read_data_out));
    


    always @ (*) begin
        #2
        if (address_done)begin
            if (write_read) begin // sw/sb
                if (!hit) begin // miss
                    if (LRU_ref[setIndex]==1'b0) begin
                        // Write data from cache to memory if dirty
                        if (dirty_A) begin i = 63;
                            addr_out = {{tagContent_A,setIndex},{4{1'b0}}};
                            write_data_out = block_A[31:0];
                            write_read_out = 1'b1;
                            #3;
                            for (i = 63; i <128; i = i + 32) begin
                            if(done==1) begin
                                addr_out = addr_out +4;
                                write_data_out = block_A[i-: 32];
                            end
                            #4;
                            end
                            #5;
                        end
                        // Read data from memory to cache anyway
                        addr_out = {address_req[9:4],{4{1'b0}}};
                        write_read_out = 1'b0;
                        #1;
                        for (i = 31; i <128; i = i + 32) begin
                            #2;
                            if(done==1) begin
                                cache_setA[setIndex][i-: 32] = read_data_in;
                                addr_out = addr_out + 4;
                            end
                            #2;
                        end
                        cache_setA[setIndex][n-1] = 1'b1; // Set Valid to True 
                        LRU_ref[setIndex] = 1'b1; // Reset Least Resently Used 
                        case(funct)
                            3'b000: begin i = 32 * address_req[3:2] + 8 * address_req[1:0] + 7;
                                    cache_setA[setIndex][i-: 8] = write_data_in[7:0]; end // sb
                            default:begin i = 31 + 32 * address_req[3:2];
                                    cache_setA[setIndex][i-: 32] = write_data_in; end // sw
                        endcase
                        cache_setA[setIndex][n-2] = 1'b1; // Mark cache_setA dirty
                        cache_setA[setIndex][(n-3)-: tag] = address_req[9-: tag];
                    end 
                    else begin
                        // Write data from cache to memory if dirty
                        if (dirty_B) begin i = 63;
                            addr_out = {{tagContent_A,setIndex},{4{1'b0}}};
                            write_data_out = block_A[31:0];
                            write_read_out = 1'b1;
                            #3;
                            for (i = 63; i <128; i = i + 32) begin
                            if(done==1) begin
                                addr_out = addr_out +4;
                                write_data_out = block_A[i-: 32];
                            end
                            #4;
                            end
                            #5;
                        end i = 63;
                        // Read data from memory to cache anyway
                        #1
                        addr_out = {address_req[9:4],{4{1'b0}}};
                        write_read_out = 1'b0;
                        for (i = 31; i <128; i = i + 32) begin
                            #2;
                            if(done==1) begin
                                cache_setB[setIndex][i-: 32] = read_data_in;
                                addr_out = addr_out + 4;
                            end
                            #2;
                        end
                        cache_setB[setIndex][n-1] = 1; // Set Valid to True
                        LRU_ref[setIndex] = 0; // Reset Least Resently Used 
                        case(funct)
                            3'b000: begin i = 32 * address_req[3:2] + 8 * address_req[1:0] + 7;
                                    cache_setB[setIndex][i-: 8] = write_data_in[7:0]; end // sb
                            default:begin i = 31 + 32 * address_req[3:2];
                                    cache_setB[setIndex][i-: 32] = write_data_in; end // sw
                        endcase
                        cache_setB[setIndex][n-2] = 1'b1; // Mark cache_setB dirty
                        cache_setB[setIndex][(n-3)-: tag] = address_req[9-: tag];
                    end
                end
                else if (hit_setA) begin
                    case(funct)
                        3'b000: begin i = 32 * address_req[3:2] + 8 * address_req[1:0] + 7;
                                cache_setA[setIndex][i-: 8] = write_data_in[7:0]; end // sb
                        default:begin i = 31 + 32 * address_req[3:2];
                                cache_setA[setIndex][i-: 32] = write_data_in; end // sw
                    endcase
                    cache_setA[setIndex][n-2] = 1'b1; // Mark cache_setA dirty
                    LRU_ref[setIndex] = 1'b1; // Reset Least Resently Used to setB
                    cache_setA[setIndex][(n-3)-: tag] = address_req[9-: tag];
                end
                else if (hit_setB) begin
                    case(funct)
                        3'b000: begin i = 32 * address_req[3:2] + 8 * address_req[1:0] + 7;
                                cache_setB[setIndex][i-: 8] = write_data_in[7:0]; end // sb
                        default:begin i = 31 + 32 * address_req[3:2];
                                cache_setB[setIndex][i-: 32] = write_data_in; end // sw
                    endcase
                    cache_setB[setIndex][n-2] = 1'b1; // Mark cache_setA dirty
                    LRU_ref[setIndex] = 1'b0; // Reset Least Resently Used to setA
                    cache_setB[setIndex][(n-3)-: tag] = address_req[9-: tag];
                end
            end
            else begin // read_out  // lw/lb
                if (!hit) begin 
                    if (LRU_ref[setIndex]==1'b0) begin
                        // Write data from cache to memory if dirty
                        if (dirty_A) begin i = 63;
                            addr_out = {{tagContent_A,setIndex},{4{1'b0}}};
                            write_data_out = block_A[31:0];
                            write_read_out = 1'b1;
                            #3;
                            for (i = 63; i <128; i = i + 32) begin
                            if(done==1) begin
                                addr_out = addr_out +4;
                                write_data_out = block_A[i-: 32];
                            end
                            #4;
                            end
                            #5;
                        end
                        // Read data from memory to cache anyway
                        addr_out = {address_req[9:4],{4{1'b0}}};
                        write_read_out = 1'b0;
                        #1;
                        for (i = 31; i <128; i = i + 32) begin
                            #2;
                            if(done==1) begin
                                cache_setA[setIndex][i-: 32] = read_data_in;
                                addr_out = addr_out + 4;
                            end
                            #2;
                        end
                        cache_setA[setIndex][n-2] = 1'b0; // Mark as NOT dirty
                        cache_setA[setIndex][n-1] = 1'b1; // Set Valid to True 
                        LRU_ref[setIndex] = 1'b1; // Reset Least Resently Used = B
                        cache_setA[setIndex][(n-3)-: tag] = address_req[9-: tag];
                    end
                    else begin
                        // Write data from cache to memory if dirty
                        if (dirty_B) begin i = 63;
                            addr_out = {{tagContent_A,setIndex},{4{1'b0}}};
                            write_data_out = block_A[31:0];
                            write_read_out = 1'b1;
                            #3;
                            for (i = 63; i <128; i = i + 32) begin
                            if(done==1) begin
                                addr_out = addr_out +4;
                                write_data_out = block_A[i-: 32];
                            end
                            #4;
                            end
                            #5;
                        end
                        // Read data from memory to cache anyway
                        addr_out = {address_req[9:4],{4{1'b0}}};
                        write_read_out = 1'b0;
                        #1;
                        for (i = 31; i <128; i = i + 32) begin
                            #2;
                            if(done==1) begin
                                cache_setA[setIndex][i-: 32] = read_data_in;
                                addr_out = addr_out + 4;
                            end
                            #2;
                        end
                        cache_setB[setIndex][n-2] = 1'b0; // Mark as NOT dirty
                        cache_setB[setIndex][n-1] = 1'b1; // Set Valid to True 
                        LRU_ref[setIndex] = 1'b0; // Reset Least Resently Used = A
                        cache_setB[setIndex][(n-3)-: tag] = address_req[9-: tag];
                    end
                end
                else if (hit_setA) begin
                    cache_setA[setIndex][(n-3)-: tag] = address_req[9-: tag];
                    LRU_ref[setIndex] = 1'b1; // Reset Least Resently Used = B
                end
                else if (hit_setB) begin
                    cache_setB[setIndex][(n-3)-: tag] = address_req[9-: tag];
                    LRU_ref[setIndex] = 1'b0; // Reset Least Resently Used = A
                end
            end
        end
    end        

endmodule

module TLB (
    input                           done,               // From PageTable, 1'b1 for done, 1'b0 for unfinished
    input       [13:0]              Virtual_addr,       // From Processor
    input       [9:0]               P_addr_PT_in,       // From PageTable
    input       RW,
    output                          TLB_hit,            // To Processor, 1'b1 for hit, 1'b0 for miss 
    output reg                      write_to_table,     // To PageTable, 1'b1 for write, 1'b0 for read
    output reg  [5:0]               V_addr_PT_out,      // To PageTable
    output reg  [1:0]               P_addr_PT_out,      // To PageTable
    output reg  [9:0]               Physical_addr,      // To Cache Mem
    output reg                      Addr_prepared       // To Cache Mem
);

    reg         [15:0]              TLB     [3:0];              // 1bit_Valid, 1bit_Dirty, 2bit_Ref = TLB[13:12],Tag = TLB[9:4]; Physical Page Addr = TLB[1:0]
    wire        [3:0]               Hit;                        
    wire        [5:0]               VPN;                        
    

    integer i, j, k;
    initial begin
        V_addr_PT_out = 0; P_addr_PT_out = 0; 
        Physical_addr = 0; Addr_prepared = 0;
        write_to_table = 0;
        for (i = 0; i < 4; i = i + 1) begin///
            TLB[i] = 0;
            TLB[i][13:12]=i;
        end
    end
    
    assign VPN = Virtual_addr[13-: 6];
    assign Hit[0] = (VPN == TLB[0][9:4]) && TLB[0][15];// tag=VPN and valid
    assign Hit[1] = (VPN == TLB[1][9:4]) && TLB[1][15];
    assign Hit[2] = (VPN == TLB[2][9:4]) && TLB[2][15];
    assign Hit[3] = (VPN == TLB[3][9:4]) && TLB[3][15];

    or (TLB_hit, Hit[0], Hit[1], Hit[2], Hit[3]);
    
    always @(*) begin
        if (!TLB_hit) begin 
            Addr_prepared = 1'b0;
            for (i = 0; i < 4; i = i + 1) begin // LRU_sel
                if (TLB[i][13:12] == 2'b11) begin//judge whether write back
                    if (TLB[i][14]) begin 
                        V_addr_PT_out = TLB[i][9:4];
                        P_addr_PT_out = TLB[i][1:0];
                        write_to_table = 1'b1;
                    end 
                    write_to_table = 1'b0;//again read from table
                    V_addr_PT_out = VPN;
                    
                    # 1
                    if (done) begin//after reading
                        TLB[i][1:0] = P_addr_PT_in;
                        TLB[i][9:4] = VPN; // Reset P_addr in TLB[i]
                    end
                    TLB[i][14] = 1'b0; // dirty
                    TLB[i][15] = 1'b1; // valid

                end
            end
        end
        
        else begin//after hit
            Physical_addr[7:0] = Virtual_addr[7:0];//offset
            if(Hit[0]==1'b1)begin
                            Physical_addr[9:8] = TLB[0][1:0];
                            k = 0; 
                            end
             if(Hit[1]==1'b1)begin
                             Physical_addr[9:8] = TLB[1][1:0];
                             k = 1; 
                             end
             if(Hit[2]==1'b1)begin
                             Physical_addr[9:8] = TLB[2][1:0];
                             k = 2; 
                             end
             if(Hit[3]==1'b1)begin
                             Physical_addr[9:8] = TLB[3][1:0];
                             k = 3; 
                             end                                                                                                                                 

            Addr_prepared = 1'b1;
            for (j = 0; j < 4; j = j + 1) begin
                if (TLB[j][13:12] < TLB[k][13:12]) begin
                    TLB[j][13:12] = TLB[j][13:12] + 2'b01;
                end
            end
            if (RW) begin
                TLB[k][14] = 1'b1;
            end
            TLB[k][13:12] = 2'b00;
        end
    end

endmodule



module Main_Memory(
    input RW, //1 for write, 0 for read
    input [9:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data,
    output reg done
);
    
    //Main memory has 256 words
    reg [31:0] regs[255:0];

    integer i;
    initial begin
        for(i=0;i<256;i=i+1) regs[i]=4*i+1;
        done=0;
    end
    
    always@(RW or addr) begin
        repeat(4) begin
        if(RW==1'b1) begin
            regs[addr>>2]=write_data;
        end
        if(RW==1'b0) begin
            read_data=regs[addr>>2];
        end
        #2 done=1;
        #2 done=0;
        end
    end
    
endmodule

module PageTable (
	input TLBRW,
	input [1:0]	PageInput_phy,
    input [5:0]	PageInput_vir,
    output reg done,
	output reg [1:0] PageOutput_phy,
    output reg PageFault
);
	reg [31:0] pagetable [31:0];
	integer i;
	initial begin
		for(i = 0; i < 31; i = i + 1) begin 
            pagetable[i][30] = 0;
            pagetable[i][31] = 0;  // valid
        end
        pagetable[0] = {1'b1, 29'b0, 2'd1};
        pagetable[1] = {1'b1, 29'b0, 2'd3};
        pagetable[2] = {1'b0, 29'b0, 2'd2};
        pagetable[3] = {1'b1, 29'b0, 2'd3};
        pagetable[4] = {1'b1, 29'b0, 2'd2};
        pagetable[5] = 32'b0;
        pagetable[6] = 32'b0;
        pagetable[7] = {1'b1, 29'b0, 2'd1}; 
        pagetable[8] = {1'b1, 29'b0, 2'd1};
        pagetable[9] = 32'b0;
        pagetable[10] = {1'b1, 29'b0, 2'd1};
		done = 0; 
		PageFault = 0;
	end
	
	always @(*) begin
	    #0.75
            if (TLBRW == 1) begin
                pagetable[PageInput_vir][1:0] = PageInput_phy;
                //pagetable[PageInput_vir][29] = 1;  // ref
                pagetable[PageInput_vir][30] = 1;  // dirty
            end
	
            if (TLBRW == 0) begin
                PageFault = 1 - pagetable[PageInput_vir][31];//
                if(PageFault==0) begin
                PageOutput_phy = pagetable[PageInput_vir][1:0];
                //pagetable[PageInput_vir][29] = 1;  // ref
                PageFault = 1 - pagetable[PageInput_vir][31];//
                pagetable[PageInput_vir][30] = pagetable[PageInput_vir][30]*1;
                end
            end
            
		    done = 1'b1;
		    #1 done = 1'b0;
	end

endmodule

