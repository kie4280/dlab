`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2019 10:59:22 AM
// Design Name: 
// Module Name: mmult
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


module mmult(
input clk,// Clock signal.
input reset_n,// Reset signal (negative logic).

input enable,// Activation signal for matrix
// multiplication (tells the circuit
// that A and B are ready for use).

input [0:9*8-1] A_mat,
input [0:9*8-1] B_mat,

output valid, // Signals that the output is valid
                // to read.
output reg [0:9*17-1] C_mat // The result of A x B.
);

reg [0:9*8-1] shiftA = 0;
reg [0:1] counter = 0;
assign valid = (counter==3);



always @(posedge clk) begin

    if(!reset_n) begin
        counter <= 0;
        C_mat <= 0;
    end

    if(enable && !valid) begin
        C_mat <= C_mat<<51;
        shiftA <= shiftA<<24;        
        counter <= counter + 1;
        
        C_mat[102:118] <= shiftA[0:7]*B_mat[0:7] +shiftA[8:15]*B_mat[24:31]+shiftA[16:23]*B_mat[48:55];
        C_mat[119:135] <= shiftA[0:7]*B_mat[8:15] + shiftA[8:15]*B_mat[32:39]+shiftA[16:23]*B_mat[56:63];
        C_mat[136:152] <= shiftA[0:7]*B_mat[16:23] + shiftA[8:15]*B_mat[40:47]+shiftA[16:23]*B_mat[64:71];
        
    end
    else begin        
        shiftA <= A_mat;
        
    end
     
    
    
end


endmodule
