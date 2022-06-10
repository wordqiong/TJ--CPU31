module sccomp_dataflow(
    input clk,
    input rst,
    output [31:0] inst,
    output wire [31:0] pc, // to test
    output wire [10:0] dm_addr,
    output wire [10:0] im_addr
    );

    wire dw, dr, dena;
    wire [31:0] w_data, r_data;
    wire [31:0] instr;
    wire[10:0]temp_im_addr;
      wire [31:0] res;

    assign inst = instr;
    assign dm_addr = (res - 32'h10010000)/4;

    IMEM imemory(
        .addr(temp_im_addr/4),
        .instr(instr)
    );
    assign temp_im_addr = pc - 32'h0040_0000;
     assign im_addr =temp_im_addr;
    
    DMEM dmemory(
        .clk(clk), .ena(1'b1), .DM_W(dw), .DM_R(dr), .DM_Addr(dm_addr[10:0]), .DM_WData(w_data),
        .DM_RData(r_data)
    );
    cpu cpu31(
   
        .clk(clk),.reset(rst), .inst(instr), .rdata(r_data),
        .DM_CS(dena), .DM_W(dw), .DM_R(dr), .wdata(w_data), .pc(pc), .addr(res)
    );
endmodule