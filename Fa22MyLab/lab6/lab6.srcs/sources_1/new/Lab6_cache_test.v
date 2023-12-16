`timescale 1ns / 1ps

module top( input clk);
    wire read_write_cache; /* 1 if write, 0 if read */
    wire hit_miss; /* 1 if hit, 0 if miss */
    wire [9:0]   address_cache;
    wire [31:0]  read_data_cache, write_data_cache;
    // interface between cache and main memory
    wire [31:0]  write_data_mem,read_data_mem;
    wire [9:0]   address_mem;
    wire read_write_mem, Done;
    // You may add the signal you need. However, you cannot change the signals above.

    cache   cache(read_write_cache, address_cache, write_data_cache, read_data_mem, Done, read_write_mem, address_mem, write_data_mem, read_data_cache, hit_miss);
    main_memory            mem_db(read_write_mem, address_mem, write_data_mem, read_data_mem, Done);
    CPU                 CPU_db(hit_miss, clk,read_data_cache,read_write_cache, address_cache, write_data_cache);
endmodule

module CacheTest;
    reg clock;

    parameter half_period = 5;
    integer t = 0;
    
    top test(clock);
    
    integer f;
    initial begin
        #0 clock = 0;
    end
 
    always #half_period begin
        clock = ~clock;
        t=t+1;
    end
    
    always @(posedge clock) begin
            $display("===============================================");
            $display("Clock cycle %d", t/2);
            $display("Read data = %H", test.read_data_cache);
            $display("hit_miss = %d", test.hit_miss);
            $display("request num = %d", test.CPU_db.request_num);
            $display("address in = %x", test.cache.addr_in);
            $display("type in = %d", test.cache.type_in);
            $display("valid[0] = %d", test.cache.valid[0]);
            $display("valid[2] = %d", test.cache.valid[2]);
            $display("dirty[0] = %d", test.cache.dirty[0]);
            $display("dirty[2] = %d", test.cache.dirty[2]);
            $display("tag[0] = %x", test.cache.tag[0]);
            $display("tag[2] = %x", test.cache.tag[2]);
            $display("data[2] = %x", test.cache.data[2]);
            $display("data[10] = %x", test.cache.data[10]);
            $display("Mem[01101010] = %x", test.mem_db.regs[106]);
            $display("Mem[01000010] = %x", test.mem_db.regs[66]);
            $display("Mem[01001010] = %x", test.mem_db.regs[74]);
            $display("Mem[01011010] = %x", test.mem_db.regs[90]);
            $display("===============================================");
            
    end
    initial
        #280 $stop;

endmodule