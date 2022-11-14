// register module to be instatiated.
// will be used to hold user(s) moves in grid sqaures.

module register(
input clk, 
input rst, 
input [7:0]in, 
input en, 
output reg [7:0]out);

always @(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		out <= 8'd0;
	end
	else if (en == 1'b1)
	begin
		out <= in;
	end
end

endmodule
