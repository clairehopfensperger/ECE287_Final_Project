module AI_decide(
	//input clk, rst,
	input [1:0]grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3,
	input AI_en,
	input mode,
	output reg [8:0]AI_move
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
	
	// grid sqaures
	parameter A1 = 9'b100000000,
				 A2 = 9'b010000000,
				 A3 = 9'b001000000,
				 B1 = 9'b000100000,
				 B2 = 9'b000010000,
				 B3 = 9'b000001000,
				 C1 = 9'b000000100,
				 C2 = 9'b000000010,
				 C3 = 9'b000000001;
				 
	/*
	MOVE PRIORITY:
	1. next win
	2. block opponent win
	3. fork (has 2 corners, opposite two corners are empty, place in center)
	4. block opponent fork (opponent has 2 corners, opposite two corners are empty, place in center)
	5. play center
	6. play opposite corner (opponent has corner, place opposite)
	7. empty corner
	8. empty side
	*/
				 
	always @(*)
	begin
		
		// hard mode - good AI
		if (mode == 1'b1)
		begin
		
			// 1. next win - DONE
				
				// win cases in A row
				if ((grid_A1 == 2'b10) && (grid_A2 == 2'b10) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_A1 == 2'b10) && (grid_A3 == 2'b10) && (grid_A2 == 2'd0))
					AI_move = A2;
				else if ((grid_A2 == 2'b10) && (grid_A3 == 2'b10) && (grid_A1 == 2'd0))
					AI_move = A1;
					
				// win cases in B row
				else if ((grid_B1 == 2'b10) && (grid_B2 == 2'b10) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_B1 == 2'b10) && (grid_B3 == 2'b10) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b10) && (grid_B3 == 2'b10) && (grid_B1 == 2'd0))
					AI_move = B1;
					
				// win cases in C row
				else if ((grid_C1 == 2'b10) && (grid_C2 == 2'b10) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_C1 == 2'b10) && (grid_C3 == 2'b10) && (grid_C2 == 2'd0))
					AI_move = C2;
				else if ((grid_C2 == 2'b10) && (grid_C3 == 2'b10) && (grid_C1 == 2'd0))
					AI_move = C1;
					
				// win cases in 1 column
				else if ((grid_A1 == 2'b10) && (grid_B1 == 2'b10) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A1 == 2'b10) && (grid_C1 == 2'b10) && (grid_B1 == 2'd0))
					AI_move = B1;
				else if ((grid_B1 == 2'b10) && (grid_C1 == 2'b10) && (grid_A1 == 2'd0))
					AI_move = A1;
					
				// win cases in 2 column
				else if ((grid_A2 == 2'b10) && (grid_B2 == 2'b10) && (grid_C2 == 2'd0))
					AI_move = C2;
				else if ((grid_A2 == 2'b10) && (grid_C2 == 2'b10) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b10) && (grid_C2 == 2'b10) && (grid_A2 == 2'd0))
					AI_move = A2;
					
				// win cases in 3 column
				else if ((grid_A3 == 2'b10) && (grid_B3 == 2'b10) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A3 == 2'b10) && (grid_C3 == 2'b10) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_B3 == 2'b10) && (grid_C3 == 2'b10) && (grid_A3 == 2'd0))
					AI_move = A3;
					
				// win cases in positive slope
				else if ((grid_C1 == 2'b10) && (grid_B2 == 2'b10) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_C1 == 2'b10) && (grid_A3 == 2'b10) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b10) && (grid_A3 == 2'b10) && (grid_C1 == 2'd0))
					AI_move = C1;
					
				// win cases in negative slope
				else if ((grid_A1 == 2'b10) && (grid_B2 == 2'b10) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A1 == 2'b10) && (grid_C3 == 2'b10) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b10) && (grid_C3 == 2'b10) && (grid_A1 == 2'd0))
					AI_move = A1;
			
			
			// 2. block opponent win - DONE
			
				// lose cases in A row
				else if ((grid_A1 == 2'b01) && (grid_A2 == 2'b01) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_A1 == 2'b01) && (grid_A3 == 2'b01) && (grid_A2 == 2'd0))
					AI_move = A2;
				else if ((grid_A2 == 2'b01) && (grid_A3 == 2'b01) && (grid_A1 == 2'd0))
					AI_move = A1;
					
				// lose cases in B row
				else if ((grid_B1 == 2'b01) && (grid_B2 == 2'b01) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_B1 == 2'b01) && (grid_B3 == 2'b01) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b01) && (grid_B3 == 2'b01) && (grid_B1 == 2'd0))
					AI_move = B1;
					
				// lose cases in C row
				else if ((grid_C1 == 2'b01) && (grid_C2 == 2'b01) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_C1 == 2'b01) && (grid_C3 == 2'b01) && (grid_C2 == 2'd0))
					AI_move = C2;
				else if ((grid_C2 == 2'b01) && (grid_C3 == 2'b01) && (grid_C1 == 2'd0))
					AI_move = C1;
					
				// lose cases in 1 column
				else if ((grid_A1 == 2'b01) && (grid_B1 == 2'b01) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A1 == 2'b01) && (grid_C1 == 2'b01) && (grid_B1 == 2'd0))
					AI_move = B1;
				else if ((grid_B1 == 2'b01) && (grid_C1 == 2'b01) && (grid_A1 == 2'd0))
					AI_move = A1;
					
				// lose cases in 2 column
				else if ((grid_A2 == 2'b01) && (grid_B2 == 2'b01) && (grid_C2 == 2'd0))
					AI_move = C2;
				else if ((grid_A2 == 2'b01) && (grid_C2 == 2'b01) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b01) && (grid_C2 == 2'b01) && (grid_A2 == 2'd0))
					AI_move = A2;
					
				// lose cases in 3 column
				else if ((grid_A3 == 2'b01) && (grid_B3 == 2'b01) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A3 == 2'b01) && (grid_C3 == 2'b01) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_B3 == 2'b01) && (grid_C3 == 2'b01) && (grid_A3 == 2'd0))
					AI_move = A3;
					
				// lose cases in positive slope
				else if ((grid_C1 == 2'b01) && (grid_B2 == 2'b01) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_C1 == 2'b01) && (grid_A3 == 2'b01) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b01) && (grid_A3 == 2'b01) && (grid_C1 == 2'd0))
					AI_move = C1;
					
				// lose cases in negative slope
				else if ((grid_A1 == 2'b01) && (grid_B2 == 2'b01) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A1 == 2'b01) && (grid_C3 == 2'b01) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B2 == 2'b01) && (grid_C3 == 2'b01) && (grid_A1 == 2'd0))
					AI_move = A1;
			
			
			// 3. fork - DONE
			
				// fork 1 - 8 variations
				else if ((grid_B2 == 2'b10) && (grid_C3 == 2'b10) && (grid_B3 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B2 == 2'b10) && (grid_C1 == 2'b10) && (grid_A1 == 2'd0) && (grid_C2 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A1 == 2'b10) && (grid_B2 == 2'b10) && (grid_A3 == 2'd0) && (grid_B1 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A3 == 2'b10) && (grid_B2 == 2'b10) && (grid_A2 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B2 == 2'b10) && (grid_C1 == 2'b10) && (grid_B1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_A1 == 2'b10) && (grid_B2 == 2'b10) && (grid_A2 == 2'd0) && (grid_C3 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_A3 == 2'b10) && (grid_B2 == 2'b10) && (grid_A1 == 2'd0) && (grid_B3 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B2 == 2'b10) && (grid_C3 == 2'b10) && (grid_A3 == 2'd0) && (grid_C2 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
					
				// fork 2 - 4 variations, 8 plays
				else if ((grid_B2 == 2'b10) && (grid_C3 == 2'b10) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_A2 == 2'd0))
					AI_move = A2;
				else if ((grid_B2 == 2'b10) && (grid_C3 == 2'b10) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_B1 == 2'd0))
					AI_move = B1;
				else if ((grid_B2 == 2'b10) && (grid_C1 == 2'b10) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_B2 == 2'b10) && (grid_C1 == 2'b10) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A2 == 2'd0))
					AI_move = A2;
				else if ((grid_A1 == 2'b10) && (grid_B2 == 2'b10) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_C2 == 2'd0))
					AI_move = C2;
				else if ((grid_A1 == 2'b10) && (grid_B2 == 2'b10) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_A3 == 2'b10) && (grid_B2 == 2'b10) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_B1 == 2'd0))
					AI_move = B1;
				else if ((grid_A3 == 2'b10) && (grid_B2 == 2'b10) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_C2 == 2'd0))
					AI_move = C2;
					
				// fork 3 - 8 variations
				else if ((grid_A2 == 2'b10) && (grid_B2 == 2'b10) && (grid_A3 == 2'd0) && (grid_C2 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_B2 == 2'b10) && (grid_B3 == 2'b10) && (grid_B1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B2 == 2'b10) && (grid_C2 == 2'b10) && (grid_A2 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B1 == 2'b10) && (grid_B2 == 2'b10) && (grid_A1 == 2'd0) && (grid_B3 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A2 == 2'b10) && (grid_B2 == 2'b10) && (grid_A1 == 2'd0) && (grid_C2 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B2 == 2'b10) && (grid_B3 == 2'b10) && (grid_A3 == 2'd0) && (grid_B1 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_B2 == 2'b10) && (grid_C2 == 2'b10) && (grid_A2 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B1 == 2'b10) && (grid_B2 == 2'b10) && (grid_B3 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
					
				// fork 4 - 8 variations
				else if ((grid_A2 == 2'b10) && (grid_B2 == 2'b10) && (grid_A3 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B2 == 2'b10) && (grid_B3 == 2'b10) && (grid_C1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B2 == 2'b10) && (grid_C2 == 2'b10) && (grid_A1 == 2'd0) && (grid_C1 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B1 == 2'b10) && (grid_B2 == 2'b10) && (grid_A1 == 2'd0) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A2 == 2'b10) && (grid_B2 == 2'b10) && (grid_A1 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B2 == 2'b10) && (grid_B3 == 2'b10) && (grid_A1 == 2'd0) && (grid_A3 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B2 == 2'b10) && (grid_C2 == 2'b10) && (grid_A3 == 2'd0) && (grid_C3 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_B1 == 2'b10) && (grid_B2 == 2'b10) && (grid_C1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				
				// fork 5 - 4 variations
				else if ((grid_B3 == 2'b10) && (grid_C2 == 2'b10) && (grid_A2 == 2'd0) && (grid_B1 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B1 == 2'b10) && (grid_C2 == 2'b10) && (grid_A2 == 2'd0) && (grid_B3 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_A2 == 2'b10) && (grid_B1 == 2'b10) && (grid_B3 == 2'd0) && (grid_C2 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_A2 == 2'b10) && (grid_B3 == 2'b10) && (grid_B1 == 2'd0) && (grid_C2 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				
				
				// fork 6 - 4 variations
				else if ((grid_A1 == 2'b10) && (grid_C3 == 2'b10) && (grid_A2 == 2'd0) && (grid_B3 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_A3 == 2'b10) && (grid_C1 == 2'b10) && (grid_B3 == 2'd0) && (grid_C2 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A1 == 2'b10) && (grid_C3 == 2'b10) && (grid_B1 == 2'd0) && (grid_C2 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A3 == 2'b10) && (grid_C1 == 2'b10) && (grid_A2 == 2'd0) && (grid_B1 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
					
			
			// 4. block opponent fork - DONE
			
				// fork 1 - 8 variations
				else if ((grid_B2 == 2'b01) && (grid_C3 == 2'b01) && (grid_B3 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B2 == 2'b01) && (grid_C1 == 2'b01) && (grid_A1 == 2'd0) && (grid_C2 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A1 == 2'b01) && (grid_B2 == 2'b01) && (grid_A3 == 2'd0) && (grid_B1 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A3 == 2'b01) && (grid_B2 == 2'b01) && (grid_A2 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B2 == 2'b01) && (grid_C1 == 2'b01) && (grid_B1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_A1 == 2'b01) && (grid_B2 == 2'b01) && (grid_A2 == 2'd0) && (grid_C3 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_A3 == 2'b01) && (grid_B2 == 2'b01) && (grid_A1 == 2'd0) && (grid_B3 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B2 == 2'b01) && (grid_C3 == 2'b01) && (grid_A3 == 2'd0) && (grid_C2 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
					
				// fork 2 - 4 variations, 8 plays
				else if ((grid_B2 == 2'b01) && (grid_C3 == 2'b01) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_A2 == 2'd0))
					AI_move = A2;
				else if ((grid_B2 == 2'b01) && (grid_C3 == 2'b01) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_B1 == 2'd0))
					AI_move = B1;
				else if ((grid_B2 == 2'b01) && (grid_C1 == 2'b01) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_B2 == 2'b01) && (grid_C1 == 2'b01) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A2 == 2'd0))
					AI_move = A2;
				else if ((grid_A1 == 2'b01) && (grid_B2 == 2'b01) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_C2 == 2'd0))
					AI_move = C2;
				else if ((grid_A1 == 2'b01) && (grid_B2 == 2'b01) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0) && (grid_B3 == 2'd0))
					AI_move = B3;
				else if ((grid_A3 == 2'b01) && (grid_B2 == 2'b01) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_B1 == 2'd0))
					AI_move = B1;
				else if ((grid_A3 == 2'b01) && (grid_B2 == 2'b01) && (grid_A1 == 2'd0) && (grid_C3 == 2'd0) && (grid_C2 == 2'd0))
					AI_move = C2;
					
				// fork 3 - 8 variations
				else if ((grid_A2 == 2'b01) && (grid_B2 == 2'b01) && (grid_A3 == 2'd0) && (grid_C2 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_B2 == 2'b01) && (grid_B3 == 2'b01) && (grid_B1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B2 == 2'b01) && (grid_C2 == 2'b01) && (grid_A2 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B1 == 2'b01) && (grid_B2 == 2'b01) && (grid_A1 == 2'd0) && (grid_B3 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A2 == 2'b01) && (grid_B2 == 2'b01) && (grid_A1 == 2'd0) && (grid_C2 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B2 == 2'b01) && (grid_B3 == 2'b01) && (grid_A3 == 2'd0) && (grid_B1 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_B2 == 2'b01) && (grid_C2 == 2'b01) && (grid_A2 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B1 == 2'b01) && (grid_B2 == 2'b01) && (grid_B3 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
					
				// fork 4 - 8 variations
				else if ((grid_A2 == 2'b01) && (grid_B2 == 2'b01) && (grid_A3 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				else if ((grid_B2 == 2'b01) && (grid_B3 == 2'b01) && (grid_C1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B2 == 2'b01) && (grid_C2 == 2'b01) && (grid_A1 == 2'd0) && (grid_C1 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B1 == 2'b01) && (grid_B2 == 2'b01) && (grid_A1 == 2'd0) && (grid_A3 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A2 == 2'b01) && (grid_B2 == 2'b01) && (grid_A1 == 2'd0) && (grid_C1 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_B2 == 2'b01) && (grid_B3 == 2'b01) && (grid_A1 == 2'd0) && (grid_A3 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_B2 == 2'b01) && (grid_C2 == 2'b01) && (grid_A3 == 2'd0) && (grid_C3 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_B1 == 2'b01) && (grid_B2 == 2'b01) && (grid_C1 == 2'd0) && (grid_C3 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
				
				// fork 5 - 4 variations
				else if ((grid_B3 == 2'b01) && (grid_C2 == 2'b01) && (grid_A2 == 2'd0) && (grid_B1 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_B1 == 2'b01) && (grid_C2 == 2'b01) && (grid_A2 == 2'd0) && (grid_B3 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_A2 == 2'b01) && (grid_B1 == 2'b01) && (grid_B3 == 2'd0) && (grid_C2 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				else if ((grid_A2 == 2'b01) && (grid_B3 == 2'b01) && (grid_B1 == 2'd0) && (grid_C2 == 2'd0) && (grid_B2 == 2'd0))
					AI_move = B2;
				
				
				// fork 6 - 4 variations
				else if ((grid_A1 == 2'b01) && (grid_C3 == 2'b01) && (grid_A2 == 2'd0) && (grid_B3 == 2'd0) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_A3 == 2'b01) && (grid_C1 == 2'b01) && (grid_B3 == 2'd0) && (grid_C2 == 2'd0) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A1 == 2'b01) && (grid_C3 == 2'b01) && (grid_B1 == 2'd0) && (grid_C2 == 2'd0) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_A3 == 2'b01) && (grid_C1 == 2'b01) && (grid_A2 == 2'd0) && (grid_B1 == 2'd0) && (grid_A1 == 2'd0))
					AI_move = A1;
					
			
			// 5. play center - DONE
				else if (grid_B2 == 2'd0)
					AI_move = B2;
			
			
			// 6. play opposite corner - DONE

				else if ((grid_A1 == 2'b01) && (grid_C3 == 2'd0))
					AI_move = C3;
				else if ((grid_A3 == 2'b01) && (grid_C1 == 2'd0))
					AI_move = C1;
				else if ((grid_C1 == 2'b01) && (grid_A3 == 2'd0))
					AI_move = A3;
				else if ((grid_C3 == 2'b01) && (grid_A1 == 2'd0))
					AI_move = A1;

			
			// 7. empty corner - DONE

				else if (grid_A1 == 2'd0)
					AI_move = A1;
				else if (grid_A3 == 2'd0)
					AI_move = A3;
				else if (grid_C1 == 2'd0)
					AI_move = C1;
				else if (grid_C3 == 2'd0)
					AI_move = C3;
					
			
			// 8. empty side - DONE

				else if (grid_A2 == 2'd0)
					AI_move = A2;
				else if (grid_B1 == 2'd0)
					AI_move = B1;
				else if (grid_B3 == 2'd0)
					AI_move = B3;
				else if (grid_C2 == 2'd0)
					AI_move = C2;
			
		end
		
		// easy mode - bad AI
		else 
		begin
			if (grid_A1 == 2'd0)
				AI_move = A1;
			else if (grid_A2 == 2'd0)
				AI_move = A2;
			else if (grid_A3 == 2'd0)
				AI_move = A3;
			else if (grid_B1 == 2'd0)
				AI_move = B1;
			else if (grid_B2 == 2'd0)
				AI_move = B2;
			else if (grid_B3 == 2'd0)
				AI_move = B3;
			else if (grid_C1 == 2'd0)
				AI_move = C1;
			else if (grid_C2 == 2'd0)
				AI_move = C2;
			else if (grid_C3 == 2'd0)
				AI_move = C3;
		end 
	end
	
endmodule
