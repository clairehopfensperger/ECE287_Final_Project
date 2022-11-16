// instantiated VGA module to try to make a rectangle, instead it made a diagonal line lol

// top level module for project

module Tic_Tac_Toe(
	input clk, 
	input rst,
	//input [2:0]color,
	//input [8:0]x,
	//input [7:0]y,
	//input plot,
	output [9:0]VGA_R,
	output [9:0]VGA_G,
	output [9:0]VGA_B,
	output VGA_HS,
	output VGA_VS,
	output VGA_BLANK,
	output VGA_SYNC,
	output VGA_CLK);

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

	reg [2:0]color;
	reg [8:0]x;
	reg [7:0]y;
	reg plot = 1'b1; 
	
	vga_adapter my_vga(rst, clk, color, x, y, plot, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	
	reg [4:0]S;
	reg [4:0]NS;
	
	// currently makes diagonal line lol
	
	parameter START = 5'd0,
				 DRAW = 5'd1,
				 UPDATE = 5'd2,
				 //UPDATE_X = 5'd2,
				 //UPDATE_Y = 5'd3,
				 DONE = 5'd4,
				 ERROR = 5'hF;
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			S <= START;
		end
		else
			S <= NS;
	end
	
	reg [31:0]count_x;
	reg [31:0]count_y;
	reg [31:0]width;
	reg [31:0]height;
	reg [31:0]init_x = 32'd100;
	reg [31:0]init_y = 32'd100;
	reg done;
	
	always @(*) // i have a picture of the code that is for rectangles
	begin
		case(S) 
			START: NS = DRAW;
			DRAW: NS = UPDATE;
			UPDATE:
			begin
				if (done == 1'b0)
					NS = DRAW;
				else
					NS = DONE;
			end
			DONE: NS = DONE;
			default: NS = ERROR;
		endcase
	end
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			count_x <= 32'd0;
			count_y <= 32'd0;
			color <= 3'hF;
			x <= 9'd0;
			y <= 8'd0;
		end
		else
		begin
			case(S)
				START:
				begin
					done <= 1'b0;
					count_x <= init_x;
					count_y <= init_y;
					width <= 32'd100;
					height <= 32'd100;
				end
				DRAW:
				begin
					x <= count_x;
					y <= count_y;
				end
				UPDATE:
				begin
					if (count_x < (init_x + width))
						count_x <= count_x + 32'd1;
					else
						count_x <= init_x;
						if (count_y < (init_y + height))
							count_y <= count_y + 32'd1;
						else
							count_y <= init_y;
				end
				DONE:
				begin
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
