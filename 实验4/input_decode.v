`timescale 1ns / 1ns
module instr_dec(
    input [31:0] instr_code,
    output reg [31:0] i
    );
    wire [11:0] t;
    assign t = {instr_code[31:26],instr_code[5:0]};
    always @ (*)
    begin
        casez(t)
            12'b000000100000 :i = 32'b00000000000000000000000000000001;
            12'b000000100001 :i = 32'b00000000000000000000000000000010;
            12'b000000100010 :i = 32'b00000000000000000000000000000100;
            12'b000000100011 :i = 32'b00000000000000000000000000001000;
            12'b000000100100 :i = 32'b00000000000000000000000000010000;
            12'b000000100101 :i = 32'b00000000000000000000000000100000;
            12'b000000100110 :i = 32'b00000000000000000000000001000000;
            12'b000000100111 :i = 32'b00000000000000000000000010000000;
            12'b000000101010 :i = 32'b00000000000000000000000100000000;
            12'b000000101011 :i = 32'b00000000000000000000001000000000;
            12'b000000000000 :i = 32'b00000000000000000000010000000000;
            12'b000000000010 :i = 32'b00000000000000000000100000000000;
            12'b000000000011 :i = 32'b00000000000000000001000000000000;
            12'b000000000100 :i = 32'b00000000000000000010000000000000;
            12'b000000000110 :i = 32'b00000000000000000100000000000000;
            12'b000000000111 :i = 32'b00000000000000001000000000000000;
            12'b000000001000 :i = 32'b00000000000000010000000000000000;
            12'b001000?????? :i = 32'b00000000000000100000000000000000;
            12'b001001?????? :i = 32'b00000000000001000000000000000000;
            12'b001100?????? :i = 32'b00000000000010000000000000000000;
            12'b001101?????? :i = 32'b00000000000100000000000000000000;
            12'b001110?????? :i = 32'b00000000001000000000000000000000;
            12'b100011?????? :i = 32'b00000000010000000000000000000000;
            12'b101011?????? :i = 32'b00000000100000000000000000000000;
            12'b000100?????? :i = 32'b00000001000000000000000000000000;
            12'b000101?????? :i = 32'b00000010000000000000000000000000;
            12'b001010?????? :i = 32'b00000100000000000000000000000000;
            12'b001011?????? :i = 32'b00001000000000000000000000000000;
            12'b001111?????? :i = 32'b00010000000000000000000000000000;
            12'b000010?????? :i = 32'b00100000000000000000000000000000;
            12'b000011?????? :i = 32'b01000000000000000000000000000000;
            default:          i = 32'bx;
        endcase
    end
    
endmodule