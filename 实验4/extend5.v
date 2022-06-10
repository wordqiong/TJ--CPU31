`timescale 1ns / 1ns
module extend5 #(parameter WIDTH = 5)(
    input [WIDTH - 1:0] a,
    output [31:0] b
    );
    assign b = {{(32 - WIDTH){1'b0}},a};
endmodule