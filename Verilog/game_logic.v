// Edit 11/14/22 Claire Hopfensperger

// This module implements the FSM that works the turn system

module game_logic(
	input clk, rst,
	input [3:0]move, //9 grid squares
	input start,
	input check,
	input valid,
	input [2:0]outcome,
	output reg clear,
	output reg [1:0]user,
	output reg [2:0] A1_color, 
	output reg [2:0] A2_color,
	output reg [2:0] A3_color,
	output reg [2:0] B1_color, 
	output reg [2:0] B2_color,
	output reg [2:0] B3_color, 
	output reg [2:0] C1_color, 
	output reg [2:0] C2_color, 
	output reg [2:0] C3_color
	);
	
	//reg [1:0]turn;
	parameter in_progress = 2'd0,
				 p1_win = 2'd1,
				 p1_lose = 2'd2,
				 tie = 2'd3;
	parameter
				 P1_color = 3'b010,
	          P2_color = 3'b101,
	          default_color = 3'b111;
				 
	parameter A1 = 4'd1,
				 A2 = 4'd2,
				 A3 = 4'd3,
				 B1 = 4'd4,
				 B2 = 4'd5,
				 B3 = 4'd6,
				 C1 = 4'd7,
				 C2 = 4'd8,
				 C3 = 4'd9;
	
	reg [3:0]S;
	reg [3:0]NS;
	
	parameter START = 4'd0,
				 P1 = 4'd1,
				 UPDATE1 = 4'd2,
				 SET1 = 4'd8,
				 CHECK1 = 4'd3,
				 P2 = 4'd4,
				 UPDATE2 = 4'd5,
				 SET2 = 4'd9,
				 CHECK2 = 4'd6,
				 END = 4'd7,
				 ERROR = 4'hF;
				 
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
			START: begin 
				if (start == 1'b0) NS = START;
				else NS = P1; end
			P1: begin
				if (check == 1'b1) NS = UPDATE1;
				else NS = P1; end
			UPDATE1: begin 
				if (valid == 1'b1) NS = SET1;
				else NS = P1; end
			SET1: NS = CHECK1;
			CHECK1: begin
				if (outcome == in_progress) NS = P2;
				else NS = END; end
			P2: begin 
				if (check == 1'b1) NS = UPDATE2;
				else NS = P2; end
			UPDATE2: begin 
				if (valid == 1'b1) NS = SET2;
				else NS = P2; end
			SET2: NS = CHECK2;
			CHECK2: begin
				if (outcome == in_progress) NS = P1;
				else NS = END; end
			END: NS = END;
			default: NS = ERROR;
		endcase
	end
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			//clear <= 1'b1; // might not need 
			A1_color <= default_color;
			A2_color <= default_color;
			A3_color <= default_color;
			B1_color <= default_color;
			B2_color <= default_color;
			B3_color <= default_color;
			C1_color <= default_color;
			C2_color <= default_color;
			C3_color <= default_color;
		end
		else
		begin
		case(S)
			START: 
			begin 
				A1_color <= default_color;
				A2_color <= default_color;
				A3_color <= default_color;
				B1_color <= default_color;
				B2_color <= default_color;
				B3_color <= default_color;
				C1_color <= default_color;
				C2_color <= default_color;
				C3_color <= default_color; 
			end
			P1: user <= 2'b01;
			SET1: 
			begin
				if (move == A1)
					A1_color <= P1_color;
				if (move == A2)
					A2_color <= P1_color;
				if (move == A3)
					A3_color <= P1_color;
				if (move == B1)
					B1_color <= P1_color;
				if (move == B2)
					B2_color <= P1_color;
				if (move == B3)
					B3_color <= P1_color;
				if (move == C1)
					C1_color <= P1_color;
				if (move == C2)
					C2_color <= P1_color;
				if (move == C3)
					C3_color <= P1_color;
			end
			P2: user <= 2'b10;
			SET2: 
			begin
				if (move == A1)
					A1_color <= P2_color;
				if (move == A2)
					A2_color <= P2_color;
				if (move == A3)
					A3_color <= P2_color;
				if (move == B1)
					B1_color <= P2_color;
				if (move == B2)
					B2_color <= P2_color;
				if (move == B3)
					B3_color <= P2_color;
				if (move == C1)
					C1_color <= P2_color;
				if (move == C2)
					C2_color <= P2_color;
				if (move == C3)
					C3_color <= P2_color;
			end
		endcase
		end
	end

endmodule
