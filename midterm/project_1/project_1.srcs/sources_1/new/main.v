`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/11 18:32:02
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
    
    reg [127:0] row_A = "PRESS BTN0      "; // Initialize the text of the first row. 
    reg [127:0] row_B = "TO START        "; // Initialize the text of the second row.
    wire btn0, btn1;
    reg prev_btn0 = 0, prev_btn1 = 0, cleared = 0, over = 0, flying = 0;
    reg [27:0] update_counter = 0;
    reg [2:0] blocks_counter = 0;   
    reg [3:0] fly_counter = 0;
    localparam [2:0] STATE_RESET = 0, STATE_INIT = 1, STATE_RUNNING = 2, STATE_OVER = 3;
    reg[2:0] STATE = 0, NEXT_STATE = 0;
    
    debounce db0(btn0, clk, usr_btn[0], reset_n);
    debounce db1(btn1, clk, usr_btn[1], reset_n);
    
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
    
    always @ (posedge clk) begin
        prev_btn0 <= btn0;
        prev_btn1 <= btn1;
       
        if(~reset_n) begin
        STATE = STATE_RESET;
        NEXT_STATE = STATE_RESET;
        prev_btn0 = 0;
        prev_btn1 = 0;
        
        end
        
        if(STATE == STATE_RESET && prev_btn0 != btn0 && btn0) NEXT_STATE = STATE_INIT;
        if(STATE == STATE_INIT && cleared) NEXT_STATE = STATE_RUNNING;
        if(STATE == STATE_OVER && prev_btn0 != btn0 && btn0) NEXT_STATE = STATE_RESET;
        if(STATE == STATE_RUNNING && over) NEXT_STATE = STATE_OVER;
        
        STATE=NEXT_STATE;
        
        
    end
    
    always @ (posedge clk) begin            
        
        case(STATE)
            STATE_RESET: begin
                row_A = "PRESS BTN0      ";
                row_B = "TO START        ";
                update_counter = 0;
                blocks_counter = 0;
                fly_counter = 0;
                cleared = 0;
                over = 0;
                flying = 0;
                
                
            end            
            
            STATE_INIT: begin
                row_A = "                ";
                row_B = "                ";
                cleared = 1;
            
            end
            STATE_RUNNING: begin
                
                if(update_counter == 0) begin
                    row_B = row_B << 8;
                    row_B[7:0] = " ";
                    if(flying) begin                                    
                       fly_counter = fly_counter + 1;
                       if(fly_counter > 3 && row_B[63:56] == 8'hDB) over = 1;
                       if(fly_counter > 3) begin
                           flying = 0;
                           fly_counter = 0;
                           row_A[63:56] = " ";
                           row_B[63:56] = 8'hB9;
                       end                    
                                                        
                    end 
                    else    begin
                    
                       
                    end
                    
                    if(row_B[63:56] == 8'hDB && !flying) over = 1;
                    else if(!flying)begin                        
                         row_B[63:56] = row_B[71:64]  == 8'hB9 ? 8'hB8 : 8'hB9;
                                                               row_B[71:64] = " ";
                    end
                    if(blocks_counter == 0) begin
                        row_B [7:0] = 8'hDB; 
                    end
                    blocks_counter = blocks_counter >= 5 ? 0 : blocks_counter + 1;
                    
                    
                
                end
                
                update_counter = update_counter >= 60_000_000 ? 0 : update_counter + 1;
                if(prev_btn1 != btn1 && btn1 && !flying) begin
                    flying = 1;        
                    row_A[63:56] = 8'hBA;
                    row_B[63:56] = " ";
                end               
                
            
            end
            
            STATE_OVER: begin
                row_A = "GAME OVER       ";
                row_B = "                ";
            
            end
            
            default:;
            
        endcase 
        
    
       
        
        
    
    
    
    end
    
    
endmodule
