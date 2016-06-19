`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:18:06 06/19/2016 
// Design Name: 
// Module Name:    logarithmic 
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


module logarithmic( u0,e);
input [47:0]u0;
output reg signed [30:0]e;
wire valid;
wire [5:0] ex;
reg [5:0] exp_e;
reg  [47:0] xe;
reg [47:0]  y_e, ln2;
reg [53:0] e1;
reg [7:0]address;
reg [69:0]temp1;
reg [108:0] temp2;

LZD_48bit lzd1( .in(u0), .out(ex), .valid(valid));

reg [29:0] c0[255:0];
reg [21:0] c1[255:0];
reg [12:0] c2[255:0];


initial 
		begin
		
		xe=0;
		y_e=0;
		e1=0;
		address=0;
		e=0;
		exp_e=0;
           $readmemh("c0_log.txt", c0);
			  //c0 is 30 bits c0[29] is sign, c0[28]-integer value, c0[27:0]-fraction value 
           $readmemh("c1_log.txt", c1);
           $readmemh("c2_log.txt", c2);
      end

always @(u0,ex)
begin
		
//address bits to select coefficients
address=u0[47:40];
//range reduction
// exp_e=LZD(u0)+1
exp_e=ex+1;
//left shift u0 by exp_e
xe= (u0<<exp_e);
//temp1 width = xe-48bits+c1-22=[69:0]
//temp1 will be signed and a fraction value
temp1=xe*c1[address]; 
//temp2 width = xe:48bits+48bits+c2:13=[108:0]
//temp2 is signed and contains fraction value
temp2=(c2[address]*xe)*xe;
//we only add MSB ignoring any LSB if necessary inorder to get fraction length and integer correctly 
y_e=temp1+temp2+c0[address];
//ln2= 0.69314718056;
ln2='h10237AA968;
//width of e1= 48+6  
  
e1=ln2*exp_e; 
//approximation of e 
e=(e1-y_e)<<1;

end
endmodule
