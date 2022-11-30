// i think each grid square should have a register
// (so we'll need a register module - created) and it'll hold
// who made a move in that square then we'll make if
// statements to test the different directions someone
// can win in (8 total directions - 3 horizontal,
// 3 vertical, and 2 diagonal)
// idk where to instatiate the registers tho.
// - claire

module move_logic(
	input clk, rst,
	input [3:0] move, //1 of the 9 different gridsd
	input [1:0] user, //who chose the move
	output reg valid,
	output reg [1:0] outcome //in progress, player 1 win, player 1 lose, tie - undecided if game is still going
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
				 
	reg en_A1, en_A2, en_A3,
		 en_B1, en_B2, en_B3,
		 en_C1, en_C2, en_C3;
		 
	reg [1:0] in_A1, in_A2, in_A3,
		 in_B1, in_B2, in_B3,
		 in_C1, in_C2, in_C3;
		 
	wire [1:0] out_A1, out_A2, out_A3,
		  out_B1, out_B2, out_B3,
		  out_C1, out_C2, out_C3;
	
	// grid block registers
	// may not need the ton of different enable and out variables.
	// also need to figure out wires and regs going from in to out etc.
	register reg_A1(clk, rst, in_A1, en_A1, out_A1);
	register reg_A2(clk, rst, in_A2, en_A2, out_A2);
	register reg_A3(clk, rst, in_A3, en_A3, out_A3);
	register reg_B1(clk, rst, in_B1, en_B1, out_B1);
	register reg_B2(clk, rst, in_B2, en_B2, out_B2);
	register reg_B3(clk, rst, in_B3, en_B3, out_B3);
	register reg_C1(clk, rst, in_C1, en_C1, out_C1);
	register reg_C2(clk, rst, in_C2, en_C2, out_C2);
	register reg_C3(clk, rst, in_C3, en_C3, out_C3);
	
	// Putting values in registers
	always @(*)
	begin
	
		// A1
		if (move == A1 && en_A1)
		begin
			in_A1 = user;
			valid = 1'b1;
		end
		else if (move == A1 && ~en_A1)
			valid = 1'b0;
		
		// A2
		if (move == A2 && en_A2)
		begin
			in_A2 = user;
			valid = 1'b1;
		end
		else if (move == A2 && ~en_A2)
			valid = 1'b0;
			
		// A3
		if (move == A3 && en_A3)
		begin
			in_A3 = user;
			valid = 1'b1;
		end
		else if (move == A3 && ~en_A3)
			valid = 1'b0;
			
		// B1
		if (move == B1 && en_B1)
		begin
			in_B1 = user;
			valid = 1'b1;
		end
		else if (move == B1 && ~en_B1)
			valid = 1'b0;
			
		// B2
		if (move == B2 && en_B2)
		begin
			in_B2 = user;
			valid = 1'b1;
		end
		else if (move == B2 && ~en_B2)
			valid = 1'b0;
			
		// B3
		if (move == B3 && en_B3)
		begin
			in_B3 = user;
			valid = 1'b1;
		end
		else if (move == B3 && ~en_B3)
			valid = 1'b0;
			
		// C1
		if (move == C1 && en_C1)
		begin
			in_C1 = user;
			valid = 1'b1;
		end
		else if (move == C1 && ~en_C1)
			valid = 1'b0;
			
		// C2
		if (move == C2 && en_C2)
		begin
			in_C2 = user;
			valid = 1'b1;
		end
		else if (move == C2 && ~en_C2)
			valid = 1'b0;
			
		// C3
		if (move == C3 && en_C3)
		begin
			in_C3 = user;
			valid = 1'b1;
		end
		else if (move == C3 && ~en_C3)
			valid = 1'b0;
		
	end
	
	parameter IN_PROGRESS = 2'd0,
				 P1_WIN = 2'd1,
				 P1_LOSE = 2'd2,
				 TIE = 2'd3;
	
	// checking for outcome
	always @(*)
	begin
		// Horizontal A row
		if (out_A1 == out_A2 && out_A2 == out_A3 && out_A3 ~= 2'b00)
		begin
			if (out_A1 == 2'01)
				outcome = P1_WIN;
			else if (out_A1 == 2'10)
				outcome = P1_LOSE;
		end
		// Horizontal B row
		else if (out_B1 == out_B2 && out_B2 == out_B3 && out_B3 ~= 2'b00)
		begin
			if (out_B1 == 2'01)
				outcome = P1_WIN;
			else if (out_B1 == 2'10)
				outcome = P1_LOSE;
		end
		// Horizontal C row
		else if (out_C1 == out_C2 && out_C2 == out_C3 && out_C3 ~= 2'b00)
		begin
			if (out_C1 == 2'01)
				outcome = P1_WIN;
			else if (out_C1 == 2'10)
				outcome = P1_LOSE;
		end
		// Vertical 1 column
		else if (out_A1 == out_B1 && out_B1 == out_C1 && out_C1 ~= 2'b00)
		begin
			if (out_A1 == 2'01)
				outcome = P1_WIN;
			else if (out_A1 == 2'10)
				outcome = P1_LOSE;
		end
		// Vertical 2 column
		else if (out_A2 == out_B2 && out_B2 == out_C2 && out_C2 ~= 2'b00)
		begin
			if (out_A2 == 2'01)
				outcome = P1_WIN;
			else if (out_A2 == 2'10)
				outcome = P1_LOSE;
		end
		// Vertical 3 column
		else if (out_A3 == out_B3 && out_B3 == out_C3 && out_C3 ~= 2'b00)
		begin
			if (out_A3 == 2'01)
				outcome = P1_WIN;
			else if (out_A3 == 2'10)
				outcome = P1_LOSE;
		end
		// Negative slope diagonal
		else if (out_A1 == out_B2 && out_B2 == out_C3 && out_C3 ~= 2'b00)
		begin
			if (out_A1 == 2'01)
				outcome = P1_WIN;
			else if (out_A1 == 2'10)
				outcome = P1_LOSE;
		end
		// Positive slope diagonal
		else if (out_A3 == out_B2 && out_B2 == out_C1 && out_C1 ~= 2'b00)
		begin
			if (out_A3 == 2'01)
				outcome = P1_WIN;
			else if (out_A3 == 2'10)
				outcome = P1_LOSE;
		end
		else if (out_A1 == 2'b00 || out_A2 == 2'b00 || out_A3 == 2'b00 || out_B1 == 2'b00 || out_B2 == 2'b00 || out_B3 == 2'b00 || out_C1 == 2'b00 || out_C2 == 2'b00 || out_C3 == 2'b00)
			outcome = IN_PROGRESS;
		else
			outcome = TIE;
	end
	
endmodule
