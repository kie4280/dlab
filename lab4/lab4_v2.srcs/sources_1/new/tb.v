`timescale 10ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/21 20:35:47
// Design Name: 
// Module Name: tb
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


module tb;
wire ledw;
reg clk, reset_n;
reg [3:0] butt;
reg [3:0] led;

lab4 m(clk, reset_n, butt, ledw);

initial begin
    clk <= 0;
    forever begin
        #1 clk <= ~clk;              
    end    
end

initial begin 
     reset_n <= #5 0;
     butt <= #5 0;
     led <= #5  0;
     
     
     reset_n <= #10 1;
    
     
     //enter button below
     
     #30 butt[0]=1;
     #10 butt[0]=1;
     #10 butt[0]=0;
     #10 butt[0]=1;
     #10 butt[0]=0;
     #10 butt[0]=1;
     #5butt[0]=0;
     
     
     

//    # 1000 $monitor("", clk, butt, led);
end 




always @ * begin
    led <= ledw;
end

 
    
endmodule


task pressbutton;
input button_pin;
output button;

endtask
