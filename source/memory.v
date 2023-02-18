module memory (
	inout[7:0] dataBus,

	input[11:0] addressBus,
	input write,

	input clock
);
	reg[7:0] mem[4096];

	reg[7:0] tmp;

	integer fileD;

	initial begin
		
		for(integer i = 0; i < 4096; i = i + 1)
			mem[i] = 0;

		fileD = $fopen("prog.bin", "rb");
		$fread(mem, fileD);
		$fclose(fileD);
	end

	always @ (clock) begin
		#0.05; // Have to have a delay here because otherwise it wouldn't "register" the other parameters changing

		if (write)
			mem[addressBus] <= dataBus;
		else
			tmp <= mem[addressBus];
	end

	assign dataBus = write ? 8'hZZ : tmp;
endmodule
