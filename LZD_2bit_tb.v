`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:59:30 06/14/2016 
// Design Name: 
// Module Name:    LZD_2bit_tb 
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

// Testbench for all Leading zero detectors

module LZD_2bit_tb;
	 
	 reg [1:0]in;
	 wire valid;
	 wire out;
	 parameter n=4;    // parameter for convenience of code utilization
	 integer i;
	 
	 LZD_2bit  tb1( .in(in), .out(out), .valid(valid));
	 
	 initial 
		begin
			for( i=0; i<n; i=i+1)
				#10  assign in= {i}; // loop is used to assign values to input
						
		end


endmodule


module LZD_4bit_tb;
	 
	 reg [3:0]in;
	 wire valid;
	 wire [1:0]out;
	 parameter n=16;      // parameter declaration for convenience of code reutilization
	 integer i;					// integer for "for loop"
	 
	 LZD_4bit  tb2( .in(in), .out(out), .valid(valid)); // instantiation
	 
	 initial 
		begin
			for( i=0; i<n; i=i+1)
				#10  assign in= {i};			// loop to assign values
						
		end


endmodule

// LZD_8bit testbench


module LZD_8bit_tb;
	 
	 reg [7:0]in;
	 wire valid;
	 wire [2:0]out;
	 parameter n=256;
	 integer i,j;
	 
	 LZD_8bit  tb3( .in(in), .out(out), .valid(valid));
	 
	 initial 
		begin
		assign j=1;
			for( i=0; i<n; i=i+j)
				begin
				#5  assign in= {i};
				j=j*2;
				end
		end


endmodule

module LZD_16bit_tb;
	 
	 reg [15:0]in;
	 wire valid;
	 wire [3:0]out;
	 parameter n=65536;
	 integer i,j;
	 
	 LZD_16bit  tb4( .in(in), .out(out), .valid(valid));
	 
	 initial 
		begin
		assign j=1;
			for( i=0; i<n; i=i+j)
				begin
				#1  assign in= {i};
				assign j=j*2;
				end
		end


endmodule


module LZD_32bit_tb;
	 
	 reg [31:0]in;
	 wire valid;
	 wire [4:0]out;
	 parameter n=65536;
	 integer i,j;
	 
	 LZD_32bit  tb5( .in(in), .out(out), .valid(valid));
	 
	 initial 
		begin
		assign j=1;
			for( i=0; i<n; i=i+j)
				begin
				#1  assign in= {i};
				assign j=j*2;
				end
		end


endmodule



module LZD_48bit_tb;
	 
	 reg [47:0]in;
	 wire valid;
	 wire [5:0]out;
	 parameter n=65536;
	 integer i;
	 
	 LZD_48bit  tb6( .in(in), .out(out), .valid(valid));
	 
	 initial 
		begin
			for( i=1; i<n; i=i*2)				// loop for complete test coverage of 48bit LZD
				begin
				#5  in[47:0]<= {{i[15:0]},{i[31:0]}};		
				//				#5  in[47:0]<= {{i[31:0]},{i[15:0]}};
				//	#5  in[47:0]<= {{16'b0},{i[31:0]}};
				

				end
		end


endmodule
