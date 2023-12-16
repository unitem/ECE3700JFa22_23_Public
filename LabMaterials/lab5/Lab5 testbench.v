module singleCycleTest;
    reg clk;
    wire [31:0] data_out;
    reg [4:0] reg_address;
    reg pc;
	top test (
		clk,
		reg_address,
		pc,
		data_out
	);

    initial begin
        while ($time < 60) @(posedge clk)begin
            $display("===============================================");
            $display("Clock cycle %d, PC = %H", $time/2, test.instruction_address);
            $display("ra = %H, t0 = %H, t1 = %H", test.registerfile.registers[1], test.registerfile.registers[5], test.registerfile.registers[6]);
            $display("t2 = %H, t3 = %H, t4 = %H", test.registerfile.registers[7], test.registerfile.registers[28], test.registerfile.registers[29]);
            $display("===============================================");
        end
        $finish();
    end
    always #1 clk = ~clk;
endmodule