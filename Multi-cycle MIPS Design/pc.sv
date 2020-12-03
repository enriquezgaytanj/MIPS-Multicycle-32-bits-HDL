// Program counter module
`timescale 1ns / 1ps
module PC (
   input   clk,
   input   rst,
   input   write,
   input  [31:0] in_pc,
   output reg [31:0] out_pc
);

always @(posedge clk or posedge rst)
  begin
    if (rst)  
   		 out_pc <= 0;
    else if (write)
   		 out_pc <= in_pc;
  end	 
endmodule
