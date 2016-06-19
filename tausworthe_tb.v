`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:39:05 06/14/2016 
// Design Name: 
// Module Name:    tausworthe_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tausworthe_tb();
reg [31:0]urng_seed1,urng_seed2,urng_seed3;
reg clk, reset;
wire [31:0]out;
wire valid;

parameter n=256;
integer tw_text;

tausworthe t1( .urng_seed1(urng_seed1), .urng_seed2(urng_seed2), .urng_seed3(urng_seed3), .clk(clk), .reset(reset), .out(out), .valid(valid) );  
	
	initial
		begin
			clk=0;
			reset=1;
			urng_seed1=0;
			urng_seed2=0;
			urng_seed3=0;			
		end
	initial
		begin
			tw_text=$fopen("tausworthe_result.txt", "w");
			urng_seed1= 'hfff00000;
			urng_seed2= 'hff11118f;
			urng_seed3= 'hf111abe0;
			reset=1'b0;
			repeat(n)
				begin
				#5
					urng_seed1= urng_seed1+'ha10;
					urng_seed2= urng_seed2+'h00f;
					urng_seed3= urng_seed3+'h08c;
					$fwrite( tw_text, "reset-%b \t urng_seed1- %h \t,urng_seed2- %h\t, urng_seed3- %h \t and\t output is %h \t, valid-%b\n\n",reset,urng_seed1,urng_seed2,urng_seed3, out, valid);
				end
			$fclose(tw_text);
		end
	always
		begin
		#5
		clk<=~clk;
		end
	always
		begin
		#25
		reset<=~reset;
		end
endmodule
