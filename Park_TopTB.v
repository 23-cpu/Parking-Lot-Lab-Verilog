`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of New Hampshire
// Engineer: Frederick Yaw Adom
// 
// Create Date: 02/26/2023 01:57:00 PM
// Design Name: Even-Odd Up/Down Counter
// Module Name: This is a self checking test bench for the behavioural simulation of the design
// Project Name: Even_Odd Up/Down Counter
// Target Devices: Nexys Atix 7 FPGA Board
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



///////////////////////////////////////////////////////////////////////////////////////
////////Self-checking Test Bench for the Even-odd Up/Down Counter//////////////////////
/////////////////////////////////////////////////////////////////////////////////////

module Park_TopTB();

reg  clk,
     reset,
     Ent_Sens,
     Exit_Sens,
     Tick_1,
     paid_stat;
     
wire Red_State;
wire Green_State;
wire[3:0] Sev_indicator;


//Intantiating design under test(DUT)

            Top_Lev DUT(    .clk(clk),    
                             .reset(reset), 
                             .Ent_Sens(Ent_Sens), 
                             .Exit_Sens(Exit_Sens) , 
                             .Tick_1(Tick_1) , 
                             .paid_stat(paid_stat), 
                             .Red_State(Red_State), 
                             .Green_State(Green_State),
                             .Sev_indicator(Sev_indicator)
                                 
                              );
                              
                              
initial 
     begin 
        clk = 1'b0;
     end 

always
    begin 
        #10 clk = ~clk;
    end 
    
initial
 begin
         // Initialize Inputs

 reset  = 0;
 Ent_Sens = 0;
 Exit_Sens = 0;
 Tick_1 = 0;
 paid_stat = 0;
 // Wait 100 ns for global reset to finish
 #100;

   reset = 1;
 #20;
 
   Ent_Sens = 1; 
 #20
   Tick_1 = 1;
 #500
   paid_stat = 0;
 #1000;
   
 
 


  end

        endmodule
