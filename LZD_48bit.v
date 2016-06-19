`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:22:01 06/14/2016 
// Design Name: 
// Module Name:    LZD_48bit 
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
module LZD_48bit(in, out, valid
    );
input [47:0]in;
output reg [5:0]out;
output reg valid;
wire v1,v2;
wire [4:0]l1;
wire [3:0]l2;
initial 
	begin
		
		out<=5'b00000;
		valid<=0;
	end

LZD_32bit d9( .in(in[31:0]), .out(l1), .valid(v1));			//instantiation of 16bit and 32bit Leading zero detectors
LZD_16bit d10( .in(in[47:32]), .out(l2), .valid(v2));

always@(in,v1,v2,l1,l2)
	begin
		if(v2==0&&v1==1)
			begin
				if(in>65535)			// logic condition for accuracy when in lies in this set(2^32, 2^16] 
				begin
				out<={{1'b0},{~v2},{l1[3:0]}};
				end
				else						// when in lies in this set (2^16,0)
				begin
				out<={{~v2},{1'b0},{l1[3:0]}}  ;
				end
				/*
				IF CONDITION WHEN IN<32767
				
				in[47:0] = 0000_0000_0000_0000___0100_1001_0000_0000_____0000_0000_1100_1001
				v2=0, v1=1, l2= 0000, l1=00001
				out= 010001
				
				in[47:0] = 0000_0000_0000_0000___0000_0000_0100_1001_____0000_0000_1100_1001
				v2=0, v1=1, l2= 0000, l1=01001
				out = 011001= 25 
				
				ELSE CONDITION
				
				in[47:0] = 0000_0000_0000_0000___0000_0000_0000_0000_____0100_0000_1100_1001
				v2=0, v1=1, l2=0, l1=10001
				out= 33= 100001
				
				in[47:0] = 0000_0000_0000_0000___0000_0000_0000_0000_____0000_0100_1100_1001
				v2=0, v1=1, l2=0, l1=10101
				out= 37 = 100101

				*/
			end
		else if( v2==0&&v1==0) 		// condition when both v2 and v1 are zero => in==0
			begin
				out<=0;
			end
		else 
			begin
				out<={{1'b0},{{~v2},{l2}}};		// when v2==1 irrespective of v1 out={{~v2},{l2}};
			end
		
		valid<= v1|v2 ; 
	
	end



endmodule
