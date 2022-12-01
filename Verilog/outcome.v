// this module determines the outcome of the game.
// hypothetically checked after every move.

module outcome(
	input [1:0]A1_val,
	input [1:0]A2_val,
	input [1:0]A3_val,
	input [1:0]B1_val,
	input [1:0]B2_val,
	input [1:0]B3_val,
	input [1:0]C1_val,
	input [1:0]C2_val,
	input [1:0]C3_val,
	output reg [2:0]outcome
	);
	
	parameter IN_PROGRESS = 2'd0,
				 P1_WIN = 2'd1,
				 P1_LOSE = 2'd2,
				 TIE = 2'd3;
				 
	// checking for outcome
	always @(*)
	begin
		// Horizontal A row
		if (A1_val == A2_val && A2_val == A3_val && A3_val != 2'b00)
		begin
			if (A1_val == 2'01)
				outcome = P1_WIN;
			else if (A1_val == 2'10)
				outcome = P1_LOSE;
		end
		// Horizontal B row
		else if (B1_val == B2_val && B2_val == B3_val && B3_val != 2'b00)
		begin
			if (B1_val == 2'01)
				outcome = P1_WIN;
			else if (B1_val == 2'10)
				outcome = P1_LOSE;
		end
		// Horizontal C row
		else if (C1_val == C2_val && C2_val == C3_val && C3_val != 2'b00)
		begin
			if (C1_val == 2'01)
				outcome = P1_WIN;
			else if (C1_val == 2'10)
				outcome = P1_LOSE;
		end
		// Vertical 1 column
		else if (A1_val == B1_val && B1_val == C1_val && C1_val != 2'b00)
		begin
			if (A1_val == 2'01)
				outcome = P1_WIN;
			else if (A1_val == 2'10)
				outcome = P1_LOSE;
		end
		// Vertical 2 column
		else if (A2_val == B2_val && B2_val == C2_val && C2_val != 2'b00)
		begin
			if (A2_val == 2'01)
				outcome = P1_WIN;
			else if (A2_val == 2'10)
				outcome = P1_LOSE;
		end
		// Vertical 3 column
		else if (A3_val == B3_val && B3_val == C3_val && C3_val != 2'b00)
		begin
			if (A3_val == 2'01)
				outcome = P1_WIN;
			else if (A3_val == 2'10)
				outcome = P1_LOSE;
		end
		// Negative slope diagonal
		else if (A1_val == B2_val && B2_val == C3_val && C3_val != 2'b00)
		begin
			if (A1_val == 2'01)
				outcome = P1_WIN;
			else if (A1_val == 2'10)
				outcome = P1_LOSE;
		end
		// Positive slope diagonal
		else if (A3_val == B2_val && B2_val == C1_val && C1_val != 2'b00)
		begin
			if (A3_val == 2'01)
				outcome = P1_WIN;
			else if (A3_val == 2'10)
				outcome = P1_LOSE;
		end
		else if (((((((((A1_val == A2_val) == A3_val) == B1_val) == B2_val) == B3_val) == C1_val) == C2_val) == C3_val) != 2'b00)
			outcome = TIE;
		else
			outcome = IN_PROGRESS;
	end
	
	endmodule
	
