`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/26 13:40:28
// Design Name: 
// Module Name: debounce
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


module debounce(
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