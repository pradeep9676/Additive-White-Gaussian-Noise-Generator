`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:15:57 06/13/2016 
// Design Name: 
// Module Name:    LZD_4bit 
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
module LZD_4bit( in, out, valid
    );
input [3:0]in;
output reg [1:0]out;
output reg valid;
wire v1,v2, l1, l2;		// wire is used to pass data
initial 
	begin				// initializing values to zero
		out<=2'b00;
		valid<=0;
	end

LZD_2bit d1( .in(in[1:0]), .out(l1), .valid(v1));		// instantiating LDZ_2bit
LZD_2bit d2( .in(in[3:2]), .out(l2), .valid(v2));

always@(in,v1,v2,l1,l2) // logic is carried out when ever change in input, v1,v2,l1,l2 occurs
	begin
		if(v2==0&& v1==1) 
			begin
				out<={{~v2},{l1}}  ;
			end
			/* condition 	
				when v2=0 
				v2 is 0 => l2= 0
				in that case we see for v1 
				if v1=0 => l1= 0
				we get out=0, valid=0
				if v1=1 => l1= x
				we take ~v2 in 2^1 position and l1 in 2^0 position to get no of leading zero terms
				eg- 0011 we should get 2 as output
				here v2= 0, l2=0, v1=1, l1=0
				out= {{~(0),{0}}
				out= {1,0}= 2'b10= 2 in decimal
				there are 2 leading zeros in 0011
		*/
		else if( v2==0&&v1==0)
			begin
				out<=0;
			end
		else	
			begin
				out<={{~v2},{l2}};
			end
			/*if v2=1 we dont consider values from v1 so we take 
			~v2 in 2^1 position and l2 in 2^0 position
			so that we get accurate no of leading zero's
			
			eg- 0101 we should get 1 as output
			here v2=1, l2= 1, v1=1, l1=1
			out={~{1},{1}}= {0,1}=2'b01= 1
			there is one leading zero in 0101
			*/
		valid<= v1|v2;   //  valid= in[3]|in[2]|in[1]|in[0]
	
	end
endmodule
