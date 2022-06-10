`timescale 1ns/1ps
module DMEM(
    input clk,
    input ena,
    input DM_W,
    input DM_R,
    input [10:0] DM_Addr,
    input [31:0]DM_WData,
    output [31:0]DM_RData
);
reg[31:0]D_mem[0:31];

assign DM_RData=(DM_R&&ena)?D_mem[DM_Addr]:32'bz;
always@(posedge clk)begin
    if(DM_W && ena)begin
        D_mem[DM_Addr]<=DM_WData;
    end
end



endmodule