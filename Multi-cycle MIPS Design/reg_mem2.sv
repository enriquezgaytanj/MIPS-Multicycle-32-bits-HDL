// Code your design here
`timescale 1ns / 1ps
module Registers_bank(En_preFetch, Addr_preFetch,  clk, we_im, rs_im, rt_im, rd_im, rd1_im, rd2_im,wd, Reg_preFetch);
  input En_preFetch;
  input [31:0] Addr_preFetch;
  input logic   	 clk;   	 // clock
  input logic   	 we_im;   	 // wr_ena inst_mem
  input logic   	 [4:0] rs_im, rt_im, rd_im;  // reg: rs,rt,rd
  output logic       [31:0] rd1_im, rd2_im; // read dat1,dat2
  input logic   	 [31:0] wd;   	 // wr_data
  output reg [31:0] Reg_preFetch;


  reg [31:0] rege [31:0];
  reg [31:0] Reg_preFetch_Reg;
    initial
    begin
      $readmemh("reg.mem", rege); 
    end
    
   always @(posedge clk)
     begin
       if (we_im)
         begin
         rege[rd_im] <= wd;
         $writememh("reg.mem", rege);
         end

      end


  assign Reg_preFetch_Reg = (En_preFetch !=0) ? rege[Addr_preFetch]: 32'd0;
  assign Reg_preFetch = (En_preFetch !=0) ? Reg_preFetch_Reg[3:0]: 4'd0;
 
  assign rd1_im = (rs_im != 0) ? rege[rs_im] : 32'd0;
  assign rd2_im = (rt_im != 0) ? rege[rt_im] : 32'd0;
  
  
  
endmodule