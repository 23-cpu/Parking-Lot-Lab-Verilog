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


module Park (clk,
                reset,
                Ent_Sens,
                Exit_Sens,
                paid_stat, 
                Tick_1,
                Red_State,
                Green_State,
                Sev_indicator
                );

// Input to the system
input clk;
input reset;
input Ent_Sens;
input Exit_Sens;
input paid_stat;
input Tick_1;

//Output to the system 

output Red_State;
output Green_State;
output Sev_indicator;

//  Data type declaration 
wire clk;
wire reset;
wire Ent_Sens;
wire Exit_Sens;
wire paid_stat;
wire Tick_1;
wire Red_State; // To show red when there are no spots available
wire Green_State; // To show green when the costumer has paid  and exit door becomes open
reg [3:0] Sev_indicator; // To hold the seven segment display


// The current state and the next states
reg [2:0] current_state;
reg [2:0] next_state;

reg red_tempo,green_tempo;
reg [19 : 0] count_spots;

parameter IDLE_STATE =  4'b000,
          AVAIL_STATE = 4'b001,
          OCCUPIED_STATE = 4'b010,
          TAKE_TICKET = 4'b011,
          PARK_STATE = 4'b100,
          PAY_STATE = 4'b101,
          EXIT_STATE = 4'b110;

parameter available_spots = 3'd5;
          
// State memory must reset upon the reset assertion
// Asyncronous reset

always@(posedge(clk) or negedge(reset))
    begin
        if(~reset)
            begin
              current_state <= IDLE_STATE;
            end
        else
            begin
                current_state <= next_state;
            end
    end

//Block to increment and decrement the number of cars in the system
always @(posedge clk or negedge reset) 
   begin
 if(~reset) 
       count_spots <= available_spots;
  else if(current_state == PARK_STATE)
       count_spots <= available_spots + 1;
  else if(current_state == EXIT_STATE)
       count_spots <= available_spots -1;
  else
       count_spots <= available_spots;
  
 end
 
 
//System control logic (Next State Combinational logic)

always@(*)
 begin
    case(current_state)
        IDLE_STATE : begin
                        if(Ent_Sens == 1'b1)
                            next_state = AVAIL_STATE;
                        else
                            next_state = IDLE_STATE;
                     end
                     
                     
         AVAIL_STATE : begin
                        if(available_spots > 5'd0 && available_spots <= 5'd5)
                            next_state = TAKE_TICKET; // Wait to take ticket        
                        else 
                            next_state = OCCUPIED_STATE; // Else go into the occupied state
                                    
                      end
                      
                      
        OCCUPIED_STATE : begin
                         if(available_spots == 5'd0)
                            next_state = OCCUPIED_STATE; // Go to occupied state
                         else
                            next_state = TAKE_TICKET;
                         end
                 
        TAKE_TICKET   :  begin
                         if(Tick_1 == 1'b1)
                            next_state = PARK_STATE; //proceed to the park state
                         else 
                            next_state = TAKE_TICKET;   
                       end
                      
 
        PARK_STATE : begin 
                         if(Exit_Sens == 1'b1)
                            next_state = PAY_STATE;   
                             else begin
                                 next_state = PARK_STATE;
                             end
                      end     
                      
         PAY_STATE : begin 
                          if(paid_stat == 1'b1)
                                next_state = EXIT_STATE;
                            else begin
                                next_state = PAY_STATE;
                            end       
                           end
         
         EXIT_STATE : begin 
                        next_state = IDLE_STATE;
                     end    
                          
                        default: next_state = IDLE_STATE; 
        endcase 
        
        end     
        
        
 always@(*)
    begin
        case(current_state)
            IDLE_STATE : begin
                         green_tempo = 1'b0; // no lights on
                         red_tempo = 1'b0;
                         Sev_indicator <= count_spots; // on the seven segment display the number of spots available (which is five) // needs conversion
            end
            
            
            AVAIL_STATE : begin
                        green_tempo = 1'b0;
                        red_tempo = 1'b1;
                        Sev_indicator <= 4'b1010 ; // A Which means available
            end
            
            OCCUPIED_STATE : begin
                        red_tempo = 1'b1; 
                        green_tempo = 1'b0;
                        Sev_indicator <= 4'b1111; //F  Meaning full 
            end
            
            TAKE_TICKET : begin
                green_tempo = 1'b0;
                red_tempo = 1'b0;
                Sev_indicator <=  count_spots; // NEED  TO DO THE CONVERSION FOR THIS
                
            end
            
            PARK_STATE : begin
                Sev_indicator <= count_spots ; // need to do the conversion

            end
            
            PAY_STATE : begin
                
                green_tempo = 1'b1;
                red_tempo = 1'b0;
              
             end
     
            EXIT_STATE : begin
                green_tempo = 1'b1;
                red_tempo = 1'b0;
                Sev_indicator <= count_spots; // on the seven segment display the number of cars ** Do the conversion

            end
            
            endcase
end

   assign Red_State = red_tempo;
   assign Green_State = green_tempo;
            
        
endmodule
