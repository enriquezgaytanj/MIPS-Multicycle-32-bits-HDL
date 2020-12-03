`timescale 1ns / 1ps

module Top_Module (clk_100Mhz, pushbotton, botton_Reg,switchs, rst,out_G, Led_out,
                    an, seg, dp);
  input clk_100Mhz, rst, pushbotton,botton_Reg;
  input [15:0] switchs;
  //output reg [15:0] leds;
  output reg [11:0] out_G;
  output reg [3:0] Led_out;
  output reg [7:0]an;
  output reg [6:0]seg;
  output dp;
  
  wire clk;
  wire [3:0] Leds_State;
  wire [31:0] in_pc_w1, out_pc_w2, adr_w3,RD_w4, Instruction_w5, Data_w6, WD3_w8, RD1_w9, RD2_w10,SignImm_w11,A_w12,B_w13,SrcA_w14,SignImm_ext_w15,SrcB_w16,ALU_Result_w17,ALU_out_w19;
  wire ZERO_w18;
  wire [27:0] shift_out_w20;
  wire [4:0] A3_w7;
  wire [1:0] AluSrcB_cw, ALUOp_cw,PCSrc_cw;
  wire IorD_cw, AluSrcA_cw, IRWrite_cw, PCWrite_cw, RegDest_cw, RegWrite_cw, MemtoReg_cw,  MemWrite_cw, Branch_cw;
  wire [2:0] alucontrol_cw;
  
  wire signal_debounced_State, signal_debounced_Reg;
  
  wire Read_reg_w, Data_En_w, Reg_En_w;
  wire [31:0] Data_In_w,Reg_In_w, Switch_out_w;
  wire [3:0] Sev_Seg_1_w, Sev_Seg_2_w;
  
  Pre_Fectch_Control Pre_Fectch (Read_reg_w, switchs[15], switchs[14:0], Data_In_w,Reg_In_w,
                                 Data_En_w, Reg_En_w, Switch_out_w, Sev_Seg_1_w, Sev_Seg_2_w );
                                 
   Registers_bank Mem_reg(Reg_En_w, Switch_out_w, clk, RegWrite_cw,
   Instruction_w5[25:21],Instruction_w5[20:16],A3_w7,RD1_w9,RD2_w10,WD3_w8, Reg_In_w);
   
   Instruction_memory I_D_memory(Data_En_w, Switch_out_w, clk,adr_w3,MemWrite_cw,B_w13,RD_w4,
                                  Data_In_w);                             
                                 

  PC p_counter(clk,rst,((ZERO_w18 &  Branch_cw)|(PCWrite_cw)),in_pc_w1,out_pc_w2);
  	mux32 mux_PC(IorD_cw,out_pc_w2,ALU_out_w19,adr_w3);
	



 Debouncer Debouncer_botton_State(rst, pushbotton, clk_100Mhz, signal_debounced_State );
// Debouncer Debouncer_botton_Reg(rst, botton_Reg, clk_100Mhz, signal_debounced_Reg );
  
  digital_clock_top clk_module(clk_100Mhz ,clk);
  
  Register register_rd(RD_w4,clk,Data_w6);//
 
  Register_EN register_rd_en (RD_w4,clk,IRWrite_cw,Instruction_w5);//  
  mux5 mux_intruc_20_11(RegDest_cw,Instruction_w5[20:16],Instruction_w5[15:11],A3_w7); 
  mux32 mux_WD3(MemtoReg_cw,ALU_out_w19,Data_w6,WD3_w8); //
  
  
  sign_extend s_ext(Instruction_w5[15:0],SignImm_w11);
  Register_22 Reg_22(RD1_w9,RD2_w10,clk,A_w12,B_w13);
  mux32 mux_A(AluSrcA_cw,out_pc_w2,A_w12,SrcA_w14);
  shift_2_to_left_32 shift_32(SignImm_w11,SignImm_ext_w15);
  mux4 mux_B(AluSrcB_cw,B_w13,SignImm_w11,SignImm_ext_w15,SrcB_w16);
  ALU ALU(SrcA_w14,SrcB_w16,alucontrol_cw,ALU_Result_w17,ZERO_w18);
  Register reg_ALU(ALU_Result_w17,clk,ALU_out_w19);
  shift_2_to_left_26 shif26(Instruction_w5[25:0],shift_out_w20);
  mux3 mux_final(PCSrc_cw,ALU_Result_w17,ALU_out_w19,{out_pc_w2[31:28],shift_out_w20},in_pc_w1);
  
  control_1 CRTL(signal_debounced_State,clk,rst,Instruction_w5[31:26], Leds_State, Read_reg_w ,IorD_cw, AluSrcA_cw, IRWrite_cw, PCWrite_cw, RegDest_cw, RegWrite_cw, MemtoReg_cw,  MemWrite_cw, Branch_cw,AluSrcB_cw, ALUOp_cw,PCSrc_cw);
  
  alu_decoder ALU_control(Instruction_w5[5:0],ALUOp_cw,alucontrol_cw);
  
  DigitToSeg sev_seg( 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, Sev_Seg_2_w,Sev_Seg_1_w
                      ,clk_100Mhz, an, dp, seg);
  
  assign out_G = ALU_out_w19[11:0];
  assign Led_out=Leds_State;
  endmodule