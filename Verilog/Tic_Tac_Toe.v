// top level module for project

module Tic_Tac_Toe(
	input clk, 
	input rst,
	output [9:0]VGA_R,
	output [9:0]VGA_G,
	output [9:0]VGA_B,
	output VGA_HS,
	output VGA_VS,
	output VGA_BLANK,
	output VGA_SYNC,
	output VGA_CLK
	);

	display my_dis(clk, rst, 3'b010, 3'b000, 3'b000, 3'b000, 3'b101, 3'b000, 3'b000, 3'b000, 3'b000, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	

endmodule
