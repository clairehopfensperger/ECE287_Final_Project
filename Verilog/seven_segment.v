module seven_segment (
input [3:0]i,
output reg [6:0]o
);


// HEX out - rewire DE2
//  ---a---
// |       |
// f       b
// |       |
//  ---g---
// |       |
// e       c
// |       |
//  ---d---

always @(*)
begin
	case (i)	    // abcdefg

		4'h0: o = 7'b0000001;
		4'h1: o = 7'b1001111;
		4'h2: o = 7'b0010010;
//		4'h3: o = 7'b0000110;
//		4'h4: o = 7'b1001100;
//		4'h5: o = 7'b0100100;
//		4'h6: o = 7'b0100000;
//		4'h7: o = 7'b0001111;
//		4'h8: o = 7'b0000000;
//		4'h9: o = 7'b0000100;
//		4'hA: o = 7'b0001000;
//		4'hB: o = 7'b1100000;
//		4'hC: o = 7'b0110001;
//		4'hD: o = 7'b1000010;
//		4'hE: o = 7'b0110000;
//		4'hF: o = 7'b0111000;
		
		4'hE: o = 7'b1111111; // blank display
		4'hF: o = 7'b0011000; // P
		
		default: o = 7'b1111111;
	
	endcase
end

endmodule
