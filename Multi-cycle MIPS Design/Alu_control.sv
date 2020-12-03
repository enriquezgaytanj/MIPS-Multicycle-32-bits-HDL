`timescale 1ns / 1ps
module alu_decoder(
  input  [5:0] funct,
  input  [1:0] aluop,
  output reg [2:0] alucontrol
);

always @(*)
  begin
    case (aluop) 
      2'b00:alucontrol <= 3'b010; 
      2'b01:alucontrol <= 3'b110;
      2'b10:
        begin
          case(funct) // R-type instructions
                6'b100000: alucontrol <= 3'b010; // add
                6'b100010: alucontrol <= 3'b110; // sub
                6'b100100: alucontrol <= 3'b000; // and
                6'b100101: alucontrol <= 3'b001; // or
                6'b101010: alucontrol <= 3'b111; // slt
                6'b000111: alucontrol <= 3'b101; // SRAV
                default: alucontrol <= 3'bxxx; // ???
          endcase
        end
      default:alucontrol = 3'bxxx;
    endcase
  end
  
endmodule
