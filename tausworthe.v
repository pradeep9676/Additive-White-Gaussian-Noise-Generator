`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:43:39 06/14/2016 
// Design Name: 
// Module Name:    tausworthe 
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
module tausworthe( urng_seed1, urng_seed2, urng_seed3, clk, reset, out, valid
    );

input  [31:0]urng_seed1;
input  [31:0]urng_seed2;
input  [31:0]urng_seed3;
input clk, reset;
output reg [31:0]out;
output reg valid;
reg [31:0]b1,b2,b3,seed1,seed2, seed3, seed4;

initial 
	begin
		out=0;
		valid=0;
		seed1=0;
		seed2=0;
		seed3=0;
		seed4=0;
		b1=0;
		b2=0;
		b3=0;
	end
	
/* asynchronous reset
	always @(posedge reset)  // reset works irrespective of clock pulse.
		begin
			out<=0;
			valid<=0;
		end
*/
always @(posedge clk, reset, urng_seed1,urng_seed2,urng_seed3)
	begin
		if(reset)  // synchronous reset. Reset works only on positive clock pulse.
			begin	
				out=0;
				valid=0;
				
			end
		else
			begin				// tausworthe logic 
					b1=(((urng_seed1<<13)^urng_seed1)>>19);
					seed1= (((urng_seed1&'hFFFFFFFE)<<12)^b1);
					b1=(((urng_seed2<<2)^urng_seed2)>>25);
					seed2=(((urng_seed2&'hFFFFFFF8)<<4)^b1);
					b1=(((urng_seed3<<3)^urng_seed3)>>11);
					seed3=(((urng_seed3&'hFFFFFFF0)<<17)^b1);
				
					seed4=seed1^seed2;
					out=seed4^seed3;
					
					valid=1;
			end
	end
endmodule
