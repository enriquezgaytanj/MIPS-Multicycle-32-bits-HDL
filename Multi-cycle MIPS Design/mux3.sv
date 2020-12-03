`timescale 1ns / 1ps
module mux3(
  input [1:0]sel,
  input  [31:0] a,
  input  [31:0] b, 
  input  [31:0] c, 
  output logic [31:0] y
);
  
always @(*)
  begin
    case(sel)
      2'b00 : y = a;
      2'b01 : y = b;
      2'b10 : y = c;
      default : y = 0;
    endcase
  end   
endmodule