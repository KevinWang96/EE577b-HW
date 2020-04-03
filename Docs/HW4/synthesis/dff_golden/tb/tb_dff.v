// TestBench to test adder1bit.v module

`timescale 1ns/1ps
module tb;
	wire q;
	reg d, clk;
	dff dffu1 (clk, d, q);
	
	always #5 clk = ~clk;
	initial
	begin
		$monitor ("Time = %g	d=%b, q=%b", $time, d, q);
		clk = 0;
		d = 0;
		#6;
		d = 1;
		#3; 
		d = 0;
		#14;
		d = 1;
		#14;
		d = 0;
		#18;
		d = 1;
		#6;
		d = 0;
		$finish;
	end
endmodule //tb

		
		
