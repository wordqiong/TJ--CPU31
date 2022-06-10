`timescale 1ns / 1ns
module regfile(
    input clk, //寄存器组时钟信号，下降沿写入数据
    input rst, //reset 信号，异步复位，高电平时全部寄存器置零
    input we, //寄存器读写有效信号，高电平时允许寄存器写入数据，低电平时允许寄存器读出数据
    input ov,//overflow
    input [4:0] raddr1, //所需读取的寄存器的地址
    input [4:0] raddr2, //所需读取的寄存器的地址
    input [4:0] waddr, //写寄存器的地址
    input [31:0] wdata, //写寄存器数据，数据在 clk 下降沿时被写入
    output [31:0] rdata1, //raddr1 所对应寄存器的输出数据
    output [31:0] rdata2 //raddr2 所对应寄存器的输出数据
    );

    reg [31:0] array_reg [31:0];
    reg c_o;
    always@(ov)
    begin
    case(ov)
    1'bz:c_o = 1;
    1'b1:c_o = 0;
    1'b0:c_o = 1;
    default:c_o=1;
    endcase
    end
   
   

    assign rdata1 = rst?0:array_reg[raddr1];
    assign rdata2 = rst?0:array_reg[raddr2];
    
    //清零
    integer i;
    always@(posedge rst)begin 
        for(i=0;i<32;i=i+1)begin 
            array_reg[i]<=0;
        end
    end
    //写入
    always@(negedge clk)begin 
        if(we&&c_o)begin 
            array_reg[waddr]<=wdata;
            array_reg[0]<=0;
        end        
    end
    
endmodule

