`timescale 1ns / 1ns
module mux5(
    input [4:0] a,
    input [4:0] b,
    input [1:0] choose,
    output [4:0] z
    );
    reg [4:0] t_z;
    always @(*)
    begin
    case(choose)
        2'b01:t_z <= b;
        2'b00:t_z <= a;
        2'b10:t_z <= 5'b11111;
        2'b11:t_z <= 5'b11111;
        default:t_z <= 5'bz;
    endcase
    end
    assign z = t_z;
endmodule