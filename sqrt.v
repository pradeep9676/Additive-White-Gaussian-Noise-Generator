`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:20 06/19/2016 
// Design Name: 
// Module Name:    sqrt 
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
module sqrt(e , f);
// input from logarithmic block
    input [30:0] e;
//output f
    output reg signed [16:0] f; 
	 reg [4:0] exp_f;
//output from leading zero detector
	  wire [4:0] lzd; 
	wire valid;
//instantiation of leading zero detector
	 LZD_32bit l(.in({1'b0,e}),.out(lzd),.valid(valid)); 
// declaration of all registers
     reg  [4:0] exp_f1;
     reg  [30:0] x_f1,x_f;
     reg  [30:0] y_f;
     reg  [5:0] address;
     reg  [63:0] temp1;
// memory allocation
	reg [31:0] c0[63:0];
   reg [31:0] c1[63:0]; 
	
   reg [31:0] c2[63:0];
   reg [31:0] c3[63:0];
   
initial 
		begin
//memory allocation and loading of square root coefficients
        $readmemh("c0_sqrt.txt",c0); 
        $readmemh("c1_sqrt.txt", c1);
        $readmemh("c2_sqrt.txt", c2);
        $readmemh("c3_sqrt.txt", c3);
//set initial values to zero  
  exp_f=0;
		x_f1=0;
		x_f=0;
		y_f=0;
		exp_f1=0;
		end  
// e and lzd are in sensitive list for this always block	
always @(e,lzd)
	begin
// range reduction
		  exp_f= 5- lzd;
		  x_f1= e>>exp_f;	
		//coefficient address is obtained from 6 bits from MSB side of input e
        address=e[30:25]; 
		  // if exp_f[0]= 1 then coefficients are taken accordingly and y_f is calculated
		  //when exp_f[0]=1 then coefficients from c0 and c1 are used 
		  //when exp_f[0]=0 then coefficients from c2 and c3 are used
 // approximation
			if (exp_f[0])
					 begin
                    x_f= x_f1>>1;  
                    temp1= c1[address]*x_f1;       
                    y_f =temp1+ c0[address];                          
                 end
         else 
					begin
                   x_f=x_f1;
                   temp1= c3[address]*x_f1;       
                   y_f =temp1+ c2[address];                          

               end
// range reconstruction
			  if (exp_f[0])
					begin
               exp_f1= (exp_f+1)>>1;              
               end
           else 
					begin
               exp_f1= (exp_f)>>1;  
               end
       // output f
			f= y_f<<exp_f1;
      
	end
endmodule