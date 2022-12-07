module AI(
	input clk, rst,
	input [1:0]grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3,
	input AI_en,
	input mode,
	input [3:0]move_count,
	output reg [8:0]AI_move
	);

	reg outans;
	reg[1:0]random;
	
	always @(*)
	begin
		if (AI_en == 1'b1)
			AI_move = outans;
		else
			AI_move = 9'd0;
	end

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

	always@(posedge clk)
	begin
		if (AI_en == 1'b0)
		begin
			outans <= 9'd0;
			random <= random + 2'd1;
		end
		else
		begin
			random <= random + 2'd1;
			if (move_count == 4'd1)
			begin
				if (grid_B2[0] == 1'b1)
				begin
					outans <= C3;
				end
				else
				begin
					outans <= B2;
				end
			end
			else 
			begin
				if (mode == 1'b1) // hard mode
				begin
					//winning
					if ((grid_A3[1] && grid_A2[1] && (~grid_A1[1]) && (~grid_A1[0])) || (grid_B1[1] && grid_C1[1] && (~grid_A1[1]) && (~grid_A1[0])) || (grid_B2[1] && grid_C3[1] && (~grid_A1[0]) && (~grid_A1[1])))
					begin
						outans <= A1;
					end
					else if ((grid_A1[1] && grid_A3[1] && (~grid_A2[1]) && (~grid_A2[0])) || (grid_B2[1] && grid_C2[1] && (~grid_A2[1]) && (~grid_A2[0])))
					begin
						outans <= A2;
					end
					else if ((grid_A1[1] && grid_A2[1] && (~grid_A3[1]) && (~grid_A3[0])) || (grid_B3[1] && grid_C3[1] && (~grid_A3[1]) && (~grid_A3[0])) || (grid_B2[1] && grid_C1[1] && (~grid_A3[0]) && (~grid_A3[1])))
					begin
						outans <= A3;
					end
					else if ((grid_A1[1] && grid_C1[1] && (~grid_B1[1]) && (~grid_B1[0])) || (grid_B2[1] && grid_B3[1] && (~grid_B1[1]) && (~grid_B1[0])))
					begin
						outans <= B1;
					end
					else if ((grid_B2[1] && grid_B1[1] && (~grid_B3[1]) && (~grid_B3[0])) || (grid_C3[1] && grid_A3[1] && (~grid_B3[1]) && (~grid_B3[0])))
					begin
						outans <= B3;
					end
					else if ((grid_A3[1] && grid_B2[1] && (~grid_C1[1]) && (~grid_C1[0])) || (grid_A1[1] && grid_B1[1] && (~grid_C1[1]) && (~grid_C1[0])) || (grid_C2[1] && grid_C3[1] && (~grid_C1[0]) && (~grid_C1[1])))
					begin
						outans <= C1;
					end
					else if ((grid_A2[1] && grid_B2[1] && (~grid_C2[1]) && (~grid_C2[0])) || (grid_C1[1] && grid_C3[1] && (~grid_C2[1]) && (~grid_C2[0])))
					begin
						outans <= C2;
					end
					else if ((grid_A1[1] && grid_C1[1] && (~grid_B1[1]) && (~grid_B1[0])) || (grid_B2[1] && grid_B3[1] && (~grid_B1[1]) && (~grid_B1[0])) || (grid_B1[1] && grid_C1[1] && (~grid_A1[0]) && (~grid_A1[1])))
					begin
						outans <= B1;
					end
					else if ((grid_A1[1] && grid_C3[1] && (~grid_B2[1]) && (~grid_B2[0])) || (grid_A2[1] && grid_C2[1] && (~grid_B2[1]) && (~grid_B2[0])) || (grid_A3[1] && grid_C1[1] && (~grid_B2[0]) && (~grid_B2[1])) || (grid_B1[1] && grid_B3[1] && (~grid_B2[1]) && (~grid_B2[0])) || (grid_A2[1] && grid_C2[1] && (~grid_B2[0]) && (~grid_B2[1])))
					begin
						outans <= B2;
					end
					//blocking
					else if ((grid_B2[0] && grid_C3[0] && (~grid_A1[0]) && (~grid_A1[1])) || (grid_A2[0] && grid_A3[0] && (~grid_A1[0]) && (~grid_A1[1])) || (grid_B1[0] && grid_C1[0] && (~grid_A1[0]) && (~grid_A1[1])))
					begin
						outans <= A1;
					end
					else if ((grid_A1[0] && grid_A3[0] && (~grid_A2[0]) && (~grid_A2[1])) || (grid_B2[0] && grid_C2[0] && (~grid_A2[0]) && (~grid_A2[1])))
					begin
						outans <= A2;
					end
					else if ((grid_A1[0] && grid_A2[0] && (~grid_A3[0]) && (~grid_A3[1])) || (grid_B3[0] && grid_C3[0] && (~grid_A3[0]) && (~grid_A3[1])) || (grid_B2[0] && grid_C1[0] && (~grid_A3[0]) && (~grid_A3[1])))
					begin
						outans <= A3;
					end
					else if ((grid_A1[0] && grid_C1[0] && (~grid_B1[0]) && (~grid_B1[1])) || (grid_B2[0] && grid_B3[0] && (~grid_B1[0]) && (~grid_B1[1])))
					begin
						outans <= B1;
					end
					else if ((grid_B2[0] && grid_B1[0] && (~grid_B3[0]) && (~grid_B3[1])) || (grid_C3[0] && grid_A3[0] && (~grid_B3[0]) && (~grid_B3[1])))
					begin
						outans <= B3;
					end
					else if ((grid_A3[0] && grid_B2[0] && (~grid_C1[0]) && (~grid_C1[1])) || (grid_A1[0] && grid_B1[0] && (~grid_C1[0]) && (~grid_C1[1])) || (grid_C2[0] && grid_C3[0] && (~grid_C1[0]) && (~grid_C1[1])))
					begin
						outans <= C1;
					end
					else if ((grid_A2[0] && grid_B2[0] && (~grid_C2[0]) && (~grid_C2[1])) || (grid_C1[0] && grid_C3[0] && (~grid_C2[0]) && (~grid_C2[1])))
					begin
						outans <= C2;
					end
					else if ((grid_C2[0] && grid_C1[0] && (~grid_C3[0]) && (~grid_C3[1])) || (grid_A3[0] && grid_B3[0] && (~grid_C3[0]) && (~grid_C3[1])) || (grid_A1[0] && grid_B2[0] && (~grid_C3[0]) && (~grid_C3[1])))
					begin
						outans <= C3;
					end
					//unwinning
					else if (move_count == 4'd2)
					begin
					//O _ _
					//_ X _
					//_ _ O
						if ((grid_A1[0] && grid_C3[0] && grid_B2[1]) || (grid_A3[0] && grid_C1[0] && grid_B2[1]))
						begin
							outans <= A2;
						end

					//X _ _
					//_ O _
					//_ _ O
						if ((grid_A1[1] && grid_B2[0] && grid_C3[0]))
						begin
							outans <= A3;
						end
						if ((grid_A1[0] && grid_B2[0] && grid_C3[1]))
						begin
							outans <= C1;
						end
						if ((grid_A3[1] && grid_B2[0] && grid_C1[0]))
						begin
							outans <= A1;
						end
						if ((grid_A3[0] && grid_B2[0] && grid_C1[1]))
						begin
							outans <= C3;
						end

					//_ O _
					//_ X O
					//_ _ _
						if (grid_B2[1] && grid_A2[0] && grid_B3[0])
						begin
							outans <= A3;
						end
						if (grid_B2[1] && grid_A2[0] && grid_B1[0])
						begin
							outans <= A1;
						end
						if (grid_C2[0] && grid_B1[0] && grid_B2[1])
						begin
							outans <= C1;
						end
						if (grid_C2[0] && grid_B3[0] && grid_B2[1])
						begin
							outans <= C3;
						end

					//_ O _
					//_ X _
					//_ O _
						if (grid_B1[0] && grid_B2[1] && grid_B3[0])
						begin
							outans <= A2;
						end
						if (grid_A2[0] && grid_B2[1] && grid_C2[0])
						begin
							outans <= B3;
						end
						
					//_ _ O
					//_ X _
					//_ O _
						if (grid_A1[0] && grid_B2[1] && grid_C2[0])
						begin
							outans <= C3;
						end
						if (grid_C1[0] && grid_B2[1] && grid_B3[0])
						begin
							outans <= A3;
						end
						if (grid_A2[0] && grid_B2[1] && grid_C3[0])
						begin
							outans <= A1;
						end
						if (grid_A3[0] && grid_B2[1] && grid_B1[0])
						begin
							outans <= C1;
						end
					//O _ _
					//_ X _
					//_ O _
						if (grid_A3[0] && grid_B2[1] && grid_C2[0])
						begin
							outans <= C1;
						end
						if (grid_A1[0] && grid_B2[1] && grid_B3[0])
						begin
							outans <= C3;
						end
						if (grid_A2[0] && grid_B2[1] && grid_C1[0])
						begin
							outans <= A3;
						end
						if (grid_C3[0] && grid_B2[1] && grid_B1[0])
						begin
							outans <= A1;
						end

					end
					else 
					begin
						if (random == 2'd1)
						begin
							if (grid_B2[0] == 1'b0 && grid_B2[1] == 1'b0)
							begin
								outans <= B2;
							end
							else if (grid_A3[0] == 1'b0 && grid_A3[1] == 1'b0)
							begin
								outans <= A3;
							end
							else if (grid_C1[0] == 1'b0 && grid_C1[1] == 1'b0)
							begin
								outans <= C1;
							end
							else if (grid_A1[0] == 1'b0 && grid_A1[1] == 1'b0)
							begin
								outans <= A1;
							end
							else if (grid_C3[0] == 1'b0 && grid_C3[1] == 1'b0)
							begin
								outans <= C3;
							end
							else if (grid_B1[0] == 1'b0 && grid_B1[1] == 1'b0)
							begin
								outans <= B1;
							end
							else if (grid_B3[0] == 1'b0 && grid_B3[1] == 1'b0)
							begin
								outans <= B3;
							end
							else if (grid_A2[0] == 1'b0 && grid_A2[1] == 1'b0)
							begin
								outans <= A2;
							end
							else if (grid_C2[0] == 1'b0 && grid_C2[1] == 1'b0)
							begin
								outans <= C2;
							end
							else
							begin
								outans <= 9'd0;
							end
						end
						else if (random == 2)
						begin
							if (grid_B2[0] == 1'b0 && grid_B2[1] == 1'b0)
							begin
								outans <= B2;
							end
							else if (grid_C1[0] == 1'b0 && grid_C1[1] == 1'b0)
							begin
								outans <= C1;
							end
							else if (grid_A1[0] == 1'b0 && grid_A1[1] == 1'b0)
							begin
								outans <= A1;
							end
							else if (grid_C3[0] == 1'b0 && grid_C3[1] == 1'b0)
							begin
								outans <= C3;
							end
							else if (grid_A3[0] == 1'b0 && grid_A3[1] == 1'b0)
							begin
								outans <= A3;
							end
							else if (grid_A2[0] == 1'b0 && grid_A2[1] == 1'b0)
							begin
								outans <= A2;
							end
							
							else if (grid_C2[0] == 1'b0 && grid_C2[1] == 1'b0)
							begin
								outans <= C2;
							end
							else if (grid_B1[0] == 1'b0 && grid_B1[1] == 1'b0)
							begin
								outans <= B1;
							end
							else if (grid_B3[0] == 1'b0 && grid_B3[1] == 1'b0)
							begin
								outans <= B3;
							end
							
							else
							begin
								outans <= 9'd0;
							end
						end
						else if (random == 3)
						begin
							if (grid_B2[0] == 1'b0 && grid_B2[1] == 1'b0)
							begin
								outans <= B2;
							end
							else if (grid_C3[0] == 1'b0 && grid_C3[1] == 1'b0)
							begin
								outans <= C3;
							end
							else if (grid_A3[0] == 1'b0 && grid_A3[1] == 1'b0)
							begin
								outans <= A3;
							end
							else if (grid_C1[0] == 1'b0 && grid_C1[1] == 1'b0)
							begin
								outans <= C1;
							end
							else if (grid_A1[0] == 1'b0 && grid_A1[1] == 1'b0)
							begin
								outans <= A1;
							end
							else if (grid_A2[0] == 1'b0 && grid_A2[1] == 1'b0)
							begin
								outans <= A2;
							end
							
							else if (grid_B1[0] == 1'b0 && grid_B1[1] == 1'b0)
							begin
								outans <= B1;
							end
							else if (grid_B3[0] == 1'b0 && grid_B3[1] == 1'b0)
							begin
								outans <= B3;
							end
							
							else if (grid_C2[0] == 1'b0 && grid_C2[1] == 1'b0)
							begin
								outans <= C2;
							end
							
							else
							begin
								outans <= 9'd0;
							end
						end
						else if (random == 1'b0)
						begin
							if (grid_B2[0] == 1'b0 && grid_B2[1] == 1'b0)
							begin
								outans <= B2;
							end
							else if (grid_A1[0] == 1'b0 && grid_A1[1] == 1'b0)
							begin
								outans <= A1;
							end
							
							else if (grid_A3[0] == 1'b0 && grid_A3[1] == 1'b0)
							begin
								outans <= A3;
							end
							else if (grid_C3[0] == 1'b0 && grid_C3[1] == 1'b0)
							begin
								outans <= C3;
							end
							else if (grid_C1[0] == 1'b0 && grid_C1[1] == 1'b0)
							begin
								outans <= C1;
							end
							else if (grid_B1[0] == 1'b0 && grid_B1[1] == 1'b0)
							begin
								outans <= B1;
							end
							else if (grid_B3[0] == 1'b0 && grid_B3[1] == 1'b0)
							begin
								outans <= B3;
							end
							else if (grid_A2[0] == 1'b0 && grid_A2[1] == 1'b0)
							begin
								outans <= A2;
							end
							
							else if (grid_C2[0] == 1'b0 && grid_C2[1] == 1'b0)
							begin
								outans <= C2;
							end
							
							else
							begin
								outans <= 9'd0;
							end
						end
					end
				end
				else if (mode == 1'b0) // easy mode
				begin
				
					if (grid_A1 == 2'd0)
						outans <= A1;
					else if (grid_A2 == 2'd0)
						outans <= A2;
					else if (grid_A3 == 2'd0)
						outans <= A3;
					else if (grid_B1 == 2'd0)
						outans <= B1;
					else if (grid_B2 == 2'd0)
						outans <= B2;
					else if (grid_B3 == 2'd0)
						outans <= B3;
					else if (grid_C1 == 2'd0)
						outans <= C1;
					else if (grid_C2 == 2'd0)
						outans <= C2;
					else if (grid_C3 == 2'd0)
						outans <= C3;
					
				
				
				
				
//					//blocking
//					if ((grid_B2[0] && grid_C3[0] && (~grid_A1[0]) && (~grid_A1[1])) || (grid_A2[0] && grid_A3[0] && (~grid_A1[0]) && (~grid_A1[1])) || (grid_B1[0] && grid_C1[0] && (~grid_A1[0]) && (~grid_A1[1])))
//					begin
//						outans <= A1;
//					end
//					else if ((grid_A1[0] && grid_A3[0] && (~grid_A2[0]) && (~grid_A2[1])) || (grid_B2[0] && grid_C2[0] && (~grid_A2[0]) && (~grid_A2[1])))
//					begin
//						outans <= A2;
//					end
//					else if ((grid_A1[0] && grid_A2[0] && (~grid_A3[0]) && (~grid_A3[1])) || (grid_B3[0] && grid_C3[0] && (~grid_A3[0]) && (~grid_A3[1])) || (grid_B2[0] && grid_C1[0] && (~grid_A3[0]) && (~grid_A3[1])))
//					begin
//						outans <= A3;
//					end
//					else if ((grid_A1[0] && grid_C1[0] && (~grid_B1[0]) && (~grid_B1[1])) || (grid_B2[0] && grid_B3[0] && (~grid_B1[0]) && (~grid_B1[1])))
//					begin
//						outans <= B1;
//					end
//					else if ((grid_B2[0] && grid_B1[0] && (~grid_B3[0]) && (~grid_B3[1])) || (grid_C3[0] && grid_A3[0] && (~grid_B3[0]) && (~grid_B3[1])))
//					begin
//						outans <= B3;
//					end
//					else if ((grid_A3[0] && grid_B2[0] && (~grid_C1[0]) && (~grid_C1[1])) || (grid_A1[0] && grid_B1[0] && (~grid_C1[0]) && (~grid_C1[1])) || (grid_C2[0] && grid_C3[0] && (~grid_C1[0]) && (~grid_C1[1])))
//					begin
//						outans <= C1;
//					end
//					else if ((grid_A2[0] && grid_B2[0] && (~grid_C2[0]) && (~grid_C2[1])) || (grid_C1[0] && grid_C3[0] && (~grid_C2[0]) && (~grid_C2[1])))
//					begin
//						outans <= C2;
//					end
//					else if ((grid_C2[0] && grid_C1[0] && (~grid_C3[0]) && (~grid_C3[1])) || (grid_A3[0] && grid_B3[0] && (~grid_C3[0]) && (~grid_C3[1])) || (grid_A1[0] && grid_B2[0] && (~grid_C3[0]) && (~grid_C3[1])))
//					begin
//						outans <= C3;
//					end
//					
//					//winning
//					else if ((grid_A3[1] && grid_A2[1] && (~grid_A1[1]) && (~grid_A1[0])) || (grid_B1[1] && grid_C1[1] && (~grid_A1[1]) && (~grid_A1[0])) || (grid_B2[1] && grid_C3[1] && (~grid_A1[0]) && (~grid_A1[1])))
//					begin
//						outans <= A1;
//					end
//					else if ((grid_A1[1] && grid_A3[1] && (~grid_A2[1]) && (~grid_A2[0])) || (grid_B2[1] && grid_C2[1] && (~grid_A2[1]) && (~grid_A2[0])))
//					begin
//						outans <= A2;
//					end
//					else if ((grid_A1[1] && grid_A2[1] && (~grid_A3[1]) && (~grid_A3[0])) || (grid_B3[1] && grid_C3[1] && (~grid_A3[1]) && (~grid_A3[0])) || (grid_B2[1] && grid_C1[1] && (~grid_A3[0]) && (~grid_A3[1])))
//					begin
//						outans <= A3;
//					end
//					else if ((grid_A1[1] && grid_C1[1] && (~grid_B1[1]) && (~grid_B1[0])) || (grid_B2[1] && grid_B3[1] && (~grid_B1[1]) && (~grid_B1[0])))
//					begin
//						outans <= B1;
//					end
//					else if ((grid_B2[1] && grid_B1[1] && (~grid_B3[1]) && (~grid_B3[0])) || (grid_C3[1] && grid_A3[1] && (~grid_B3[1]) && (~grid_B3[0])))
//					begin
//						outans <= B3;
//					end
//					else if ((grid_A3[1] && grid_B2[1] && (~grid_C1[1]) && (~grid_C1[0])) || (grid_A1[1] && grid_B1[1] && (~grid_C1[1]) && (~grid_C1[0])) || (grid_C2[1] && grid_C3[1] && (~grid_C1[0]) && (~grid_C1[1])))
//					begin
//						outans <= C1;
//					end
//					else if ((grid_A2[1] && grid_B2[1] && (~grid_C2[1]) && (~grid_C2[0])) || (grid_C1[1] && grid_C3[1] && (~grid_C2[1]) && (~grid_C2[0])))
//					begin
//						outans <= C2;
//					end
//					else if ((grid_A1[1] && grid_C1[1] && (~grid_B1[1]) && (~grid_B1[0])) || (grid_B2[1] && grid_B3[1] && (~grid_B1[1]) && (~grid_B1[0])) || (grid_B1[1] && grid_C1[1] && (~grid_A1[0]) && (~grid_A1[1])))
//					begin
//						outans <= B1;
//					end
//					else if ((grid_A1[1] && grid_C3[1] && (~grid_B2[1]) && (~grid_B2[0])) || (grid_A2[1] && grid_C2[1] && (~grid_B2[1]) && (~grid_B2[0])) || (grid_A3[1] && grid_C1[1] && (~grid_B2[0]) && (~grid_B2[1])) || (grid_B1[1] && grid_B3[1] && (~grid_B2[1]) && (~grid_B2[0])) || (grid_A2[1] && grid_C2[1] && (~grid_B2[0]) && (~grid_B2[1])))
//					begin
//						outans <= B2;
//					end
//					//unwinning
//					else if (move_count == 4'd2)
//					begin
//					//O _ _
//					//_ X _
//					//_ _ O
//						if ((grid_A1[0] && grid_C3[0] && grid_B2[1]) || (grid_A3[0] && grid_C1[0] && grid_B2[1]))
//						begin
//							outans <= A2;
//						end
//
//					//X _ _
//					//_ O _
//					//_ _ O
//						if ((grid_A1[1] && grid_B2[0] && grid_C3[0]))
//						begin
//							outans <= A3;
//						end
//						if ((grid_A1[0] && grid_B2[0] && grid_C3[1]))
//						begin
//							outans <= C1;
//						end
//						if ((grid_A3[1] && grid_B2[0] && grid_C1[0]))
//						begin
//							outans <= A1;
//						end
//						if ((grid_A3[0] && grid_B2[0] && grid_C1[1]))
//						begin
//							outans <= C3;
//						end
//
//					//_ O _
//					//_ X O
//					//_ _ _
//						if (grid_B2[1] && grid_A2[0] && grid_B3[0])
//						begin
//							outans <= A3;
//						end
//						if (grid_B2[1] && grid_A2[0] && grid_B1[0])
//						begin
//							outans <= A1;
//						end
//						if (grid_C2[0] && grid_B1[0] && grid_B2[1])
//						begin
//							outans <= C1;
//						end
//						if (grid_C2[0] && grid_B3[0] && grid_B2[1])
//						begin
//							outans <= C3;
//						end
//
//					//_ O _
//					//_ X _
//					//_ O _
//						if (grid_B1[0] && grid_B2[1] && grid_B3[0])
//						begin
//							outans <= A2;
//						end
//						if (grid_A2[0] && grid_B2[1] && grid_C2[0])
//						begin
//							outans <= B3;
//						end
//						
//					//_ _ O
//					//_ X _
//					//_ O _
//						if (grid_A1[0] && grid_B2[1] && grid_C2[0])
//						begin
//							outans <= C3;
//						end
//						if (grid_C1[0] && grid_B2[1] && grid_B3[0])
//						begin
//							outans <= A3;
//						end
//						if (grid_A2[0] && grid_B2[1] && grid_C3[0])
//						begin
//							outans <= A1;
//						end
//						if (grid_A3[0] && grid_B2[1] && grid_B1[0])
//						begin
//							outans <= C1;
//						end
//					//O _ _
//					//_ X _
//					//_ O _
//						if (grid_A3[0] && grid_B2[1] && grid_C2[0])
//						begin
//							outans <= C1;
//						end
//						if (grid_A1[0] && grid_B2[1] && grid_B3[0])
//						begin
//							outans <= C3;
//						end
//						if (grid_A2[0] && grid_B2[1] && grid_C1[0])
//						begin
//							outans <= A3;
//						end
//						if (grid_C3[0] && grid_B2[1] && grid_B1[0])
//						begin
//							outans <= A1;
//						end
//
//					end
//					else 
//					begin
//						if (grid_A1[0] == 1'b0 && grid_A1[1] == 1'b0)
//						begin
//							outans <= A1;
//						end
//						else if (grid_A2[0] == 1'b0 && grid_A2[1] == 1'b0)
//						begin
//							outans <= A2;
//						end
//						else if (grid_A3[0] == 1'b0 && grid_A3[1] == 1'b0)
//						begin
//							outans <= A3;
//						end
//						else if (grid_B1[0] == 1'b0 && grid_B1[1] == 1'b0)
//						begin
//							outans <= B1;
//						end
//						else if (grid_B2[0] == 1'b0 && grid_B2[1] == 1'b0)
//						begin
//							outans <= B2;
//						end
//						else if (grid_B3[0] == 1'b0 && grid_B3[1] == 1'b0)
//						begin
//							outans <= B3;
//						end
//						else if (grid_C1[0] == 1'b0 && grid_C1[1] == 1'b0)
//						begin
//							outans <= C1;
//						end
//						else if (grid_C2[0] == 1'b0 && grid_C2[1] == 1'b0)
//						begin
//							outans <= C2;
//						end
//						else if (grid_C3[0] == 1'b0 && grid_C3[1] == 1'b0)
//						begin
//							outans <= C3;
//						end
//						else
//						begin
//							outans <= 9'd0;
//						end
//					end
				end
			end
		end
	end

endmodule
