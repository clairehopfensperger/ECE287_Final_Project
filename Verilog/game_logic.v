// Edit 11/14/22 Claire Hopfensperger
// DOES NOT COMPILE LIKE THIS - sorry i ran out of time to debug

// This module implements the FSM that works the turn system

module game_logic(clk, rst, move, outcome);
	input clk, rst;
	input [3:0]move; //9 grid squares
	output reg [1:0]outcome; //in_progress, win, lose, tie
	
	reg [1:0]TURN;
	reg end_game;
	
	reg [2:0]S;
	reg [2:0]NS;
	parameter START = 3'd0,
				 USER_1 = 3'd1,
				 USER_2 = 3'd2,
				 CHECK = 3'd3, //will have to implement another module for checking move validity
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
					NS = CHECK_1;
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
					NS = CHECK_1;
			end
			END: NS = END;
			default: NS = ERROR;
		endcase
	end
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
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
