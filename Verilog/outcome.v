// this module determines the outcome of the game.
// hypothetically checked after every move.

module outcome(
	input [1:0]grid_A1,
	input [1:0]grid_A2,
	input [1:0]grid_A3,
	input [1:0]grid_B1,
	input [1:0]grid_B2,
	input [1:0]grid_B3,
	input [1:0]grid_C1,
	input [1:0]grid_C2,
	input [1:0]grid_C3,
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
		if (grid_A1 == grid_A2 && grid_A2 == grid_A3 && grid_A3 != 2'b00)
		begin
			if (grid_A1 == 2'b01)
				outcome = P1_WIN;
			else if (grid_A1 == 2'b10)
				outcome = P1_LOSE;
		end
		// Horizontal B row
		else if (grid_B1 == grid_B2 && grid_B2 == grid_B3 && grid_B3 != 2'b00)
		begin
			if (grid_B1 == 2'b01)
				outcome = P1_WIN;
			else if (grid_B1 == 2'b10)
				outcome = P1_LOSE;
		end
		// Horizontal C row
		else if (grid_C1 == grid_C2 && grid_C2 == grid_C3 && grid_C3 != 2'b00)
		begin
			if (grid_C1 == 2'b01)
				outcome = P1_WIN;
			else if (grid_C1 == 2'b10)
				outcome = P1_LOSE;
		end
		// Vertical 1 column
		else if (grid_A1 == grid_B1 && grid_B1 == grid_C1 && grid_C1 != 2'b00)
		begin
			if (grid_A1 == 2'b01)
				outcome = P1_WIN;
			else if (grid_A1 == 2'b10)
				outcome = P1_LOSE;
		end
		// Vertical 2 column
		else if (grid_A2 == grid_B2 && grid_B2 == grid_C2 && grid_C2 != 2'b00)
		begin
			if (grid_A2 == 2'b01)
				outcome = P1_WIN;
			else if (grid_A2 == 2'b10)
				outcome = P1_LOSE;
		end
		// Vertical 3 column
		else if (grid_A3 == grid_B3 && grid_B3 == grid_C3 && grid_C3 != 2'b00)
		begin
			if (grid_A3 == 2'b01)
				outcome = P1_WIN;
			else if (grid_A3 == 2'b10)
				outcome = P1_LOSE;
		end
		// Negative slope diagonal
		else if (grid_A1 == grid_B2 && grid_B2 == grid_C3 && grid_C3 != 2'b00)
		begin
			if (grid_A1 == 2'b01)
				outcome = P1_WIN;
			else if (grid_A1 == 2'b10)
				outcome = P1_LOSE;
		end
		// Positive slope diagonal
		else if (grid_A3 == grid_B2 && grid_B2 == grid_C1 && grid_C1 != 2'b00)
		begin
			if (grid_A3 == 2'b01)
				outcome = P1_WIN;
			else if (grid_A3 == 2'b10)
				outcome = P1_LOSE;
		end
		else if ((grid_A1[0]||grid_A1[1])&&(grid_A2[0]||grid_A2[1])&&(grid_A3[0]||grid_A3[1])&&(grid_B1[0]||grid_B1[1])&&(grid_B2[0]||grid_B2[1])&&(grid_B3[0]||grid_B3[1])&&(grid_C1[0]||grid_C1[1])&&(grid_C2[0]||grid_C2[1])&&(grid_C3[0]||grid_C3[1]))
			outcome = TIE;
		else
			outcome = IN_PROGRESS;
	end
	
	endmodule
	
