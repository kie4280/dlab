`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 09:43:41
// Design Name: 
// Module Name: bit_to_a
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


module bit_to_hex(
    output [31:0] res,
    input [15:0] in   

    );
    
    reg [7:0] digits [3:0];
    
    assign res = {digits[3], digits[2], digits [1], digits[0]};
    
    
    always @ * begin
        digits[3] = in[15:12] >= 10 ? in[15:12] - 10 + "A" : in[15:12] + "0";
        digits[2] = in[11:8] >= 10 ? in[11:8] - 10 + "A" : in[11:8] + "0";
        digits[1] = in[7:4] >= 10 ? in[7:4] - 10 + "A" : in[7:4] + "0";
        digits[0] = in[3:0] >= 10 ? in[3:0] - 10 + "A" : in[3:0] + "0";
       
           
    
    end
endmodule

module bit_to_dec(
    output [15:0] out,
    input [4:0] in
    );
    
    reg [15:0] a;
    assign out = a;
    
    always @ * begin
        if(in < 10) begin
            a[15:8] = "0";
            a[7:0] = "0" + in;    
        end
        
        else if(in < 20) begin
            a[15:8] = "1";
            a[7:0] = "0" + in - 10;
        end
        else if(in < 30) begin
            a[15:8] = "2";
            a[7:0] = "0" + in - 20;
        end
    end
    
endmodule
