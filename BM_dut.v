`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:58 06/19/2016 
// Design Name: 
// Module Name:    BM_dut 
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
module BM_dut( clk, reset,u0,u1,x0,x1
    );

input [47:0] u0;
input [15:0] u1;
input clk,reset;

output reg signed [15:0] x0,x1;
//logarithmic values
wire signed [30:0]e;
//square-root values
wire signed [16:0] f; 
//sin cos values
wire signed [15:0] g0;
wire signed  [15:0] g1;


logarithmic l2( .u0(u0),.e(e));

sqrt  s2( .e(e) , .f(f));

sincos c2(.u1(u1), .g0(g0),.g1(g1));

initial 

begin
		x0=0;
		x1=0;
end

always@(posedge clk)
begin
	if(reset==1)
		begin
		x0=0;
		x1=0;
		end
	else
		begin
		x0=f*g0;
		x1=f*g1;
		
		end
end

endmodule
