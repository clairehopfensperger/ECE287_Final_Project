// rectangle module to draw rectangles with VGA

module rectangle(
	input [31:0]init_x,
	input [31:0]init_y,
	input [31:0]width,
	input [31:0]height,
	input [2:0]color,
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
	
	vga_adapter my_vga(rst, clk, color, x, y, plot, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
	
	reg plot = 1'b1; 
	reg [31:0]x;
	reg [31:0]y;
	
	reg [4:0]S;
	reg [4:0]NS;
	
	parameter START = 5'd0,
				 CHECK_Y = 5'd1,
				 CHECK_X = 5'd2,
				 UPDATE_Y = 5'd3,
				 UPDATE_X = 5'd4,
				 DRAW = 5'd5,
				 END = 5'd6,
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
	
	always @(*)
	begin
		case(S) 
			START: NS = CHECK_Y;
			CHECK_Y: 
			begin
				if (count_y < init_y + height)
				begin
					NS = CHECK_X;
				end
				else
				begin
					NS = END;
				end
			end
			CHECK_X:
			begin
				if (count_x < init_x + width)
				begin
					NS = DRAW;
				end
				else
				begin
					NS = UPDATE_Y;
				end
			end
			UPDATE_Y: NS = CHECK_Y;
			UPDATE_X: NS = CHECK_X;
			DRAW: NS = UPDATE_X;
			END: NS = END;
			default: NS = ERROR;
		endcase
	end
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			count_x <= 32'd0;
			count_y <= 32'd0;
			x <= 9'd0;
			y <= 8'd0;
		end
		else
		begin
			case(S)
				START:
				begin
					count_x <= init_x;
					count_y <= init_y;
				end
				UPDATE_Y:
				begin
					count_y <= count_y + 32'd1;
					count_x <= init_x;
				end
				UPDATE_X:
				begin
					count_x <= count_x + 32'd1;
				end
				DRAW:
				begin
					x <= count_x;
					y <= count_y;
				end
				default:
				begin
				end
			endcase
		end
	end

endmodule
