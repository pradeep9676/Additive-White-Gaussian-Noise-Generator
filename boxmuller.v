`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:31:05 06/19/2016 
// Design Name: 
// Module Name:    boxmuller 
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
module boxmuller( clk,reset, urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6, x0,x1,v);
input clk;
input reset;
input[31:0] urng_seed1,urng_seed2,urng_seed3,urng_seed4,urng_seed5,urng_seed6;


wire [31:0] a,b;
wire v1,v2;
output reg v;

output reg signed [15:0] x0,x1;
//logarithmic values
reg [47:0]u0;
wire signed [30:0]e;
//square-root values
wire signed [16:0] f; 
//sin cos values
reg [15:0] u1;
wire signed [15:0] g0;
wire signed  [15:0] g1;

tausworthe t1( .urng_seed1(urng_seed1), .urng_seed2(urng_seed2), .urng_seed3(urng_seed3), .clk(clk), .reset(reset), .out(a), .valid(v1)    );

tausworthe t2( .urng_seed1(urng_seed4), .urng_seed2(urng_seed5), .urng_seed3(urng_seed6), .clk(clk), .reset(reset), .out(b), .valid(v2)    );

logarithmic l1( .u0(u0),.e(e));

sqrt  s1( .e(e) , .f(f));

sincos c1(.u1(u1), .g0(g0),.g1(g1));

initial 

begin
		x0=0;
		x1=0;
		v=0;
end

always@(posedge clk)
begin
	if(reset==1)
		begin
		x0=0;
		x1=0;
		v=0;
		end
	else
		begin
		u0={a,b[31:16]};
		u1=b[15:0];
		x0=f*g0;
		x1=f*g1;
		v=v1|v2;
		end
end


endmodule
