// Edit 11/14/22 Claire Hopfensperger

// This module implements the FSM that works the turn system

module game_logic(clk, rst, move, outcome);
	input clk, rst;
	input [3:0]move; //9 grid squares
	output reg [1:0]outcome; //in_progress, win, lose, tie
	
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
	
	reg [1:0]turn;
	reg end_game;
	
	move_logic my_move_logic(clk, rst, move, user, valid, outcome);
	
	reg [2:0]S;
	reg [2:0]NS;
	parameter START = 3'd0,
				 USER_1 = 3'd1,
				 USER_2 = 3'd2,
				 CHECK = 3'd3, 
				 END = 3'd4,
				 ERROR = 3'hF;
				 
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
			S <= START;
		else
			S <= NS;
	end
	
	always @(*)
	begin
		case(S)
			START:
			begin
				if (turn == 2'b01)
					NS = USER_1;
				else
					NS = START;
			end
			USER_1:
			begin
				if (turn == 2'b00)
					NS = CHECK;
				else
					NS = USER_1;
			end
			USER_2:
			begin
				if (turn == 2'b00)
					NS = CHECK_2;
				else
					NS = USER_2;
			CHECK:
			begin
				if (end_game == 1'b0 && turn == 2'b01)
					NS = USER_1;
				else if (end_game == 1'b0 && turn == 2'b10)
					NS = USER_2;
				else if (end_game == 1'b1)
					NS = END;
				else
					NS = CHECK;
			end
			END: NS = END;
			default: NS = ERROR;
		endcase
	end
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			turn <= 2'b01;
		end
		else
		begin
			case (S)
				START:
				begin
				end
				USER_1:
				begin
				end
				USER_2:
				begin
				end
				CHECK:
				begin
				end
				END:
				begin
				end
				default:
				begin
				end
			endcase
		end
	end

endmodule
