`timescale 1ns / 1ps
module lab4(
  input  clk,            // System clock at 100 MHz
  input  reset_n,        // System reset signal, in negative logic
  input  [3:0] usr_btn,  // Four user pushbuttons
  output [3:0] usr_led   // Four yellow LEDs
);

reg signed [3:0] leds;
reg [3:0] button_state;
reg [3:0] button_state_prev;
parameter [99:0] PWM_CONST = {20'd5_0000, 20'd25_0000, 20'd50_0000, 20'd75_0000, 20'd100_0000};
reg [19:0] PWM_val=50_0000;
reg [2:0] PWM_select=2;
wire [3:0] butt;
wire PWM_out;

assign usr_led = leds & {4{PWM_out}};
//assign usr_led = leds;
bounceButt but0(butt[0], clk, usr_btn[0], reset_n);
bounceButt but1(butt[1], clk, usr_btn[1], reset_n);
bounceButt but2(butt[2], clk, usr_btn[2], reset_n);
bounceButt but3(butt[3], clk, usr_btn[3], reset_n);

PWMsignal pwm1(PWM_out, clk, PWM_val, reset_n);

always @ (posedge clk) begin
    button_state_prev <= button_state;
    button_state <= butt;
    PWM_val <= PWM_CONST[PWM_select*20 +: 20];   
    if(!reset_n) begin
        leds <= 4'b0000;     
        PWM_select <= 2;   
    end    
    
    if(button_state_prev[0] != button_state[0] && button_state[0]) leds <= leds > -8 ? leds - 1 : leds;
    if(button_state_prev[1] != button_state[1] && button_state[1]) leds <= leds < 7 ? leds + 1 : leds;
    if(button_state_prev[2] != button_state[2] && button_state[2]) PWM_select <= PWM_select < 4 ? PWM_select + 1: PWM_select;
    if(button_state_prev[3] != button_state[3] && button_state[3]) PWM_select <= PWM_select > 0 ? PWM_select - 1: PWM_select;

//    if((button_state_prev!=button_state)) begin    
    
//        case(button_state)
//            4'b0001: 
//            begin
//               if(button_state[0]) leds <= leds > -8 ? leds - 1 : leds;
//            end
//            4'b0010: 
//            begin 
//                if(button_state[1]) leds <= leds < 7 ? leds + 1 : leds;
//            end
                
//            4'b0100:
//            begin
//                if(button_state[2]) PWM_select <= PWM_select < 4 ? PWM_select + 1: PWM_select;
//            end
//            4'b1000: 
//            begin
//                if(button_state[3]) PWM_select <= PWM_select > 0 ? PWM_select - 1: PWM_select;
//            end
//            default:;
//         endcase
         
    
//    end
   
    
    
    
end
endmodule

module bounceButt(
    output result,
    input clk,
    input button,
    input reset_n);
    
    
    reg [16:0] on_counter;
    assign result = on_counter > 17'b0111111001011100;
    always @ (posedge clk) begin
        if(!reset_n) on_counter <= 0; 
        
        if(button && (on_counter < 17'b11111111111111111)) on_counter <= on_counter + 1; 
        else if(!button && (on_counter > 17'b0000000000000000)) on_counter <= on_counter - 1;
            
    end
endmodule

module PWMsignal(
    output out,
    input clk,
    input [19:0] dutycycle,
    input reset_n);
    
    reg [19:0] counter = 0;
    reg state = 1;
    
    assign out = state;
    
    always @ (posedge clk) begin        
        
        if(!reset_n) begin
            counter <= 0;
            state <= 1;
        end     
        
        else begin
            counter <= counter + 1;
        
            if(counter >= 100_0000) begin
                counter <= 0;
                state <= 1;
            end
        
            else if(counter > dutycycle) begin
                state <= 0;
        
            end
            
        end
    
    end   
    
    
    
    
endmodule
    