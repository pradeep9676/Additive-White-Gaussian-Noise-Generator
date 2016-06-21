`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:40 06/19/2016 
// Design Name: 
// Module Name:    sincos 
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
module sincos(u1, g0,g1
    );
//input u1
  input [15:0] u1;
//output declaration
  output  reg signed [15:0] g0;
  output  reg signed  [15:0] g1;
//finding quadrant 
  reg [1:0] quad;   
//x_g_a and x_g_b are  values for cos(x_g_a*pi*u1), sin(x_g_b*pi*u1) 
  reg [13:0] x_g_a;
  reg [13:0] x_g_b;   
//address of coefficients  
  reg [6:0] address; 
//sin and cos values before determining quadrants
  reg [15:0] y_g_a;
  reg [15:0] y_g_b;
// temporary values
  reg [33:0] temp1;
  reg [33:0] temp2;  
//memory allocation for coefficients c0 and c1  
  reg [18:0] c0[127:0];
  reg [18:0] c1[127:0];  
//allocating memory to c0and c1
initial 
		begin
           $readmemh("c0_sincos.txt", c0);
           $readmemh("c1_sincos.txt", c1);
      end	
	
//approximation of sin and cos values
always@(u1 ) //u1 is in sensitive list when ever there is change in u1 this block executes
	 begin
		  quad=u1[15:14];
        x_g_a=u1[13:0];  
        x_g_b=(1-2^-14)- u1[13:0]; 
        address=u1[15:8]; 
        temp1=c1[address]*x_g_a;
        temp2=c1[address]*x_g_b;
        y_g_a=temp1+ c0[address]; 
        y_g_b=temp2+ c0[address]; 
        //reconstruction 
		case(quad)
        0: 
				begin
				g0= y_g_b;
				g1= y_g_a;
				end
        1: 
				begin
				g0= y_g_a;
				g1= -y_g_b;
				end
		  2: 
				begin
				g0= -y_g_b;
				g1= -y_g_a;
				end
        3: 
				begin
				g0= -y_g_a;
				g1= y_g_b;
				end
		  endcase;        
    end //always block end
	 
endmodule
