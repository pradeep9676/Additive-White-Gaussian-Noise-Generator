`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:38:56 06/14/2016 
// Design Name: 
// Module Name:    LZD_16bit 
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
module LZD_16bit( in, out, valid
    );
input [15:0]in;
output reg [3:0]out;
output reg valid;
wire v1,v2;
wire [2:0]l1, l2;
initial 
	begin
		out<=4'b0000;
		valid<=0;
	end

LZD_8bit d5( .in(in[7:0]), .out(l1), .valid(v1));
LZD_8bit d6( .in(in[15:8]), .out(l2), .valid(v2));

always@(in,v1,v2,l1,l2)
	begin
		if(v2==0&&v1==1)
			begin
				out<={{~v2},{l1}}  ;
			end
			/*
			here l1, l2 are  3 bits each and v1,v2 are 1bit 
			when v2=0 
				
				eg- 0000_0000_0010_0100
				v2=0,l2=3'b000, v1=1, l1=3'b010
				out= {{1},{010}}= {1010}=10 there are 10 leading zeros in 0000_0000_0010_0100
			*/
		else if( v2==0&&v1==0)
			begin
				out<=0;
			end
		else
			begin
				out<={{~v2},{l2}};
			end
			/*eg- 0000_0100_0010_0100
				v2=0,l2=3'b101, v1=1, l1=3'b010
				out= {{1},{101}}= {0101}=5 there are 5 leading zeros in 0000_0100_0010_0100
			*/
		valid<= v1|v2 ; /* valid = in[15]|in[14]|in[13]|in[12]|in[11]|in[10]|in[9]|in[8]
	|in[7]|in[6]|in[5]|in[4]|in[3]|in[2]|in[1]|in[0]*/
	
	end



endmodule
