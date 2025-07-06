//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
// JK Flip flop module
// This module is not required for this program
// It is provided here only for your reference. You can use this for the lab assignment question
module jkff ( j, k, clk, preset, clear, q, q_bar );

input j, k, clk, preset, clear;
output q, q_bar;

reg q, q_bar;

always @ (posedge clk or preset or clear )
begin

	if ( clear == 1 ) begin
		q <= 1'b0;
		q_bar <= 1'b1;
	end else if ( preset == 1 ) begin
		q <= 1'b1;
		q_bar <= 1'b0;
	end else if ( j == 1 && k == 0 ) begin
		q <= 1'b1;
		q_bar <= 1'b0;
	end else if ( j == 0 && k == 1 ) begin
		q <= 1'b0;
		q_bar <= 1'b1;
	end else if ( j == 1 && k == 1 ) begin
		q <= q_bar;
		q_bar <= q;
	end else if ( j == 0 && k == 0 ) begin
		q <= q;
		q_bar <= q_bar;
	end

end

endmodule
//////////////////////////////////////////////////////////
// END OF JK Flip Flop module
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
// D Flip flop module
// This module is used in this program
module dff ( d, clk, preset, clear, q, q_bar );

input d, clk, preset, clear;
output q, q_bar;

reg q, q_bar;

always @ (posedge clk or preset or clear )
begin

	if ( clear == 1 ) begin
		q <= 1'b0;
		q_bar <= 1'b1;
	end else if ( preset == 1 ) begin
		q <= 1'b1;
		q_bar <= 1'b0;
	end else if ( d == 1 ) begin
		q <= 1'b1;
		q_bar <= 1'b0;
	end else if ( d == 0 ) begin
		q <= 1'b0;
		q_bar <= 1'b1;
	end

end

endmodule
//////////////////////////////////////////////////////////
// END OF D Flip Flop module
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
// BINARY COUNTER module
// This is the module which combines all the 4 FFs to 
// create the binary counter circuit
// IMPORATANT NOTE: This module initializes the FFs to the
// state 1100
module binary_counter ( clk, reset, a, b, c, d );

input clk, reset;
output a, b, c, d;

wire a, b, c, d;

wire d1, d2, d3, d4;
wire q1, q1_bar, q2, q2_bar, q3, q3_bar, q4, q4_bar;

// create inputs for the FFs
assign d1 = 1 ^ q1;
assign d2 = q1 ^ q2;
assign d3 = (q1 & q2) ^ q3;
assign d4 = (q1 & q2 & q3) ^ q4;

// Create 4 flip flops and assign input and output variables
// Flip flop 1
dff ff1 (
	.clk (clk),
	.preset (0),
	.clear (reset),
	.d (d1),
	.q (q1),
	.q_bar (q1_bar)
);

// Flip flop 2
dff ff2 (
	.clk (clk),
	.preset (0),
	.clear (reset),
	.d (d2),
	.q (q2),
	.q_bar (q2_bar)
);

// Flip flop 3
dff ff3 (
	.clk (clk),
	.preset (reset),
	.clear (0),
	.d (d3),
	.q (q3),
	.q_bar (q3_bar)
);

// Flip flop 4
dff ff4 (
	.clk (clk),
	.preset (reset),
	.clear (0),
	.d (d4),
	.q (q4),
	.q_bar (q4_bar)
);

// read the outputs
assign a = q1;
assign b = q2;
assign c = q3;
assign d = q4;

endmodule
//////////////////////////////////////////////////////////
// END OF BINARY COUNTER module
//////////////////////////////////////////////////////////

///////////////////////////////////////////
///////////////////////////////////////////
// TEST BENCH
///////////////////////////////////////////
///////////////////////////////////////////

module binary_counter_tb;

reg clock, reset;
wire a, b, c, d;

binary_counter counter1 (
	.clk (clock),
	.reset (reset),
	.a (a),
	.b (b),
	.c (c),
	.d (d)
);

initial begin
	$monitor ("%b%b%b%b", d, c, b, a );
	clock = 0;
	reset = 1;

	#1 reset = 0;
	//#120 reset = 1;
	//#10 reset = 0;

	#500 $finish; 
end

always begin
 #10 clock = !clock;
end

endmodule

