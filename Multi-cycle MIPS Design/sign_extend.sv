`timescale 1ns / 1ps
module sign_extend(
  input [15:0] imm,
  output[31:0] signout
    );

  //assign signout = imm[15]? {16'hFFFF,imm}: {16'b0,imm};
  assign  signout = 32'(signed'(imm));
  endmodule