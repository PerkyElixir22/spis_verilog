module memory (
	inout[7:0] dataBus,

	input[11:0] addressBus,
	input write,

	input clock
);
	reg[7:0] mem[4096];

	reg[7:0] tmp;

	initial begin
		for (integer i = 0; i < 4096; i = i + 1)
			mem[i] = 0;
	end

	always @ (posedge clock) begin
		if (write)
			mem[addressBus] <= dataBus;
		else
			tmp <= mem[addressBus];
	end

	assign dataBus = write ? 8'hZZ : tmp;
endmodule
