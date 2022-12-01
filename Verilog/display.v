module display(
	input clk, 
	input rst,
	input [2:0]A1_color,
	input [2:0]A2_color,
	input [2:0]A3_color,
	input [2:0]B1_color,
	input [2:0]B2_color,
	input [2:0]B3_color,
	input [2:0]C1_color,
	input [2:0]C2_color,
	input [2:0]C3_color,
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
	reg [2:0]color;
	reg back_color = 3'b000;
	
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
	
	reg [6:0]S;
	reg [6:0]NS;
	
	parameter 
	
	// background
	BACK_START = 7'd0,
	BACK_CHECK_Y = 7'd1,
	BACK_CHECK_X = 7'd2,
	BACK_UPDATE_Y = 7'd3,
	BACK_UPDATE_X = 7'd4,
	BACK_DRAW = 7'd5,
	BACK_END = 7'd6,
	
	// A1
	A1_START = 7'd7,
	A1_CHECK_Y = 7'd8,
	A1_CHECK_X = 7'd9,
	A1_UPDATE_Y = 7'd10,
	A1_UPDATE_X = 7'd11,
	A1_DRAW = 7'd12,
	A1_END = 7'd13,
	
	// A2
	A2_START = 7'd14,
	A2_CHECK_Y = 7'd15,
	A2_CHECK_X = 7'd16,
	A2_UPDATE_Y = 7'd17,
	A2_UPDATE_X = 7'd18,
	A2_DRAW = 7'd19,
	A2_END = 7'd20,
	
	// A3
	A3_START = 7'd21,
	A3_CHECK_Y = 7'd22,
	A3_CHECK_X = 7'd23,
	A3_UPDATE_Y = 7'd24,
	A3_UPDATE_X = 7'd25,
	A3_DRAW = 7'd26,
	A3_END = 7'd27,
	
	// B1
	B1_START = 7'd28,
	B1_CHECK_Y = 7'd29,
	B1_CHECK_X = 7'd30,
	B1_UPDATE_Y = 7'd31,
	B1_UPDATE_X = 7'd32,
	B1_DRAW = 7'd33,
	B1_END = 7'd34,
	
	// B2
	B2_START = 7'd35,
	B2_CHECK_Y = 7'd36,
	B2_CHECK_X = 7'd37,
	B2_UPDATE_Y = 7'd38,
	B2_UPDATE_X = 7'd39,
	B2_DRAW = 7'd40,
	B2_END = 7'd41,
	
	// B3
	B3_START = 7'd42,
	B3_CHECK_Y = 7'd43,
	B3_CHECK_X = 7'd44,
	B3_UPDATE_Y = 7'd45,
	B3_UPDATE_X = 7'd46,
	B3_DRAW = 7'd47,
	B3_END = 7'd48,
	
	// C1
	C1_START = 7'd49,
	C1_CHECK_Y = 7'd50,
	C1_CHECK_X = 7'd51,
	C1_UPDATE_Y = 7'd52,
	C1_UPDATE_X = 7'd53,
	C1_DRAW = 7'd54,
	C1_END = 7'd55,
	
	// C2
	C2_START = 7'd56,
	C2_CHECK_Y = 7'd57,
	C2_CHECK_X = 7'd58,
	C2_UPDATE_Y = 7'd59,
	C2_UPDATE_X = 7'd60,
	C2_DRAW = 7'd61,
	C2_END = 7'd62,
	
	// C3
	C3_START = 7'd63,
	C3_CHECK_Y = 7'd64,
	C3_CHECK_X = 7'd65,
	C3_UPDATE_Y = 7'd66,
	C3_UPDATE_X = 7'd67,
	C3_DRAW = 7'd68,
	C3_END = 7'd69,
	
	ERROR = 7'hF;
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			S <= BACK_START;
		end
		else
			S <= NS;
	end
	
	reg [31:0]count_x;
	reg [31:0]count_y;
	
	// state transitions
	always @(*)
	begin
		case(S) 
			// background
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
			C3_END: NS = C3_END;
			
			default: NS = ERROR;
			
		endcase
	end
	
	// what occurs in each state
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			count_x <= 32'd0;
			count_y <= 32'd0;
			x <= 9'd0;
			y <= 8'd0;
			color <= 3'b111;
		end
		else
		begin
			case(S)
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
				
				default:
				begin
				end
			endcase
		end
	end
	
endmodule
