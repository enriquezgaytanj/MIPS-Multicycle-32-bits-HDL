`timescale 1ns / 1ps
module  ALU (
  input  [31:0]    data_s, //rs
  input  [31:0]    data_t, //rt
  input  [2:0]  AluControl,    
  output reg [31:0] Out_alu,
  output reg Zero
    );
 
 
 
always_comb
    begin
   	 case ( AluControl )	 
      	3'b000 : Out_alu = (data_s & data_t); // and aluControl 000   
      	3'b001 : Out_alu = (data_s | data_t); // or aluControl 000   
        3'b010 : Out_alu = (data_s + data_t);  // add aluControl 010
        3'b110 : Out_alu = (data_s - data_t); // sub aluControl 110
      	3'b111 : Out_alu = (data_s < data_t) ? 32'b1 : 32'b0; //SLT //$s < $t  
       3'b101 : Out_alu = signed'(data_t) >>> data_s; //data_t[31]? {'hFFFF,data_s[4:0]: {22'b0,data_s[4:0]};//
   	 default : Out_alu = 32'bx;
    endcase
      
     if (Out_alu == 32'b0) Zero = 1'b1;
     else Zero = 1'b0; 
    end
 
endmodule
        