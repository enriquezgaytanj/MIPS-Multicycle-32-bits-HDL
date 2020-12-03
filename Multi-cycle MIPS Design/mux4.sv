`timescale 1ns / 1ps
module mux4#(parameter word_size = 31)(
  input  [1:0] sel,
  input  [word_size:0] a,
  input  [word_size:0] c, 
  input  [word_size:0] d, 
  output logic [word_size:0] y
);

  
always @(*)
  begin
    case(sel)
      2'b00 : y = a;
      2'b01 : y = 32'd4;
      2'b10 : y = c;
      2'b11 : y = d;
      default : y = 0;
    endcase
  end   
endmodule