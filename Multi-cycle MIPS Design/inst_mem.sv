module Instruction_memory#(parameter word_size = 31,
parameter Addreess_size = 127)(
  input En_read,
  input [31:0] Addr_preFetch,
  input clk,
  input [word_size:0] a,
  input MemWrite,
  input [word_size:0]Write_data,
  output reg [word_size:0] rd,
  output reg [31:0] Data_preFetch
  );
  
reg [31:0] Data_preFetch_Reg;

 
logic [word_size:0] RAM[Addreess_size:0];
 
initial
 
 $readmemh("memfile.mem", RAM);
 
  always @(posedge clk)
    begin
      if  (MemWrite) RAM[a] <=  Write_data; // word aligned
    end
 
      always @(*)
        begin
        rd = RAM[a]; // word aligned
    	end
    	
  assign Data_preFetch_Reg = (En_read !=0) ? RAM[Addr_preFetch]: 32'd0;
  assign Data_preFetch = (En_read !=0) ? Data_preFetch_Reg[3:0]: 4'd0;   	
  
endmodule


