`timescale 1ns / 1ps
module shift_2_to_left_32 (
  input [31:0] in_sign,
  output reg [31:0] out_sign);

  always @(in_sign)
  begin
// shift left by 2
     out_sign = {in_sign[29:0], 2'b00};
  end	

endmodule