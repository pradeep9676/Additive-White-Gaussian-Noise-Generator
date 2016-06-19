`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:18:47 06/14/2016 
// Design Name: 
// Module Name:    LZD_32bit 
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
module LZD_32bit( in, out, valid
    );
input [31:0]in;
output reg [4:0]out;
output reg valid;
wire v1,v2;
wire [3:0]l1, l2;
initial 
	begin
		out<=5'b00000;
		valid<=0;
	end

LZD_16bit d7( .in(in[15:0]), .out(l1), .valid(v1));
LZD_16bit d8( .in(in[31:16]), .out(l2), .valid(v2));

always@(in,v1,v2,l1,l2)
	begin
		if(v2==0&&v1==1)
			begin
				out<={{~v2},{l1}}  ;
			end
		else if( v2==0&&v1==0)
			begin
				out<=0;
			end
		else
			begin
				out<={{~v2},{l2}};
			end
			
		valid<= v1|v2 ; 
	
	end



endmodule

