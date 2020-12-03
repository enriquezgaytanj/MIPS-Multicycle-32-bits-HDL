`timescale 1ns / 1ps
module Register_22(In_A, In_B,clk,Out_A,Out_B);
  input[31:0] In_A, In_B; //  input A B
	input clk; // clock input 
    output reg [31:0] Out_A,Out_B ; // output A B

  	always @(posedge clk) 
		begin
 			Out_A <= In_A;
          	Out_B <= In_B; 
		end 
endmodule