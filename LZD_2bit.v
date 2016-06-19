`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:07 06/13/2016 
// Design Name: 
// Module Name:    LZD_2bit 
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
module LZD_2bit( in, out, valid
    );
input [1:0] in;
output reg out;
output reg valid;

initial 
	begin
		out<=0; /* set initial values to zero*/
		valid<=0;
	end
always @(in)  // logic is run when ever there is change in input
	begin
		out<= ~in[1]&in[0];	// output equation for 2 input	
		/* 
		truth table 
		in[0] in[1]  out  valid
		0			0		0		0
		0			1		1		1
		1			0		0		1
		1			1		0		1
		*/
		valid<=in[1]|in[0];
	end
endmodule
