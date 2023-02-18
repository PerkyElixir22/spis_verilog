`timescale 1us/1ns

module testbench;

	reg clock;

	wire[7:0] dataBus;
	wire[11:0] addressBus;
	wire write;
	wire sync;

	cpu spisCPU(dataBus, addressBus, write, sync, clock);
	memory spisMemory(dataBus, addressBus, write, clock);

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars(0, testbench);

		clock = 0;

		for(integer i = 0; i < 1000; i = i + 1) begin
			#1 clock = ~clock;
		end
	end
endmodule
