// this module takes care of putting values in the grid squares
// might want to split this method up into two: determine validity and place values in grids

module grid(
	input clk, rst,
	input clear,
	input [1:0]user,
	input [3:0]move,
	output reg [1:0]grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3,
	output reg valid
	);
	
	// Grid:
	//       1    2    3
	//    |----|----|----|
	//    |    |    |    |
	//  A | A1 | A2 | A3 |
	//    |    |    |    |
	//    -----|----|-----
	//    |    |    |    |
	//  B | B1 | B2 | B3 |
	//    |    |    |    |
	//    -----|----|-----
	//    |    |    |    |
	//  C | C1 | C2 | C3 |
	//    |    |    |    |
	//    |----|----|----|

	parameter A1 = 4'd1,
				 A2 = 4'd2,
				 A3 = 4'd3,
				 B1 = 4'd4,
				 B2 = 4'd5,
				 B3 = 4'd6,
				 C1 = 4'd7,
				 C2 = 4'd8,
				 C3 = 4'd9;
	
	always @(posedge clk or negedge rst)
	begin
		
		// Clear board
		if (rst == 1'b0)
		begin
			grid_A1 <= 2'd0;
			grid_A2 <= 2'd0;
			grid_A3 <= 2'd0;
			grid_B1 <= 2'd0;
			grid_B2 <= 2'd0;
			grid_B3 <= 2'd0;
			grid_C1 <= 2'd0;
			grid_C2 <= 2'd0;
			grid_C3 <= 2'd0;
		end
		// put value in specific grid square
		else
		begin
		
			// A1
			if (move == A1 && grid_A1 == 2'd0)
			begin
				grid_A1 <= user;
				valid <= 1'b1;
			end
			else if (move == A1 && grid_A1 != 2'd0)
				valid <= 1'b0;
			
			// A2
			if (move == A2 && grid_A2 == 2'd0)
			begin
				grid_A2 <= user;
				valid <= 1'b1;
			end
			else if (move == A2 && grid_A2 != 2'd0)
				valid <= 1'b0;
				
			// A3
			if (move == A3 && grid_A3 == 2'd0)
			begin
				grid_A3 <= user;
				valid <= 1'b1;
			end
			else if (move == A3 && grid_A3 != 2'd0)
				valid <= 1'b0;
				
			// B1
			if (move == B1 && grid_B1 == 2'd0)
			begin
				grid_B1 <= user;
				valid <= 1'b1;
			end
			else if (move == B1 && grid_B2 != 2'd0)
				valid <= 1'b0;
				
			// B2
			if (move == B2 && grid_B2 == 2'd0)
			begin
				grid_B2 <= user;
				valid <= 1'b1;
			end
			else if (move == B2 && grid_B2 != 2'd0)
				valid <= 1'b0;
				
			// B3
			if (move == B3 && grid_B3 == 2'd0)
			begin
				grid_B3 <= user;
				valid <= 1'b1;
			end
			else if (move == B3 && grid_B1 != 2'd0)
				valid <= 1'b0;
				
			// C1
			if (move == C1 && grid_C1 == 2'd0)
			begin
				grid_C1 <= user;
				valid <= 1'b1;
			end
			else if (move == C1 && grid_C1 != 2'd0)
				valid <= 1'b0;
				
			// C2
			if (move == C2 && grid_C2 == 2'd0)
			begin
				grid_C2 <= user;
				valid <= 1'b1;
			end
			else if (move == C2 && grid_C2 != 2'd0)
				valid <= 1'b0;
				
			// C3
			if (move == C3 && grid_C3 == 2'd0)
			begin
				grid_C3 <= user;
				valid <= 1'b1;
			end
			else if (move == C3 && grid_C3 != 2'd0)
				valid <= 1'b0;
		end
	end

endmodule
