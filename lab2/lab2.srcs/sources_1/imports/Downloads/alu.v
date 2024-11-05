module alu(output[7:0] alu_out, input[7:0] accum, input[7:0] data, input[2:0] opcode, output zero, input clk, input reset);


// modeling your design here !!

reg[7:0] out_reg;


assign alu_out = out_reg;
assign zero = !(|accum);

always @(posedge clk)
begin

    if(reset || opcode==1'bX) begin
        out_reg = 8'b0;
    end
    
    else begin
    
        case(opcode)
            3'b000: out_reg = accum;
            3'b001: out_reg = accum + data;
            3'b010: out_reg = accum - data;
            3'b011: out_reg = accum & data;
            3'b100: out_reg = accum ^ data;
            3'b101: out_reg = (accum[7] == 1'b0)? accum : -accum;
            3'b110: out_reg = -accum;
            3'b111: out_reg = data;
            default: out_reg = 8'b0;
     
     
        endcase   
    end
    
end




endmodule
