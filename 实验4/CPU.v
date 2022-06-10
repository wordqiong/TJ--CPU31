`timescale 1ns / 1ps
module cpu(
    input         clk,
    input         reset,
    input  [31:0] inst,
    input  [31:0] rdata,
    output [31:0] pc,
    output [31:0] addr,
    output [31:0] wdata,
    output        IM_R,
    output        DM_CS,
    output        DM_R,
    output        DM_W
    );
     //控制信号(除有关存储器）
    wire PC_CLK;                     //
    wire PC_ENA;                     //
    wire M1;                         //
    wire M2;                         //
    wire M3;                         //
    wire M4;                         //
    wire M5;                         //
    wire M6;                         //
    wire M7;                         //
    wire M8;                         //
    wire M9;                         //
    wire M10;                        //
    wire [4:0] ALUC;                 //
    wire RF_W;                       //
    wire RF_CLK;                     //
    wire C_EXT16;                    //
     //运算标志位
    wire zero;                       //
    wire carry;                      //
    wire negative;                   //
    wire overflow;                   //
    wire add_overflow;               //
     // 
    wire [31:0] INS;                 //译码后指令
     //数据通路（除有关存储器）
    wire [31:0] D_ALU;               //
    wire [31:0] D_PC;                //
    wire [31:0] D_RF;                //
    wire [31:0] D_Rs;                //
    wire [31:0] D_Rt;                //
    wire [31:0] D_IM;                //
    wire [31:0] D_DM;                //
    wire [31:0] D_Mux1;              //
    wire [31:0] D_Mux2;              //
    wire [31:0] D_Mux3;              //
    wire [4:0]  D_Mux4;              //
    wire [31:0]  D_Mux5;              //
    wire [31:0] D_Mux6;              //
    wire [31:0] D_Mux7;              //
    wire [31:0] D_Mux8;              //
    wire [31:0] D_Mux9;              //
    wire [5:0] D_Mux10;             //
   
    wire [31:0] D_EXT1;              //
    wire [31:0] D_EXT5;              //
    wire [31:0] D_EXT16;             //
    wire [31:0] D_EXT18;             //
    wire [31:0] D_ADD;               //
    wire [31:0] D_ADD8;              //
    wire [31:0] D_NPC;               //
    wire [31:0] D_ii;                //
    assign PC_ENA = 1;
     //外部通路连接
    assign pc = D_PC;
    assign addr = D_ALU;
    assign wdata = D_Rt;
    assign D_DM=rdata;
     //指令译码
    instr_dec cpu_ins (inst, INS);
    control cpu_control (.clk(clk),
        .zero(zero),
        .i(INS),
        .M1(M1),       
        .M2(M2),        
        .M3(M3),        
        .M4(M4),        
        .M5(M5),        
        .M6(M6),       
        .M7(M7),  
        .M8(M8),     
        .M9(M9),
        .M10(M10), 
        
        .PC_CLK(PC_CLK),    
        .IM_R(IM_R),           
        .ALUC(ALUC),
             
        .RF_CLK(RF_CLK),   
        .RF_W(RF_W),
        .DM_W(DM_W),   
        .DM_R(DM_R),     
        .DM_CS(DM_CS),
        .C_EXT16(C_EXT16));
     //部件
    pcreg   pc_out      (PC_CLK,     reset,      PC_ENA,      D_Mux2,   D_PC);
    alu     cpu_alu     (D_Mux5,     D_Mux6,    ALUC[4:0],   D_ALU,    zero,         carry,        negative, overflow);
    regfile cpu_ref     (RF_CLK,     reset,      RF_W,        overflow, inst[25:21],  inst[20:16],  D_Mux10,   D_Mux8,D_Rs, D_Rt);
    mux     cpu_mux1    (D_NPC,     D_ii,     M1,          D_Mux1);
    mux     cpu_mux2    (D_Mux3,      D_Mux1,      M2,          D_Mux2);
    mux     cpu_mux3    (D_ADD,       D_Rs,       M3,          D_Mux3);
    mux5    cpu_mux4    (inst[10:6], D_Rs[4:0],  {INS[30],M4},D_Mux4);
    mux     cpu_mux5    (D_EXT5,     D_Rs,M5,D_Mux5);
    mux     cpu_mux6    (D_Rt,     D_EXT16,     M6,          D_Mux6);
    mux     cpu_mux7    (D_ALU,     D_ADD8,      M7,          D_Mux7);
    mux     cpu_mux8    (D_Mux7,D_Mux9,M8,D_Mux8);
    mux     cpu_mux9    (D_ALU,D_DM,       M9,          D_Mux9);
    mux5     cpu_mux10   (inst[15:11],inst[20:16],{INS[30],M10},D_Mux10);
    
    extend5 cpu_ext5    (D_Mux4,     D_EXT5);
    extend16 cpu_ext16  (inst[15:0], C_EXT16,    D_EXT16);
    extend18 cpu_ext18  (inst[15:0], D_EXT18);
    add     cpu_add     (D_EXT18,    D_NPC,      D_ADD,       add_overflow);
    add8    cpu_add8    (D_PC,       D_ADD8);
    npc     cpu_npc     (D_PC,       reset,      D_NPC);
    II      cpu_ii      (D_PC[31:28],inst[25:0], D_ii);
  
endmodule