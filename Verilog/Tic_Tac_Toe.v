// top level module for project

module Tic_Tac_Toe(
	input clk, 
	input rst,
	
	input [8:0]move, //9 grid squares
	//input check,
	//input start,
	input AI_en, // 0 = player1 v player2, 1 = player1 v AI
	input mode, // level of difficulty of AI
	output reg valid,
	output reg [2:0]outcome, //in_progress, win, lose, tie
	
	// grid values
	output reg [1:0]grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3,
	
	// VGA outputs
	output [9:0]VGA_R,
	output [9:0]VGA_G,
	output [9:0]VGA_B,
	output VGA_HS,
	output VGA_VS,
	output VGA_BLANK,
	output VGA_SYNC,
	output VGA_CLK,
	
	// seven segment
	output [6:0]seg7_dig0,
	output [6:0]seg7_dig1,
	
	// tester outputs
	output reg p1_test,
	output reg p2_test,
	output reg AI_test,
	output reg [8:0]move_out,
	output reg en_test,
	
	output reg [8:0]p2_move
	);
	
	// variables used for vga
	reg plot = 1'b1; 
	reg [31:0]x;
	reg [31:0]y;
	reg [2:0]color;
	reg back_color = 3'b000;
	
	// counter variables used for displaying
	reg [31:0]count_x;
	reg [31:0]count_y;
	
	vga_adapter my_vga(rst, clk, color, x, y, plot, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	
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
				 
	// instantiating modules
	//reg valid;
	//reg [2:0]outcome;
	//reg [1:0]grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3;
	reg [2:0]A1_color, A2_color, A3_color, B1_color, B2_color, B3_color, C1_color, C2_color, C3_color;
	reg [1:0]user;
	
	// constant on variables, can remove checks with these
	reg start;
	reg check;
	
	// user moves
	reg [8:0]p1_move;
	//reg [8:0]p2_move;
	
	// outcome parameters
	parameter in_progress = 3'd0,
				 p1_win = 3'd1,
				 p1_lose = 3'd2,
				 tie = 3'd3;

	// player parameters
	parameter player1 = 2'b01,
				 player2 = 2'b10,
				 default_player = 2'b00;
	
	// grid color parameters
	parameter p1_color = 3'b010,
	          p2_color = 3'b101,
	          default_color = 3'b111;
				 
	wire [8:0]AI_move;
	reg [3:0]move_count;
	
	AI my_AI(clk, rst, grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3, AI_en, mode, move_count, AI_move);
	
	reg [7:0]S;
	reg [7:0]NS;
	
	parameter 
		INIT = 8'd70,
		
		// background
		BACK_START = 8'd0,
		BACK_CHECK_Y = 8'd1,
		BACK_CHECK_X = 8'd2,
		BACK_UPDATE_Y = 8'd3,
		BACK_UPDATE_X = 8'd4,
		BACK_DRAW = 8'd5,
		BACK_END = 8'd6,
		
		// A1
		A1_START = 8'd7,
		A1_CHECK_Y = 8'd8,
		A1_CHECK_X = 8'd9,
		A1_UPDATE_Y = 8'd10,
		A1_UPDATE_X = 8'd11,
		A1_DRAW = 8'd12,
		A1_END = 8'd13,
		
		// A2
		A2_START = 8'd14,
		A2_CHECK_Y = 8'd15,
		A2_CHECK_X = 8'd16,
		A2_UPDATE_Y = 8'd17,
		A2_UPDATE_X = 8'd18,
		A2_DRAW = 8'd19,
		A2_END = 8'd20,
		
		// A3
		A3_START = 8'd21,
		A3_CHECK_Y = 8'd22,
		A3_CHECK_X = 8'd23,
		A3_UPDATE_Y = 8'd24,
		A3_UPDATE_X = 8'd25,
		A3_DRAW = 8'd26,
		A3_END = 8'd27,
		
		// B1
		B1_START = 8'd28,
		B1_CHECK_Y = 8'd29,
		B1_CHECK_X = 8'd30,
		B1_UPDATE_Y = 8'd31,
		B1_UPDATE_X = 8'd32,
		B1_DRAW = 8'd33,
		B1_END = 8'd34,
		
		// B2
		B2_START = 8'd35,
		B2_CHECK_Y = 8'd36,
		B2_CHECK_X = 8'd37,
		B2_UPDATE_Y = 8'd38,
		B2_UPDATE_X = 8'd39,
		B2_DRAW = 8'd40,
		B2_END = 8'd41,
		
		// B3
		B3_START = 8'd42,
		B3_CHECK_Y = 8'd43,
		B3_CHECK_X = 8'd44,
		B3_UPDATE_Y = 8'd45,
		B3_UPDATE_X = 8'd46,
		B3_DRAW = 8'd47,
		B3_END = 8'd48,
		
		// C1
		C1_START = 8'd49,
		C1_CHECK_Y = 8'd50,
		C1_CHECK_X = 8'd51,
		C1_UPDATE_Y = 8'd52,
		C1_UPDATE_X = 8'd53,
		C1_DRAW = 8'd54,
		C1_END = 8'd55,
		
		// C2
		C2_START = 8'd56,
		C2_CHECK_Y = 8'd57,
		C2_CHECK_X = 8'd58,
		C2_UPDATE_Y = 8'd59,
		C2_UPDATE_X = 8'd60,
		C2_DRAW = 8'd61,
		C2_END = 8'd62,
		
		// C3
		C3_START = 8'd63,
		C3_CHECK_Y = 8'd64,
		C3_CHECK_X = 8'd65,
		C3_UPDATE_Y = 8'd66,
		C3_UPDATE_X = 8'd67,
		C3_DRAW = 8'd68,
		C3_END = 8'd69,
		
		//INIT = 70
		START = 8'd71,
		P1 = 8'd72,
		GET_MOVE_P1 = 8'd73,
		CHECK_VALIDITY = 8'd74,
		UPDATE_GRID = 8'd75,
		UPDATE_BOARD = 8'd76,
		
		// A1 redraw
		RE_A1_START = 8'd77,
		RE_A1_CHECK_Y = 8'd78,
		RE_A1_CHECK_X = 8'd79,
		RE_A1_UPDATE_Y = 8'd80,
		RE_A1_UPDATE_X = 8'd81,
		RE_A1_DRAW = 8'd82,
		RE_A1_END = 8'd83,
		
		// A2 redraw
		RE_A2_START = 8'd145,
		RE_A2_CHECK_Y = 8'd84,
		RE_A2_CHECK_X = 8'd85,
		RE_A2_UPDATE_Y = 8'd86,
		RE_A2_UPDATE_X = 8'd87,
		RE_A2_DRAW = 8'd88,
		RE_A2_END = 8'd89,
		
		// A3 redraw
		RE_A3_START = 8'd90,
		RE_A3_CHECK_Y = 8'd91,
		RE_A3_CHECK_X = 8'd92,
		RE_A3_UPDATE_Y = 8'd93,
		RE_A3_UPDATE_X = 8'd94,
		RE_A3_DRAW = 8'd95,
		RE_A3_END = 8'd96,
		
		// B1 redraw
		RE_B1_START = 8'd97,
		RE_B1_CHECK_Y = 8'd98,
		RE_B1_CHECK_X = 8'd99,
		RE_B1_UPDATE_Y = 8'd100,
		RE_B1_UPDATE_X = 8'd101,
		RE_B1_DRAW = 8'd102,
		RE_B1_END = 8'd103,
		
		// B2 redraw
 		RE_B2_START = 8'd104,
		RE_B2_CHECK_Y = 8'd105,
		RE_B2_CHECK_X = 8'd106,
		RE_B2_UPDATE_Y = 8'd107,
		RE_B2_UPDATE_X = 8'd108,
		RE_B2_DRAW = 8'd109,
		RE_B2_END = 8'd110,
		
		// B3 redraw
		RE_B3_START = 8'd111,
		RE_B3_CHECK_Y = 8'd112,
		RE_B3_CHECK_X = 8'd113,
		RE_B3_UPDATE_Y = 8'd114,
		RE_B3_UPDATE_X = 8'd115,
		RE_B3_DRAW = 8'd116,
		RE_B3_END = 8'd117,
		
		// C1 redraw
		RE_C1_START = 8'd118,
		RE_C1_CHECK_Y = 8'd119,
		RE_C1_CHECK_X = 8'd120,
		RE_C1_UPDATE_Y = 8'd121,
		RE_C1_UPDATE_X = 8'd122,
		RE_C1_DRAW = 8'd123,
		RE_C1_END = 8'd124,
		
		// C2 redraw
 		RE_C2_START = 8'd125,
		RE_C2_CHECK_Y = 8'd126,
		RE_C2_CHECK_X = 8'd127,
		RE_C2_UPDATE_Y = 8'd128,
		RE_C2_UPDATE_X = 8'd129,
		RE_C2_DRAW = 8'd130,
		RE_C2_END = 8'd131,
		
		// C3 redraw
		RE_C3_START = 8'd132,
		RE_C3_CHECK_Y = 8'd133,
		RE_C3_CHECK_X = 8'd134,
		RE_C3_UPDATE_Y = 8'd135,
		RE_C3_UPDATE_X = 8'd136,
		RE_C3_DRAW = 8'd137,
		RE_C3_END = 8'd138,
		
		CHECK_OUTCOME = 8'd139,
		DETERMINE_OUTCOME = 8'd144,
		P2 = 8'd140,
		GET_MOVE_AI = 8'd146,
		AI_WAIT = 8'd154,
		GET_MOVE_P2 = 8'd141,
		//DISPLAY_OUTCOME = 8'd142, // add after game is functioning
		END = 8'd143,
		
		// display win
		WIN_START = 8'd147,
		WIN_CHECK_Y = 8'd148,
		WIN_CHECK_X = 8'd149,
		WIN_UPDATE_Y = 8'd150,
		WIN_UPDATE_X = 8'd151,
		WIN_DRAW = 8'd152,
		WIN_END = 8'd153,
		
		ERROR = 8'hF;
				 
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
			S <= INIT;
		else
			S <= NS;
	end
	
	always @(*)
	begin
		move_out = move; // tester
		en_test = AI_en;
	
		case(S)
			INIT: NS = BACK_START;
			
			BACK_START: NS = BACK_CHECK_Y;
			BACK_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = BACK_CHECK_X;
				end
				else
				begin
					NS = BACK_END;
				end
			end
			BACK_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = BACK_DRAW;
				end
				else
				begin
					NS = BACK_UPDATE_Y;
				end
			end
			BACK_UPDATE_Y: NS = BACK_CHECK_Y;
			BACK_UPDATE_X: NS = BACK_CHECK_X;
			BACK_DRAW: NS = BACK_UPDATE_X;
			BACK_END: NS = A1_START;
			
			// A1
			A1_START: NS = A1_CHECK_Y;
			A1_CHECK_Y: 
			begin
				if (count_y < 77)
				begin
					NS = A1_CHECK_X;
				end
				else
				begin
					NS = A1_END;
				end
			end
			A1_CHECK_X:
			begin
				if (count_x < 104)
				begin
					NS = A1_DRAW;
				end
				else
				begin
					NS = A1_UPDATE_Y;
				end
			end
			A1_UPDATE_Y: NS = A1_CHECK_Y;
			A1_UPDATE_X: NS = A1_CHECK_X;
			A1_DRAW: NS = A1_UPDATE_X;
			A1_END: NS = A2_START;
			
			// A2
			A2_START: NS = A2_CHECK_Y;
			A2_CHECK_Y: 
			begin
				if (count_y < 77)
				begin
					NS = A2_CHECK_X;
				end
				else
				begin
					NS = A2_END;
				end
			end
			A2_CHECK_X:
			begin
				if (count_x < 211)
				begin
					NS = A2_DRAW;
				end
				else
				begin
					NS = A2_UPDATE_Y;
				end
			end
			A2_UPDATE_Y: NS = A2_CHECK_Y;
			A2_UPDATE_X: NS = A2_CHECK_X;
			A2_DRAW: NS = A2_UPDATE_X;
			A2_END: NS = A3_START;
			
			// A3
			A3_START: NS = A3_CHECK_Y;
			A3_CHECK_Y: 
			begin
				if (count_y < 77)
				begin
					NS = A3_CHECK_X;
				end
				else
				begin
					NS = A3_END;
				end
			end
			A3_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = A3_DRAW;
				end
				else
				begin
					NS = A3_UPDATE_Y;
				end
			end
			A3_UPDATE_Y: NS = A3_CHECK_Y;
			A3_UPDATE_X: NS = A3_CHECK_X;
			A3_DRAW: NS = A3_UPDATE_X;
			A3_END: NS = B1_START;
			
			// B1
			B1_START: NS = B1_CHECK_Y;
			B1_CHECK_Y: 
			begin
				if (count_y < 158)
				begin
					NS = B1_CHECK_X;
				end
				else
				begin
					NS = B1_END;
				end
			end
			B1_CHECK_X:
			begin
				if (count_x < 104)
				begin
					NS = B1_DRAW;
				end
				else
				begin
					NS = B1_UPDATE_Y;
				end
			end
			B1_UPDATE_Y: NS = B1_CHECK_Y;
			B1_UPDATE_X: NS = B1_CHECK_X;
			B1_DRAW: NS = B1_UPDATE_X;
			B1_END: NS = B2_START;
			
			// B2
			B2_START: NS = B2_CHECK_Y;
			B2_CHECK_Y: 
			begin
				if (count_y < 158)
				begin
					NS = B2_CHECK_X;
				end
				else
				begin
					NS = B2_END;
				end
			end
			B2_CHECK_X:
			begin
				if (count_x < 211)
				begin
					NS = B2_DRAW;
				end
				else
				begin
					NS = B2_UPDATE_Y;
				end
			end
			B2_UPDATE_Y: NS = B2_CHECK_Y;
			B2_UPDATE_X: NS = B2_CHECK_X;
			B2_DRAW: NS = B2_UPDATE_X;
			B2_END: NS = B3_START;
			
			// B3
			B3_START: NS = B3_CHECK_Y;
			B3_CHECK_Y: 
			begin
				if (count_y < 158)
				begin
					NS = B3_CHECK_X;
				end
				else
				begin
					NS = B3_END;
				end
			end
			B3_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = B3_DRAW;
				end
				else
				begin
					NS = B3_UPDATE_Y;
				end
			end
			B3_UPDATE_Y: NS = B3_CHECK_Y;
			B3_UPDATE_X: NS = B3_CHECK_X;
			B3_DRAW: NS = B3_UPDATE_X;
			B3_END: NS = C1_START;
			
			// C1
			C1_START: NS = C1_CHECK_Y;
			C1_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = C1_CHECK_X;
				end
				else
				begin
					NS = C1_END;
				end
			end
			C1_CHECK_X:
			begin
				if (count_x < 104)
				begin
					NS = C1_DRAW;
				end
				else
				begin
					NS = C1_UPDATE_Y;
				end
			end
			C1_UPDATE_Y: NS = C1_CHECK_Y;
			C1_UPDATE_X: NS = C1_CHECK_X;
			C1_DRAW: NS = C1_UPDATE_X;
			C1_END: NS = C2_START;
			
			// C2
			C2_START: NS = C2_CHECK_Y;
			C2_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = C2_CHECK_X;
				end
				else
				begin
					NS = C2_END;
				end
			end
			C2_CHECK_X:
			begin
				if (count_x < 211)
				begin
					NS = C2_DRAW;
				end
				else
				begin
					NS = C2_UPDATE_Y;
				end
			end
			C2_UPDATE_Y: NS = C2_CHECK_Y;
			C2_UPDATE_X: NS = C2_CHECK_X;
			C2_DRAW: NS = C2_UPDATE_X;
			C2_END: NS = C3_START;
			
			// C3
			C3_START: NS = C3_CHECK_Y;
			C3_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = C3_CHECK_X;
				end
				else
				begin
					NS = C3_END;
				end
			end
			C3_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = C3_DRAW;
				end
				else
				begin
					NS = C3_UPDATE_Y;
				end
			end
			C3_UPDATE_Y: NS = C3_CHECK_Y;
			C3_UPDATE_X: NS = C3_CHECK_X;
			C3_DRAW: NS = C3_UPDATE_X;
			C3_END: NS = START;
			
			START: 
			begin
				if (start == 1'b1)
					NS = P1;
				else
					NS = START;
			end
			P1: NS = GET_MOVE_P1;
			GET_MOVE_P1: 
			begin
				if (check == 1'b1)
					NS = CHECK_VALIDITY;
				else
					NS = GET_MOVE_P1;
			end
			CHECK_VALIDITY:
			begin
				if (valid == 1'b0)
				begin
					if (user == player1)
						NS = GET_MOVE_P1;
					else if ((user == player2) && (AI_en == 1'b1))
						NS = GET_MOVE_AI;
					else if ((user == player2) && (AI_en == 1'b0))
						NS = GET_MOVE_P2;
				end
				else
					NS = UPDATE_GRID;
			end
			UPDATE_GRID: NS = UPDATE_BOARD;
			UPDATE_BOARD:
			begin
				if ((p1_move == A1) || (p2_move == A1))
					NS = RE_A1_START;
				else if ((p1_move == A2) || (p2_move == A2))
					NS = RE_A2_START;
				else if ((p1_move == A3) || (p2_move == A3))	
					NS = RE_A3_START;
				else if ((p1_move == B1) || (p2_move == B1))
					NS = RE_B1_START;
				else if ((p1_move == B2) || (p2_move == B2))
					NS = RE_B2_START;
				else if ((p1_move == B3) || (p2_move == B3))
					NS = RE_B3_START;
				else if ((p1_move == C1) || (p2_move == C1))
					NS = RE_C1_START;
				else if ((p1_move == C2) || (p2_move == C2))
					NS = RE_C2_START;
				else if ((p1_move == C3) || (p2_move == C3))
					NS = RE_C3_START;
				else 
				begin
					if (user == player1)
						NS = GET_MOVE_P1;
					else if ((user == player2) && (AI_en == 1'b0))
						NS = GET_MOVE_P2; 
					else if ((user == player2) && (AI_en == 1'b1))
						NS = GET_MOVE_AI;
				end
			end
					
			// A1 redraw
			RE_A1_START: NS = RE_A1_CHECK_Y;
			RE_A1_CHECK_Y: 
			begin
				if (count_y < 77)
				begin
					NS = RE_A1_CHECK_X;
				end
				else
				begin
					NS = RE_A1_END;
				end
			end
			RE_A1_CHECK_X:
			begin
				if (count_x < 104)
				begin
					NS = RE_A1_DRAW;
				end
				else
				begin
					NS = RE_A1_UPDATE_Y;
				end
			end
			RE_A1_UPDATE_Y: NS = RE_A1_CHECK_Y;
			RE_A1_UPDATE_X: NS = RE_A1_CHECK_X;
			RE_A1_DRAW: NS = RE_A1_UPDATE_X;
			RE_A1_END: NS = CHECK_OUTCOME;
			
			// A2 redraw
			RE_A2_START: NS = RE_A2_CHECK_Y;
			RE_A2_CHECK_Y: 
			begin
				if (count_y < 77)
				begin
					NS = RE_A2_CHECK_X;
				end
				else
				begin
					NS = RE_A2_END;
				end
			end
			RE_A2_CHECK_X:
			begin
				if (count_x < 211)
				begin
					NS = RE_A2_DRAW;
				end
				else
				begin
					NS = RE_A2_UPDATE_Y;
				end
			end
			RE_A2_UPDATE_Y: NS = RE_A2_CHECK_Y;
			RE_A2_UPDATE_X: NS = RE_A2_CHECK_X;
			RE_A2_DRAW: NS = RE_A2_UPDATE_X;
			RE_A2_END: NS = CHECK_OUTCOME;
			
			// A3 redraw
			RE_A3_START: NS = RE_A3_CHECK_Y;
			RE_A3_CHECK_Y: 
			begin
				if (count_y < 77)
				begin
					NS = RE_A3_CHECK_X;
				end
				else
				begin
					NS = RE_A3_END;
				end
			end
			RE_A3_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = RE_A3_DRAW;
				end
				else
				begin
					NS = RE_A3_UPDATE_Y;
				end
			end
			RE_A3_UPDATE_Y: NS = RE_A3_CHECK_Y;
			RE_A3_UPDATE_X: NS = RE_A3_CHECK_X;
			RE_A3_DRAW: NS = RE_A3_UPDATE_X;
			RE_A3_END: NS = CHECK_OUTCOME;
			
			// B1 redraw
			RE_B1_START: NS = RE_B1_CHECK_Y;
			RE_B1_CHECK_Y: 
			begin
				if (count_y < 158)
				begin
					NS = RE_B1_CHECK_X;
				end
				else
				begin
					NS = RE_B1_END;
				end
			end
			RE_B1_CHECK_X:
			begin
				if (count_x < 104)
				begin
					NS = RE_B1_DRAW;
				end
				else
				begin
					NS = RE_B1_UPDATE_Y;
				end
			end
			RE_B1_UPDATE_Y: NS = RE_B1_CHECK_Y;
			RE_B1_UPDATE_X: NS = RE_B1_CHECK_X;
			RE_B1_DRAW: NS = RE_B1_UPDATE_X;
			RE_B1_END: NS = CHECK_OUTCOME;
			
			// B2 redraw
			RE_B2_START: NS = RE_B2_CHECK_Y;
			RE_B2_CHECK_Y: 
			begin
				if (count_y < 158)
				begin
					NS = RE_B2_CHECK_X;
				end
				else
				begin
					NS = RE_B2_END;
				end
			end
			RE_B2_CHECK_X:
			begin
				if (count_x < 211)
				begin
					NS = RE_B2_DRAW;
				end
				else
				begin
					NS = RE_B2_UPDATE_Y;
				end
			end
			RE_B2_UPDATE_Y: NS = RE_B2_CHECK_Y;
			RE_B2_UPDATE_X: NS = RE_B2_CHECK_X;
			RE_B2_DRAW: NS = RE_B2_UPDATE_X;
			RE_B2_END: NS = CHECK_OUTCOME;
			
			// B3 redraw
			RE_B3_START: NS = RE_B3_CHECK_Y;
			RE_B3_CHECK_Y: 
			begin
				if (count_y < 158)
				begin
					NS = RE_B3_CHECK_X;
				end
				else
				begin
					NS = RE_B3_END;
				end
			end
			RE_B3_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = RE_B3_DRAW;
				end
				else
				begin
					NS = RE_B3_UPDATE_Y;
				end
			end
			RE_B3_UPDATE_Y: NS = RE_B3_CHECK_Y;
			RE_B3_UPDATE_X: NS = RE_B3_CHECK_X;
			RE_B3_DRAW: NS = RE_B3_UPDATE_X;
			RE_B3_END: NS = CHECK_OUTCOME;
			
			// C1 redraw
			RE_C1_START: NS = RE_C1_CHECK_Y;
			RE_C1_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = RE_C1_CHECK_X;
				end
				else
				begin
					NS = RE_C1_END;
				end
			end
			RE_C1_CHECK_X:
			begin
				if (count_x < 104)
				begin
					NS = RE_C1_DRAW;
				end
				else
				begin
					NS = RE_C1_UPDATE_Y;
				end
			end
			RE_C1_UPDATE_Y: NS = RE_C1_CHECK_Y;
			RE_C1_UPDATE_X: NS = RE_C1_CHECK_X;
			RE_C1_DRAW: NS = RE_C1_UPDATE_X;
			RE_C1_END: NS = CHECK_OUTCOME;
			
			// C2 redraw
			RE_C2_START: NS = RE_C2_CHECK_Y;
			RE_C2_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = RE_C2_CHECK_X;
				end
				else
				begin
					NS = RE_C2_END;
				end
			end
			RE_C2_CHECK_X:
			begin
				if (count_x < 211)
				begin
					NS = RE_C2_DRAW;
				end
				else
				begin
					NS = RE_C2_UPDATE_Y;
				end
			end
			RE_C2_UPDATE_Y: NS = RE_C2_CHECK_Y;
			RE_C2_UPDATE_X: NS = RE_C2_CHECK_X;
			RE_C2_DRAW: NS = RE_C2_UPDATE_X;
			RE_C2_END: NS = CHECK_OUTCOME;
			
			// C3 redraw
			RE_C3_START: NS = RE_C3_CHECK_Y;
			RE_C3_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = RE_C3_CHECK_X;
				end
				else
				begin
					NS = RE_C3_END;
				end
			end
			RE_C3_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = RE_C3_DRAW;
				end
				else
				begin
					NS = RE_C3_UPDATE_Y;
				end
			end
			RE_C3_UPDATE_Y: NS = RE_C3_CHECK_Y;
			RE_C3_UPDATE_X: NS = RE_C3_CHECK_X;
			RE_C3_DRAW: NS = RE_C3_UPDATE_X;
			RE_C3_END: NS = CHECK_OUTCOME;
			
			CHECK_OUTCOME: NS = DETERMINE_OUTCOME;
			DETERMINE_OUTCOME:
			begin
				if ((outcome == in_progress) && (user == player1))
					NS = P2;
				else if ((outcome == in_progress) && (user == player2))
					NS = P1;
				else if (outcome != in_progress)
					//NS = DISPLAY_OUTCOME;
					NS = END;
				else
					NS = CHECK_OUTCOME;
			end
			P2: 
			begin
				if (AI_en == 1'b1)
					NS = GET_MOVE_AI;
				else
					NS = GET_MOVE_P2;
			end
			GET_MOVE_AI: NS = AI_WAIT;
			AI_WAIT: // added wait state - test
			begin
				if (check == 1'b1)
					NS = CHECK_VALIDITY;
				else
					NS = GET_MOVE_AI;
			end
			GET_MOVE_P2:
			begin
				if (check == 1'b1)
					NS = CHECK_VALIDITY;
				else
					NS = GET_MOVE_P2;
			end
			END: NS = WIN_START;
			
			// display winner
			WIN_START: NS = WIN_CHECK_Y;
			WIN_CHECK_Y: 
			begin
				if (count_y < 240)
				begin
					NS = WIN_CHECK_X;
				end
				else
				begin
					NS = WIN_END;
				end
			end
			WIN_CHECK_X:
			begin
				if (count_x < 320)
				begin
					NS = WIN_DRAW;
				end
				else
				begin
					NS = WIN_UPDATE_Y;
				end
			end
			WIN_UPDATE_Y: NS = WIN_CHECK_Y;
			WIN_UPDATE_X: NS = WIN_CHECK_X;
			WIN_DRAW: NS = WIN_UPDATE_X;
			WIN_END: NS = WIN_END;
			
			default: NS = ERROR;
		endcase
	end
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			valid <= 1'b0;
			user <= default_player;
			outcome <= in_progress;
			start <= 1'b1;
			check <= 1'b1;
		
			// default colors for board
			A1_color <= default_color;
			A2_color <= default_color;
			A3_color <= default_color;
			B1_color <= default_color;
			B2_color <= default_color;
			B3_color <= default_color;
			C1_color <= default_color;
			C2_color <= default_color;
			C3_color <= default_color;
			
			// default values for grid squares
			grid_A1 <= default_player;
			grid_A2 <= default_player;
			grid_A3 <= default_player;
			grid_B1 <= default_player;
			grid_B2 <= default_player;
			grid_B3 <= default_player;
			grid_C1 <= default_player;
			grid_C2 <= default_player;
			grid_C3 <= default_player;
			
			// vga variables
			count_x <= 32'd0;
			count_y <= 32'd0;
			x <= 9'd0;
			y <= 8'd0;
			color <= 3'b111;
			
			p1_move <= 2'd0;
			p2_move <= 2'd0;
			move_count <= 4'd0;
			
		end
		else
		begin		
			case(S)
				INIT:
				begin
					// default colors for board
					A1_color <= default_color;
					A2_color <= default_color;
					A3_color <= default_color;
					B1_color <= default_color;
					B2_color <= default_color;
					B3_color <= default_color;
					C1_color <= default_color;
					C2_color <= default_color;
					C3_color <= default_color;
					
					// default values for grid squares
					grid_A1 <= default_player;
					grid_A2 <= default_player;
					grid_A3 <= default_player;
					grid_B1 <= default_player;
					grid_B2 <= default_player;
					grid_B3 <= default_player;
					grid_C1 <= default_player;
					grid_C2 <= default_player;
					grid_C3 <= default_player;
					
					//testers
					p1_test <= 1'b0;
					p2_test <= 1'b0;
					AI_test <= 1'b0;
				end
				
				// background
				BACK_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd0;
				end
				BACK_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				BACK_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				BACK_DRAW:
				begin
					color <= back_color;
					x <= count_x;
					y <= count_y;
				end
				
				// A1
				A1_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd0;
				end
				A1_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				A1_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				A1_DRAW:
				begin
					color <= A1_color;
					x <= count_x;
					y <= count_y;
				end
				
				// A2
				A2_START:
				begin
					count_x <= 32'd109;
					count_y <= 32'd0;
				end
				A2_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd109;
				end
				A2_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				A2_DRAW:
				begin
					color <= A2_color;
					x <= count_x;
					y <= count_y;
				end
				
				// A3
				A3_START:
				begin
					count_x <= 32'd216;
					count_y <= 32'd0;
				end
				A3_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd216;
				end
				A3_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				A3_DRAW:
				begin
					color <= A3_color;
					x <= count_x;
					y <= count_y;
				end
				
				// B1
				B1_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd82;
				end
				B1_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				B1_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				B1_DRAW:
				begin
					color <= B1_color;
					x <= count_x;
					y <= count_y;
				end
				
				// B2
				B2_START:
				begin
					count_x <= 32'd109;
					count_y <= 32'd82;
				end
				B2_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd109;
				end
				B2_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				B2_DRAW:
				begin
					color <= B2_color;
					x <= count_x;
					y <= count_y;
				end
				
				// B3
				B3_START:
				begin
					count_x <= 32'd216;
					count_y <= 32'd82;
				end
				B3_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd216;
				end
				B3_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				B3_DRAW:
				begin
					color <= B3_color;
					x <= count_x;
					y <= count_y;
				end
				
				// C1
				C1_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd163;
				end
				C1_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				C1_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				C1_DRAW:
				begin
					color <= C1_color;
					x <= count_x;
					y <= count_y;
				end
				
				// C2
				C2_START:
				begin
					count_x <= 32'd109;
					count_y <= 32'd163;
				end
				C2_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd109;
				end
				C2_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				C2_DRAW:
				begin
					color <= C2_color;
					x <= count_x;
					y <= count_y;
				end
				
				// C3
				C3_START:
				begin
					count_x <= 32'd216;
					count_y <= 32'd163;
				end
				C3_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd216;
				end
				C3_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				C3_DRAW:
				begin
					color <= C3_color;
					x <= count_x;
					y <= count_y;
				end
				
				START:
				begin
					valid <= 1'b0;
					user <= default_player;
					outcome <= in_progress;
				end
				P1: 
				begin
					user <= player1;
					valid <= 1'b0;
				end
				GET_MOVE_P1:
				begin
					p1_move <= move;
					p2_move <= 9'd0;
					p1_test <= 1'b1;
					
				end
				CHECK_VALIDITY:
				begin
				
					p1_test <= 1'b0;
					p2_test <= 1'b0;
					AI_test <= 1'b0;
					
					// A1
					if ((p1_move == A1 || p2_move == A1) && (grid_A1 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == A1 || p2_move == A1) && (grid_A1 != default_player))
						valid <= 1'b0;
					
					// A2
					if ((p1_move == A2 || p2_move == A2) && (grid_A2 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == A2 || p2_move == A2) && (grid_A2 != default_player))
						valid <= 1'b0;
						
					// A3
					if ((p1_move == A3 || p2_move == A3) && (grid_A3 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == A3 || p2_move == A3) && (grid_A3 != default_player))
						valid <= 1'b0;
						
					// B1
					if ((p1_move == B1 || p2_move == B1) && (grid_B1 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == B1 || p2_move == B1) && (grid_B2 != default_player))
						valid <= 1'b0;
						
					// B2
					if ((p1_move == B2 || p2_move == B2) && (grid_B2 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == B2 || p2_move == B2) && (grid_B2 != default_player))
						valid <= 1'b0;
						
					// B3
					if ((p1_move == B3 || p2_move == B3) && (grid_B3 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == B3 || p2_move == B3) && (grid_B1 != default_player))
						valid <= 1'b0;
						
					// C1
					if ((p1_move == C1 || p2_move == C1) && (grid_C1 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == C1 || p2_move == C1) && (grid_C1 != default_player))
						valid <= 1'b0;
						
					// C2
					if ((p1_move == C2 || p2_move == C2) && (grid_C2 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == C2 || p2_move == C2) && (grid_C2 != default_player))
						valid <= 1'b0;
						
					// C3
					if ((p1_move == C3 || p2_move == C3) && (grid_C3 == default_player))
					begin
						valid <= 1'b1;
					end
					else if ((p1_move == C3 || p2_move == C3) && (grid_C3 != default_player))
						valid <= 1'b0;
						
				end
				UPDATE_GRID:
				begin
					
					// A1
					if ((p1_move == A1) || (p2_move == A1))
					begin
						grid_A1 <= user;
					end
					
					// A2
					if ((p1_move == A2) || (p2_move == A2)) 
					begin
						grid_A2 <= user;
					end
					
					// A3
					if ((p1_move == A3) || (p2_move == A3))
					begin
						grid_A3 <= user;
					end
					
					// B1
					if ((p1_move == B1) || (p2_move == B1))
					begin
						grid_B1 <= user;
					end
					
					// B2
					if ((p1_move == B2) || (p2_move == B2))
					begin
						grid_B2 <= user;
					end
					
					// B3
					if ((p1_move == B3) || (p2_move == B3))
					begin
						grid_B3 <= user;
					end
					
					// C1
					if ((p1_move == C1) || (p2_move == C1))
					begin
						grid_C1 <= user;
					end
					
					// C2
					if ((p1_move == C2) || (p2_move == C2))
					begin
						grid_C2 <= user;
					end
					
					// C3
					if ((p1_move == C3) || (p2_move == C3))
					begin
						grid_C3 <= user;
					end
				end
				UPDATE_BOARD:
				begin
					p1_move <= 2'd0;
					p2_move <= 2'd0;
					move_count <= move_count + 4'd1;
					
					// A1
					if (grid_A1 == player1)
					begin
						A1_color <= p1_color;
					end
					else if (grid_A1 == player2)
					begin
						A1_color <= p2_color;
					end
					else
					begin
						A1_color <= default_color;
					end
					
					
					// A2
					if (grid_A2 == player1)
					begin
						A2_color <= p1_color;
					end
					else if (grid_A2 == player2)
					begin
						A2_color <= p2_color;
					end
					else
					begin
						A2_color <= default_color;
					end
					
					// A3
					if (grid_A3 == player1)
					begin
						A3_color <= p1_color;
					end
					else if (grid_A3 == player2)
					begin
						A3_color <= p2_color;
					end
					else
					begin
						A3_color <= default_color;
					end
					
					// B1
					if (grid_B1 == player1)
					begin
						B1_color <= p1_color;
					end
					else if (grid_B1 == player2)
					begin
						B1_color <= p2_color;
					end
					else
					begin
						B1_color <= default_color;
					end
					
					// B2
					if (grid_B2 == player1)
					begin
						B2_color <= p1_color;
					end
					else if (grid_B2 == player2)
					begin
						B2_color <= p2_color;
					end
					else
					begin
						B2_color <= default_color;
					end
					
					// B3
					if (grid_B3 == player1)
					begin
						B3_color <= p1_color;
					end
					else if (grid_B3 == player2)
					begin
						B3_color <= p2_color;
					end
					else
					begin
						B3_color <= default_color;
					end
					
					// C1
					if (grid_C1 == player1)
					begin
						C1_color <= p1_color;
					end
					else if (grid_C1 == player2)
					begin
						C1_color <= p2_color;
					end
					else
					begin
						C1_color <= default_color;
					end
					
					// C2
					if (grid_C2 == player1)
					begin
						C2_color <= p1_color;
					end
					else if (grid_C2 == player2)
					begin
						C2_color <= p2_color;
					end
					else
					begin
						C2_color <= default_color;
					end
					
					// C3
					if (grid_C3 == player1)
					begin
						C3_color <= p1_color;
					end
					else if (grid_C3 == player2)
					begin
						C3_color <= p2_color;
					end
					else
					begin
						C3_color <= default_color;
					end
					
				end
				
				// A1 redraw
				RE_A1_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd0;
				end
				RE_A1_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				RE_A1_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_A1_DRAW:
				begin
					color <= A1_color;
					x <= count_x;
					y <= count_y;
				end
				
				// A2 redraw
				RE_A2_START:
				begin
					count_x <= 32'd109;
					count_y <= 32'd0;
				end
				RE_A2_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd109;
				end
				RE_A2_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_A2_DRAW:
				begin
					color <= A2_color;
					x <= count_x;
					y <= count_y;
				end
				
				// A3 redraw
				RE_A3_START:
				begin
					count_x <= 32'd216;
					count_y <= 32'd0;
				end
				RE_A3_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd216;
				end
				RE_A3_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_A3_DRAW:
				begin
					color <= A3_color;
					x <= count_x;
					y <= count_y;
				end
				
				// B1 redraw
				RE_B1_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd82;
				end
				RE_B1_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				RE_B1_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_B1_DRAW:
				begin
					color <= B1_color;
					x <= count_x;
					y <= count_y;
				end
				
				// B2 redraw
				RE_B2_START:
				begin
					count_x <= 32'd109;
					count_y <= 32'd82;
				end
				RE_B2_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd109;
				end
				RE_B2_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_B2_DRAW:
				begin
					color <= B2_color;
					x <= count_x;
					y <= count_y;
				end
				
				// B3 redraw
				RE_B3_START:
				begin
					count_x <= 32'd216;
					count_y <= 32'd82;
				end
				RE_B3_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd216;
				end
				RE_B3_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_B3_DRAW:
				begin
					color <= B3_color;
					x <= count_x;
					y <= count_y;
				end
				
				// C1 redraw
				RE_C1_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd163;
				end
				RE_C1_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				RE_C1_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_C1_DRAW:
				begin
					color <= C1_color;
					x <= count_x;
					y <= count_y;
				end
				
				// C2 redraw
				RE_C2_START:
				begin
					count_x <= 32'd109;
					count_y <= 32'd163;
				end
				RE_C2_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd109;
				end
				RE_C2_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_C2_DRAW:
				begin
					color <= C2_color;
					x <= count_x;
					y <= count_y;
				end
				
				// C3 redraw
				RE_C3_START:
				begin
					count_x <= 32'd216;
					count_y <= 32'd163;
				end
				RE_C3_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd216;
				end
				RE_C3_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				RE_C3_DRAW:
				begin
					color <= C3_color;
					x <= count_x;
					y <= count_y;
				end
				
				CHECK_OUTCOME:
				begin
					
					// Horizontal A row
					if ((grid_A1 == grid_A2) && (grid_A2 == grid_A3) && (grid_A3 != 2'b00))
					begin
						if (grid_A1 == 2'b01)
							outcome <= p1_win;
						else if (grid_A1 == 2'b10)
							outcome <= p1_lose;
					end
					
					// Horizontal B row
					else if ((grid_B1 == grid_B2) && (grid_B2 == grid_B3) && (grid_B3 != 2'b00))
					begin
						if (grid_B1 == 2'b01)
							outcome <= p1_win;
						else if (grid_B1 == 2'b10)
							outcome <= p1_lose;
					end
					
					// Horizontal C row
					else if ((grid_C1 == grid_C2) && (grid_C2 == grid_C3) && (grid_C3 != 2'b00))
					begin
						if (grid_C1 == 2'b01)
							outcome <= p1_win;
						else if (grid_C1 == 2'b10)
							outcome <= p1_lose;
					end
					
					// Vertical 1 column
					else if ((grid_A1 == grid_B1) && (grid_B1 == grid_C1) && (grid_C1 != 2'b00))
					begin
						if (grid_A1 == 2'b01)
							outcome <= p1_win;
						else if (grid_A1 == 2'b10)
							outcome <= p1_lose;
					end
					
					// Vertical 2 column
					else if ((grid_A2 == grid_B2) && (grid_B2 == grid_C2) && (grid_C2 != 2'b00))
					begin
						if (grid_A2 == 2'b01)
							outcome <= p1_win;
						else if (grid_A2 == 2'b10)
							outcome <= p1_lose;
					end
					
					// Vertical 3 column
					else if ((grid_A3 == grid_B3) && (grid_B3 == grid_C3) && (grid_C3 != 2'b00))
					begin
						if (grid_A3 == 2'b01)
							outcome <= p1_win;
						else if (grid_A3 == 2'b10)
							outcome <= p1_lose;
					end
					
					// Negative slope diagonal
					else if ((grid_A1 == grid_B2) && (grid_B2 == grid_C3) && (grid_C3 != 2'b00))
					begin
						if (grid_A1 == 2'b01)
							outcome <= p1_win;
						else if (grid_A1 == 2'b10)
							outcome <= p1_lose;
					end
					
					// Positive slope diagonal
					else if ((grid_A3 == grid_B2) && (grid_B2 == grid_C1) && (grid_C1 != 2'b00))
					begin
						if (grid_A3 == 2'b01)
							outcome <= p1_win;
						else if (grid_A3 == 2'b10)
							outcome <= p1_lose;
					end
					
					// non win cases
					else if ((grid_A1[0]||grid_A1[1])&&(grid_A2[0]||grid_A2[1])&&(grid_A3[0]||grid_A3[1])&&(grid_B1[0]||grid_B1[1])&&(grid_B2[0]||grid_B2[1])&&(grid_B3[0]||grid_B3[1])&&(grid_C1[0]||grid_C1[1])&&(grid_C2[0]||grid_C2[1])&&(grid_C3[0]||grid_C3[1]))
						outcome <= tie;
					else
						outcome <= in_progress;
				
				end
				P2:
				begin
					user <= player2;
					valid <= 1'b0;
					
				end
				GET_MOVE_AI:
				begin
					p2_move <= AI_move;
					p1_move <= 9'd0;
					AI_test <= 1'b1;
				end
				GET_MOVE_P2:
				begin
					p2_move <= move;
					p1_move <= 9'd0;
					p2_test <= 1'b1;
				end
				END:
				begin
				end
				
				// display win
				WIN_START:
				begin
					count_x <= 32'd0;
					count_y <= 32'd0;
				end
				WIN_UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= 32'd0;
				end
				WIN_UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				WIN_DRAW:
				begin
					if (outcome == p1_win)
						color <= p1_color;
					else if (outcome == p1_lose)
						color <= p2_color;
					else
						color <= default_color;
						
					x <= count_x;
					y <= count_y;
				end
				
				ERROR:
				begin
				end
				default:
				begin
				end
			endcase
		end
	end
				
endmodule
