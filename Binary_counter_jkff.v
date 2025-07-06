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

input clk, reset,j1, j2, j3, j4, k1, k2, k3, k4 ;
output a, b, c, d,q1, q1_bar, q2, q2_bar, q3, q3_bar, q4, q4_bar ;

wire a, b, c, d;

wire j1, j2, j3, j4, k1, k2, k3, k4;
wire q1, q1_bar, q2, q2_bar, q3, q3_bar, q4, q4_bar;

// create inputs for the FFs
assign j1 = q4 & q3_bar;
assign j2 = q1_bar | k1;
assign j3 = q4_bar;
assign j4 = q3_bar;


assign k1 = q3 & q4_bar;

assign k2 = q4;

assign k3 = q1_bar & (q4_bar | q2_bar | q3_bar);

assign k4 = q1;

// Create 4 flip flops and assign input and output variables
// Flip flop 1
jkff ff1 (
	.clk (clk),
	.preset (0),
	.clear (reset),
	.j (j1),
	.k (k1),
        
	.q (q1),
	.q_bar (q1_bar)
);

// Flip flop 2
jkff ff2 (
	.clk (clk),
	.preset (0),
	.clear (reset),
	.j (j2),
	
	.k (k2),
	.q (q2),
	.q_bar (q2_bar)
);

// Flip flop 3
jkff ff3 (
	.clk (clk),
	.preset (reset),
	.clear (0),
	.j (j3),
	
	.k (k3),
	.q (q3),
	.q_bar (q3_bar)
);

// Flip flop 4
jkff ff4 (
	.clk (clk),
	.preset (reset),
	.clear (0),
	.j (j4),
	
	.k (k4),
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
	$monitor ("%b%b%b%b", a, b, c, d );
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

