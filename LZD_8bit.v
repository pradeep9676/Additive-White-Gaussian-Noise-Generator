`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:44:46 06/13/2016 
// Design Name: 
// Module Name:    LZD_8bit 
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
module LZD_8bit( in, out, valid
    );
input [7:0]in;
output reg [2:0]out;
output reg valid;
wire v1,v2;
wire [1:0]l1, l2;
initial 
	begin
		out<=3'b000;
		valid<=0;
	end

LZD_4bit d3( .in(in[3:0]), .out(l1), .valid(v1));
LZD_4bit d4( .in(in[7:4]), .out(l2), .valid(v2));

always@(in,v1,v2,l1,l2)
	begin
		if(v2==0&&v1==1)
			begin
				out<={{~v2},{l1}}  ;
			end
			/*
			even this one works same as 4bit LZD
			here l1, l2 are  2 bits each and v1,v2 are 1bit 
			when v2=0 
				v2 is 0 => l2= 2'b00
				in that case we see for v1 
				if v1=0 => l1= 2'b00
				we get out=4'b0000, valid=0
				if v1=1 => l1= xx
				we take ~v2 in 2^2 position and l1 in 2^1,2^0 position to get no of leading zero terms
				eg- 00001000
				v2=0,l2=2'b00, v1=1, l1=2'b00
				out= {{1},{00}}= {100}=4 there are 4 leading zeros
			*/
		else if( v2==0&&v1==0)
			begin
				out<=0;
			end
		else
			begin
				out<={{~v2},{l2}};
			end
			/*eg- 00100000
				v2=1,l2=2'b10, v1=0, l1=2'b00
				out= {{0},{10}}= {010}=2 there are 2 leading zeros in 00100000
			*/
		valid<= v1|v2 ; // valid = in[7]|in[6]|in[5]|in[4]|in[3]|in[2]|in[1]|in[0]
	
	end


endmodule
