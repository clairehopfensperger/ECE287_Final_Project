module four_val_display (
input [1:0]user,
output [6:0]seg7_lsb,
output [6:0]seg7_msb,
output [6:0]seg7_hund,
output [6:0]seg7_thous
);

reg [3:0] result_one_digit;
reg [3:0] result_ten_digit;
reg [3:0]result_hundreds_digit;
reg [3:0]result_thousands_digit;
	  

always @(*)
begin
	
	result_one_digit = {2'd0, user};
	result_ten_digit = 4'hF;
	result_hundreds_digit = 4'hE;
	result_thousands_digit = 4'hE;
	  
end

/* instantiate the modules for each of the seven seg decoders */
seven_segment ones_place(result_one_digit, seg7_lsb);
seven_segment tens_place(result_ten_digit, seg7_msb);
seven_segment hundreds_place(result_hundreds_digit, seg7_hund);
seven_segment thousands_place(result_thousands_digit, seg7_thous);

endmodule
