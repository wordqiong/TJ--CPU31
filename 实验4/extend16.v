`timescale 1ns / 1ns
module extend16 #(parameter WIDTH = 16)(
    input [WIDTH - 1:0] a,
    input sext,             //1表示有符号
    output [31:0] b
    );
    assign b = sext ? {{(32 - WIDTH){a[WIDTH - 1]}},a} : {{(32 - WIDTH){1'b0}},a};
endmodule