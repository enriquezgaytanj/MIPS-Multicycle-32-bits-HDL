`timescale 1ns / 1ps
// Code your design here
// Code your design here
`timescale 1ns / 1ps
module control_1 (
  input botton_State,
  input clk,
  input Reset,
  input [5:0]Opcode,
  output reg [3:0] Leds_State,
  output reg Read_reg,
  output reg IorD_Out,
  output reg AluSrcA_Out,
  output reg IRWrite_Out,
  output reg PCWrite_Out,
  output reg RegDest_Out,
  output reg RegWrite_Out,
  output reg MemtoReg_Out,
  output reg MemWrite_Out,
  output reg Branch_Out,
  output reg [1:0] AluSrcB_Out,
  output reg [1:0] ALUOp_Out,
  output reg [1:0] PCSrc_Out);
  
 
  
  parameter Fetch = 4'b0000, Decode= 4'b0001, MemAdr= 4'b0010,
  			MemRead = 4'd3, MemWriteback= 4'd4, MemWrite= 4'd5,
  			Execute = 4'd6, ALUWriteback= 4'd7, Branch= 4'd8,
  			ADDIExecute = 4'd9, ADDIWriteback= 4'd10, Jump= 4'd11, Pre_Fetch= 4'd12;
  
  reg [3:0] state, Next_state;

  
  
 always @(posedge clk)
    begin
        state <= Next_state;
        //Leds_State <= Next_state;
    end
  
    
  always @(*)
    begin
        if (Reset == 1'b1)  
            begin     
              IorD_Out = 1'b0;
              AluSrcA_Out = 1'b0;
              AluSrcB_Out = 2'b01;
              ALUOp_Out = 2'b00;
              PCSrc_Out = 2'b00;
              IRWrite_Out = 1;
              PCWrite_Out = 1;
              RegDest_Out = 0;
              MemtoReg_Out = 0;
              MemWrite_Out = 0;
              Branch_Out = 0;
              RegWrite_Out = 0;
              Read_reg = 0;
              Leds_State <= 4'b0000;    
              Next_state = Fetch;
                 
            end
         else
            begin
                case(state)
                    Pre_Fetch:
                        begin
                              IorD_Out = 1'b0;
                              AluSrcA_Out = 1'b0;
                              AluSrcB_Out = 2'b00;
                              ALUOp_Out = 2'b00;
                              PCSrc_Out = 2'b00;
                              IRWrite_Out = 0;
                              PCWrite_Out = 0;
                              RegDest_Out = 0;
                              MemtoReg_Out = 0;
                              MemWrite_Out = 0;
                              Branch_Out = 0;
                              RegWrite_Out = 0;  
                              Read_reg = 1;                            
                              Leds_State <= 4'd12;
                              if (botton_State)begin
                                Next_state = Fetch;
                              end
                              else begin
                                Next_state = Pre_Fetch;
                              end
                        end
                
                
                    default://Fetch:
                        begin
                              IorD_Out = 1'b0;
                              AluSrcA_Out = 1'b0;
                              AluSrcB_Out = 2'b01;
                              ALUOp_Out = 2'b00;
                              PCSrc_Out = 2'b00;
                              IRWrite_Out = 1;
                              PCWrite_Out = 1;
                              RegDest_Out = 0;
                              MemtoReg_Out = 0;
                              MemWrite_Out = 0;
                              Branch_Out = 0;
                              RegWrite_Out = 0; 
                              Read_reg = 0;                             
                              Leds_State <= 4'b0000;
                              Next_state = Decode;

                        end
                    Decode:
                       begin
                           	  IorD_Out = 1'b0;
                              AluSrcA_Out = 1'b0;
                              AluSrcB_Out = 2'b11;
                              ALUOp_Out = 2'b00;
                              PCSrc_Out = 2'b00;
                              IRWrite_Out = 0;
                              PCWrite_Out = 0;
                              RegDest_Out = 0;
                              MemtoReg_Out = 0;
                              MemWrite_Out = 0;
                              Branch_Out = 0; 
                              RegWrite_Out = 0;
                              Read_reg = 0;  
                              Leds_State = 4'b0001;
                              begin
                                case (Opcode)
                                      6'b100011: Next_state =MemAdr; // State Lw
                                      6'b101011: Next_state =MemAdr; // State SW
                                      
                                      6'b000000: Next_state =Execute; // State tipo-R
                                      6'b000100: Next_state =Branch; // State BEQ
                                      
                                      6'b001000: Next_state =ADDIExecute; // State ADDI
                                      
                                      6'b000010: Next_state =Jump; // State Jump 
                                      default: Next_state =Pre_Fetch; // default 
                                endcase
                              end
                        end
                  MemAdr:
                    begin
                      IorD_Out = 1'b0;
                      AluSrcA_Out = 1'b1;
                      AluSrcB_Out = 2'b10;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 0;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 0;
                      Branch_Out = 0; 
                      RegWrite_Out = 0;
                      Read_reg = 0;  
                      Leds_State <= 4'b0010;
                      begin
                       if(Opcode == 6'b100011) Next_state =MemRead;          
                       if(Opcode == 6'b101011) Next_state =MemWrite;
                      end
                    end
                    
                 MemRead:
                    begin
                      IorD_Out = 1'b1;
                      AluSrcA_Out = 1'b0;
                      AluSrcB_Out = 2'b00;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 0;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 0;
                      Branch_Out = 0;
                      RegWrite_Out = 0;
                      Read_reg = 0;  
                      Leds_State <= 4'b0011;
                      Next_state = MemWriteback;
                      
                    end
                 
                 MemWriteback:
                   begin
                      IorD_Out = 1'b0;
                      AluSrcA_Out = 1'b0;
                      AluSrcB_Out = 2'b00;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 0;
                      MemtoReg_Out = 1;
                      MemWrite_Out = 0;
                      Branch_Out = 0;
                      RegWrite_Out = 1;
                      Read_reg = 0;  
                      Leds_State <= 4'b0100;
                      Next_state <=Pre_Fetch;  
                   end
                   
                 MemWrite:
                    begin
                      IorD_Out = 1'b1;
                      AluSrcA_Out = 1'b0;
                      AluSrcB_Out = 2'b00;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 0;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 1;
                      Branch_Out = 0;
                      RegWrite_Out = 0;
                      Read_reg = 0;  
                      Leds_State <= 4'b0101;
                      Next_state <=Pre_Fetch;

                    end
                 Execute:
                    begin
                      IorD_Out = 1'b0;
                      AluSrcA_Out = 1'b1;
                      AluSrcB_Out = 2'b00;
                      ALUOp_Out = 2'b10;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 0;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 0;
                      Branch_Out = 0;
                      RegWrite_Out = 0;
                      Read_reg = 0;  
                      Leds_State <= 4'b0110;
                      Next_state <=ALUWriteback; 

                     end
                 ALUWriteback:
                    begin
                      IorD_Out = 1'b0;
                      AluSrcA_Out = 1'b0;
                      AluSrcB_Out = 2'b00;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 1;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 0;
                      Branch_Out = 0;
                      RegWrite_Out = 1;
                      Read_reg = 0;  
                      Leds_State <= 4'b0111;
                      Next_state <=Pre_Fetch;
                     
                   end
                 Branch:
                     begin
                          IorD_Out = 1'b0;
                          AluSrcA_Out = 1'b1;
                          AluSrcB_Out = 2'b00;
                          ALUOp_Out = 2'b01;
                          PCSrc_Out = 2'b01;
                          IRWrite_Out = 0;
                          PCWrite_Out = 0;
                          RegDest_Out = 0;
                          MemtoReg_Out = 0;
                          MemWrite_Out = 0;
                          Branch_Out = 1;
                          RegWrite_Out = 0;
                          Read_reg = 0;  
                          Leds_State <= 4'b1000;
                          Next_state <=Pre_Fetch;  
                     end
                     
                 ADDIExecute:
                    begin
                      IorD_Out = 1'b0;
                      AluSrcA_Out = 1'b1;
                      AluSrcB_Out = 2'b10;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 0;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 0;
                      Branch_Out = 0;
                      RegWrite_Out = 0;
                      Read_reg = 0;  
                      Leds_State <= 4'b1001; 
                      Next_state <=ADDIWriteback;                     
                    end
                    
                 ADDIWriteback:
                    begin
                      IorD_Out = 1'b0;
                      AluSrcA_Out = 1'b0;
                      AluSrcB_Out = 2'b00;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b00;
                      IRWrite_Out = 0;
                      PCWrite_Out = 0;
                      RegDest_Out = 0;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 0;
                      Branch_Out = 0;
                      RegWrite_Out = 1;
                      Read_reg = 0;  
                      Leds_State <= 4'b1010; 
                      Next_state <=Pre_Fetch;
                    end
                    
                 Jump:
                    begin
                      IorD_Out = 1'b0;
                      AluSrcA_Out = 1'b0;
                      AluSrcB_Out = 2'b00;
                      ALUOp_Out = 2'b00;
                      PCSrc_Out = 2'b10;
                      IRWrite_Out = 0;
                      PCWrite_Out = 1;
                      RegDest_Out = 0;
                      MemtoReg_Out = 0;
                      MemWrite_Out = 0;
                      Branch_Out = 0;
                      RegWrite_Out = 0;
                      Read_reg = 0;  
                      Next_state <=Pre_Fetch;
                      Leds_State <= 4'b1011; 
                    end
 
                endcase
            end //
          
        end // if 

    
 endmodule   
    

//endmodule

