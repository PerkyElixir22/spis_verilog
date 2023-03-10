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
	reg carry;

	reg[7:0] instructionData[2];
	reg[1:0] instructionCounter; // Keeps track of where we are in the current instruction

	reg[7:0] out;

	initial begin
		A <= 0;
		B <= 0;
		C <= 0;
		IP <= 0;
		carry <= 0;

		addressBus <= 0;
		write <= 0;
		sync <= 0;

		instructionCounter <= 0;
	end

	always @ (clock) begin
		if (instructionCounter == 0) begin
			// Time to start a new instruction
			sync <= 1;
			addressBus <= IP;
			write <= 0;
		end else if(instructionCounter == 1) begin
			case (instructionData[0][7:4])
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
			4'b1011: begin
				addressBus <= IP;
				write <= 0;
			end
			4'b1100: begin
				addressBus <= IP;
				write <= 0;
			end
			endcase
		end else if(instructionCounter == 2) begin
			case (instructionData[0][7:4])
			4'b0110: begin
				addressBus <= {instructionData[0][3:0], instructionData[1]};
				write <= 0;
			end
			4'b0111: begin
				addressBus <= {instructionData[0][3:0], instructionData[1]} + C;
				write <= 0;
			end
			4'b1000: begin
				addressBus <= {instructionData[0][3:0], instructionData[1]};
				write <= 1;
				out <= A;
			end
			4'b1001: begin
				addressBus <= {instructionData[0][3:0], instructionData[1]} + C;
				write <= 1;
				out <= A;
			end

			default: instructionCounter <= 3;
			endcase
		end

		#0.5;

		if (instructionCounter == 0) begin
			sync <= 0;
			instructionData[0] <= dataBus;
			case(dataBus[7:4])
			4'b0000: {carry, A} <= A + B;
			4'b0001: {carry, A} <= A - B;
			4'b0010: {carry, A} <= A + B + carry;
			4'b0011: {carry, A} <= A - B - carry;
			4'b0100: begin
				A <= B;
				B <= A;
			end
			4'b1010: begin
				A <= C;
				C <= A;
			end
			4'b1101: A <= ~A;
			4'b1110: A <= A & B;
			4'b1111: A <= A | B;
			default: instructionCounter <= 1;
			endcase
			IP <= IP + 1;
		end else if(instructionCounter == 1) begin
			case (instructionData[0][7:4])
			4'b0101: begin
				A <= dataBus;
				instructionCounter <= 0;
				IP <= IP + 1;
			end
			4'b0110: begin
				instructionData[1] <= dataBus;
				instructionCounter <= 2;
				IP <= IP + 1;
			end
			4'b0111: begin
				instructionData[1] <= dataBus;
				instructionCounter <= 2;
				IP <= IP + 1;
			end
			4'b1000: begin
				instructionData[1] <= dataBus;
				instructionCounter <= 2;
				IP <= IP + 1;
			end
			4'b1001: begin
				instructionData[1] <= dataBus;
				instructionCounter <= 2;
				IP <= IP + 1;
			end
			4'b1011: begin
				instructionData[1] <= dataBus;
				if (A == B)
					IP <= {instructionData[0][3:0], dataBus};
				else
					IP <= IP + 1;
				instructionCounter <= 0;
			end
			4'b1100: begin
				instructionData[1] <= dataBus;
				IP <= {instructionData[0][3:0], dataBus};
				instructionCounter <= 0;
			end
			endcase
		end else if(instructionCounter == 2) begin
			case (instructionData[0][7:4])
			4'b0110: A <= dataBus;
			4'b0111: A <= dataBus;
			4'b1000: write <= 0;
			4'b1001: write <= 0;
			endcase
			instructionCounter <= 0;
		end else
			instructionCounter <= 0;

	end

	assign dataBus = write ? out : 8'hZZ;
endmodule
