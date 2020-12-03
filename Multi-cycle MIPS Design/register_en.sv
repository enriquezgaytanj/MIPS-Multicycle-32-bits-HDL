`timescale 1ns / 1ps
module Register_EN(D,clk,En, Q);
  	input[31:0] D; // Data input 
	input clk; // clock input 
  	input En;
  	output reg[31:0] Q; // output Q 

  always @(posedge clk ) 
		begin
          if (En) Q <= D; 
		end 
endmodule