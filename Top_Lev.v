//////////////////////////////////////////////////////////////////////////////////
// Company: University Of New Hampshire
// Engineer: Frederick Yaw Adom
// 
// Create Date: 03/30/2023 01:57:00 PM
// Design Name: Parking Lot System Design
// Module Name: Subsystem for the lot
// Project Name: Parking System
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
//////// The code for the parking lot goes here ///////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////



//Behavioural Description
//Module Instantiation

module Top_Lev( clk,
                reset,
                Ent_Sens,
                Exit_Sens,
                Tick_1,
                paid_stat,   
                Red_State,
                Green_State,
                Sev_indicator                
                );

// Input to the system
input clk;
input reset;
input Ent_Sens;
input Exit_Sens;
input Tick_1;
input paid_stat;

// Output of the system
output Red_State;
output Green_State;
output Sev_indicator;


// Data type declarations
wire clk;
wire reset;
wire Ent_Sens;
wire Exit_Sens;
wire Tick_1;
wire paid_stat;
wire Red_State;
wire Green_State;
wire [3:0] Sev_indicator;


//Instantiate all the modules
//Parking lot system
Park mod1(      .clk(clk),
                .reset(reset),
                .Ent_Sens(Ent_Sens),
                .Exit_Sens(Exit_Sens),
                .Tick_1(Tick_1),
                .paid_stat(paid_stat),
                .Red_State(Red_State), //LEDs
                .Green_State(Green_State), //LEDs
                .Sev_indicator(Sev_indicator)

);






endmodule