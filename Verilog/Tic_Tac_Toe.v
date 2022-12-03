// top level module for project

module Tic_Tac_Toe(
	input clk, 
	input rst,
	
	input mode, // player v player, player v AI
	//input level, // level of difficulty of AI
	//input [1:0]player,
	input [3:0]move, //9 grid squares
	input check,
	input start,
	output wire valid,
	output wire [2:0]outcome, //in_progress, win, lose, tie
	
	// VGA outputs
	output [9:0]VGA_R,
	output [9:0]VGA_G,
	output [9:0]VGA_B,
	output VGA_HS,
	output VGA_VS,
	output VGA_BLANK,
	output VGA_SYNC,
	output VGA_CLK
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
	parameter A1 = 4'd1,
				 A2 = 4'd2,
				 A3 = 4'd3,
				 B1 = 4'd4,
				 B2 = 4'd5,
				 B3 = 4'd6,
				 C1 = 4'd7,
				 C2 = 4'd8,
				 C3 = 4'd9;
				 
	// player
	parameter P1 = 2'b01,
				 P2 = 2'b10;
	
//	// different color options for grid squares
//	parameter
//	P1_color = 3'b010,
//	P2_color = 3'b101,
//	default_color = 3'b111;
	
//	// registers holding colors for each of grid squares
//	reg [2:0] A1_color = P1_color;
//	reg [2:0] A2_color = default_color;
//	reg [2:0] A3_color = default_color;
//	reg [2:0] B1_color = default_color;
//	reg [2:0] B2_color = P2_color;
//	reg [2:0] B3_color = default_color;
//	reg [2:0] C1_color = default_color;
//	reg [2:0] C2_color = default_color;
//	reg [2:0] C3_color = default_color;

	// instantiating modules
	// wire valid;
	// wire [2:0]outcome;
	wire [1:0]grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3;
	wire [2:0]A1_color, A2_color, A3_color, B1_color, B2_color, B3_color, C1_color, C2_color, C3_color;
	wire [1:0]user;
	
	game_logic my_logic(clk, rst, move, start, check, valid, outcome, clear, user, A1_color, A2_color, A3_color, B1_color, B2_color, B3_color, C1_color, C2_color, C3_color);
	
	grid my_grid(clk, rst, clear, user, move, grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3, valid);
	
	outcome my_outcome(grid_A1, grid_A2, grid_A3, grid_B1, grid_B2, grid_B3, grid_C1, grid_C2, grid_C3, outcome);
	
	display my_dis(clk, rst, A1_color, A2_color, A3_color, B1_color, B2_color, B3_color, C1_color, C2_color, C3_color, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	

endmodule
