`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2020 10:22:24 AM
// Design Name: 
// Module Name: Pre_Fectch_Control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Pre_Fectch_Control(
    input En,
    input Reg_Data,
    input [14:0] Switch, // Adr Instr/Data Memory
    input [31:0] Data_In, Reg_In,
    output reg Data_En, Reg_En, //  RD [31:0]
    output  [31:0] Switch_out,
    output reg[3:0] Sev_Seg_1, Sev_Seg_2
    );
    
    always @(*)
        begin
            if (En) begin
                if (Reg_Data)
                    begin
                        Reg_En =1'b1;
                        Data_En = 1'b0;
                    end
                else
                    begin
                        Reg_En =1'b0;
                        Data_En =1'b1;
                    end
                 
            end
          end
          
    assign Switch_out = {17'd0 ,Switch};
    
    
    always @(Data_In or Reg_In)
        begin
            if (Reg_Data)
               begin
                 Sev_Seg_1 = Reg_In[3:0];
                 Sev_Seg_2 = Reg_In[7:4];
               end
            else
            begin
                Sev_Seg_1 = Data_In[3:0];
                Sev_Seg_2 = Data_In[7:4];
            end
        end
        
        
        
        
endmodule
