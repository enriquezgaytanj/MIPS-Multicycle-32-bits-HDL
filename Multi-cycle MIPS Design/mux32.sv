`timescale 1ns / 1ps
module mux32(
  input sel,
  input  [31:0] a,
  input  [31:0] b, 
  output logic [31:0] y
);
  
always @(*)
  begin
    case(sel)
      1'b0 : y = a;
      1'b1 : y = b;
      default : y = 0;
    endcase
  end   
endmodule