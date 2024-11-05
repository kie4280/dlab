`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/26 13:40:00
// Design Name: 
// Module Name: main
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

module main(
  input clk,
  input reset_n,
  input [3:0] usr_btn,
  output [3:0] usr_led,
  output LCD_RS,
  output LCD_RW,
  output LCD_E,
  output [3:0] LCD_D
);
    reg [20:0] fib [24:0]; 
    reg [5:0] idx = 0;
    reg signed [5:0] disp1 = 0, disp2 = 1;  
    reg [27:0] counter = 0;
    wire btn3;
    reg prev_btn = 0;
    reg scroll_up = 1;
    reg [127:0] row_A = "";
    reg [127:0] row_B = "";
    reg [15:0] bitNumber1 = 0, bitNumber2 = 0;
    wire [31:0] hexWord1, hexWord2;
    wire [15:0] disp_string1, disp_string2; 
    
    LCD_module lcd0(
      .clk(clk),
      .reset(~reset_n),
      .row_A(row_A),
      .row_B(row_B),
      .LCD_E(LCD_E),
      .LCD_RS(LCD_RS),
      .LCD_RW(LCD_RW),
      .LCD_D(LCD_D)
    );
    
    bit_to_hex converter1(hexWord1, bitNumber1);
    bit_to_hex converter2(hexWord2, bitNumber2);
    bit_to_hex disp_1(disp_string1, disp1 + 1);
    bit_to_hex disp_2(disp_string2, disp2 + 1);
    
    debounce butt1(btn3, clk, usr_btn[3], reset_n);
   
    
    always @ (posedge clk) begin
    
        prev_btn <= btn3;
        if(prev_btn != btn3 && btn3) scroll_up <= !scroll_up;
        
        if(!reset_n) begin
            idx <= 0;
            disp1 <= 0;
            disp2 <= 1;
            fib[0] <= 0;
            fib[1] <= 1;
            counter <= 0;
            row_A <= 0;
            row_B <= 0;
            scroll_up <= 1;
            prev_btn <= 0;
            
            for(idx=2; idx<25; idx=idx+1) begin
                fib[idx] <= 0;
            end
            
            idx <= 2;
        end   
        
        else if(idx < 25) begin
            fib[idx] <= fib[idx-1] + fib[idx-2];
            idx <= idx + 1;
        end      
        
            
        else begin                   
            
            bitNumber1 <= fib[disp1];
            bitNumber2 <= fib[disp2];
            if(counter >= 70_000_000) begin            
                
                row_A <= {"Fibo #", disp_string1, " is ", hexWord1};
                row_B <= {"Fibo #", disp_string2, " is ", hexWord2};   
                disp1 <= disp1 + (scroll_up? 1:-1);
                disp2 <= disp2 + (scroll_up? 1:-1);
                
                if(disp1 > 23 && scroll_up) disp1 <= 0;
                else if(disp1 < 1 && !scroll_up) disp1 <= 24;
                if(disp2 > 23 && scroll_up) disp2 <= 0;
                else if(disp2 < 1 && !scroll_up) disp2 <= 24;
                counter <= 0;        
            end
            else begin
                counter <= counter + 1;                                          
            end
            
           
        
        end        
  
    end
endmodule
