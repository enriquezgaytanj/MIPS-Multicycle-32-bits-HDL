`timescale 1ns / 1ps
module mux5 (
  input sel,
  input  [4:0] a,
  input  [4:0] b, 
  output logic [4:0] y
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