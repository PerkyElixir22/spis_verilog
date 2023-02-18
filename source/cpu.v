`timescale 1us/1ns

module cpu (
	inout[7:0] dataBus,
	
	output reg[11:0] addressBus,
	output reg write,
	output reg sync,

	input clock
);

	reg[7:0] A;
	reg[7:0] B;
	reg[7:0] C;
	reg[11:0] IP;
	reg[1:0] PF; // 0: Carry 1: Zero

	reg[7:0] instructionData[2];
	reg[1:0] instructionCounter; // Keeps track of where we are in the current instruction

	reg[7:0] out;

	initial begin
		A <= 0;
		B <= 0;
		C <= 0;
		IP <= 0;
		PF <= 0;

		addressBus <= 0;
		write <= 0;
		sync <= 0;

		instructionCounter <= 0;
	end

	always @ (posedge clock) begin
		if (instructionCounter == 0) begin
			// Time to start a new instruction
			sync <= 1;
			addressBus <= IP;
			write <= 0;
		end else if(instructionCounter == 1) begin
			case (instructionData[0][7:4])
			4'b0000: {PF[0], A} <= A + B;
			4'b0001: {PF[0], A} <= A - B;
			4'b0010: {PF[0], A} <= A + B + PF[0];
			4'b0011: {PF[0], A} <= A - B + PF[1];
			4'b0100: begin
				A <= B;
				B <= A;
			end
			4'b0101: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b0110: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b0111: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b1000: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b1001: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b1010: begin
				A <= C;
				C <= A;
			end
			4'b1011: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b1100: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b1101: A <= ~A;
			4'b1110: A <= A & B;
			4'b1111: A <= A | B;
			endcase
		end else if(instructionCounter == 2) begin
			
		end else if(instructionCounter == 3) begin
			
		end

		#1; // Would have put the following in an always@(negedge clock) but if i did that then it would execute right at the beginning of the simulation.

		if (instructionCounter == 0) begin
			sync <= 0;
			instructionData[0] <= dataBus;
			IP <= IP + 1;
			instructionCounter <= instructionCounter + 1;
		end else if(instructionCounter == 1) begin
			case (instructionData[0][7:4])
			4'b0000: instructionCounter <= 0;
			4'b0001: instructionCounter <= 0;
			4'b0010: instructionCounter <= 0;
			4'b0011: instructionCounter <= 0;
			4'b0100: instructionCounter <= 0;
			4'b0101: instructionData[1] <= dataBus;
			4'b0110: instructionData[1] <= dataBus;
			4'b0111: instructionData[1] <= dataBus;
			4'b1000: instructionData[1] <= dataBus;
			4'b1001: instructionData[1] <= dataBus;
			4'b1010: instructionCounter <= 0;
			4'b1011: instructionData[1] <= dataBus;
			4'b1100: instructionData[1] <= dataBus;
			4'b1101: instructionCounter <= 0;
			4'b1110: instructionCounter <= 0;
			4'b1111: instructionCounter <= 0;
			endcase
		end else if(instructionCounter == 2) begin
			
		end else if(instructionCounter == 3) begin
			
		end
	end

	assign out = write ? out : 8'hZZ;
endmodule
