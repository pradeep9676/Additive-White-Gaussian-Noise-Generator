`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:50 06/19/2016 
// Design Name: 
// Module Name:    boxmuller_tb 
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
module boxmuller_tb();

reg [47:0] u0_m[9999:0];
reg [15:0] u1_m[9999:0];
reg [47:0] u0;
reg [15:0] u1;
reg clk, reset;
wire [15:0]x0,x1;
reg [15:0]x0_m[9999:0];
reg [15:0]x1_m[9999:0];

parameter n=256;
integer A,i;

BM_dut bm_12( .clk(clk), .reset(reset),.u0(u0),.u1(u1),.x0(x0),.x1(x1));
initial
begin
clk=0;
reset=0;
$readmemh("taus_u0.txt",u0_m); 
$readmemh("taus_u1.txt", u1_m);
$readmemb("x0_bm.txt",x0_m); 
$readmemb("x1_bm.txt", x1_m);
end
initial
				begin

					A=$fopen("BM_tb_result.txt", "w");

						for (i=0;i<10000;i=i+1)
							begin
									#2
									u0<=u0_m[i];
									u1<=u1_m[i];
									#1
								if(x0==x0_m[i]&&x1==x1_m[i])
									begin
									$fwrite( A, "x0: %b and x0_m:%b; ,x1: %b and x1_m: %b are equal \n",x0,x0_m[i],x1,x1_m[i]);
									end
								else
									begin
									$fwrite( A, "x0: %b and x0_m:%b; ,x1: %b and x1_m:%b are not equal \n",x0,x0_m[i],x1,x1_m[i]);
									end
							end
					$fclose(A);
				end

always
		begin
		#5
		clk<=~clk;
		end
		
endmodule
