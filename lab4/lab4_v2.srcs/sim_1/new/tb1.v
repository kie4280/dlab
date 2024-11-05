`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/23 03:16:54
// Design Name: 
// Module Name: tb1
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

module tb1;
wire ledw;
reg clk, reset_n;
reg [3:0] butt;
reg [3:0] led, LCD_D;
wire LCD_RS, LCD_RW, LCD_E;

main m(clk, reset_n, butt, ledw, LED_RS, LED_RW, LED_E, LED_D);

initial begin
    clk <= 0;
    forever begin
        #1 clk <= ~clk;              
    end    
end

initial begin 
     reset_n <= #5 0;
     butt <= #5 0;
     
     
     
     reset_n <= #10 1;
    
     
     //enter button below
     
     # 15butt[0]=1;
     #30000000;
     #10 butt[0]=1;
     #10 butt[0]=0;
     #10 butt[0]=1;
     #10 butt[0]=0;
     #10 butt[0]=1;
     #5  butt[0]=0;
     
     
     

//    # 1000 $monitor("", clk, butt, led);
end 




always @ * begin
    led <= ledw;
end


task pressbutton;
input button_pin;
output button;

endtask
 
    
endmodule



