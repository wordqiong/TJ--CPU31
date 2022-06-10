`timescale 1ns / 1ps
module test_cpu(
    );
    reg clk, rst;
    wire [31:0] inst, pc;
    reg [31:0] cnt;
    wire[10:0] dma, ima;
    integer file_open;
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #2 rst=1'b0;
        cnt = 0;
    end

    always begin
        #1 clk = !clk;
    end
initial begin
 file_open = $fopen("D:/shuzidianlu/Xilinx/CPU/CPU.sim/sim_1/behav/output.txt", "w+");//目标存放点
 if (!file_open) begin
 
 $display("can not open \"888.txt\"");
 
 $finish;
 
 end
end
    always @(negedge clk) begin
        cnt <= cnt + 1'b1;
        if (cnt < 8'h99 - 1&&cnt>=1'b1 ) begin // 可自我调整，这是所有 txt 测试文件都能够容纳的数据，在此时钟下，为6000 ns
           
 $fdisplay(file_open, "pc: %h", sc.pc);
       $fdisplay(file_open, "instr: %h", sc.inst);
      // $fdisplay(file_open, "aluc: %h,a: %h,b:%h,res:%h", sc.cpu31.cpu_alu.aluc,sc.cpu31.cpu_alu.a,sc.cpu31.cpu_alu.b,sc.cpu31.cpu_alu.res);
      // $fdisplay(file_open, "wdata: %h,MUX9:%h,D_ALU:%h", sc.cpu31.D_Mux8,sc.cpu31.D_Mux9,sc.cpu31.D_ALU);
     
       $fdisplay(file_open, "regfile0: %h", sc.cpu31.cpu_ref.array_reg[0]);
                   $fdisplay(file_open, "regfile1: %h", sc.cpu31.cpu_ref.array_reg[1]);
                  $fdisplay(file_open, "regfile2: %h", sc.cpu31.cpu_ref.array_reg[2]);
                  $fdisplay(file_open, "regfile3: %h", sc.cpu31.cpu_ref.array_reg[3]);
                  $fdisplay(file_open, "regfile4: %h", sc.cpu31.cpu_ref.array_reg[4]);
                  $fdisplay(file_open, "regfile5: %h", sc.cpu31.cpu_ref.array_reg[5]);
                  $fdisplay(file_open, "regfile6: %h", sc.cpu31.cpu_ref.array_reg[6]);
                  $fdisplay(file_open, "regfile7: %h", sc.cpu31.cpu_ref.array_reg[7]);
                  $fdisplay(file_open, "regfile8: %h", sc.cpu31.cpu_ref.array_reg[8]);
                  $fdisplay(file_open, "regfile9: %h", sc.cpu31.cpu_ref.array_reg[9]);
                  $fdisplay(file_open, "regfile10: %h", sc.cpu31.cpu_ref.array_reg[10]);
                  $fdisplay(file_open, "regfile11: %h", sc.cpu31.cpu_ref.array_reg[11]);
                  $fdisplay(file_open, "regfile12: %h", sc.cpu31.cpu_ref.array_reg[12]);
                  $fdisplay(file_open, "regfile13: %h", sc.cpu31.cpu_ref.array_reg[13]);
                  $fdisplay(file_open, "regfile14: %h", sc.cpu31.cpu_ref.array_reg[14]);
                  $fdisplay(file_open, "regfile15: %h", sc.cpu31.cpu_ref.array_reg[15]);
                  $fdisplay(file_open, "regfile16: %h", sc.cpu31.cpu_ref.array_reg[16]);
                  $fdisplay(file_open, "regfile17: %h", sc.cpu31.cpu_ref.array_reg[17]);
                  $fdisplay(file_open, "regfile18: %h", sc.cpu31.cpu_ref.array_reg[18]);
                  $fdisplay(file_open, "regfile19: %h", sc.cpu31.cpu_ref.array_reg[19]);
                  $fdisplay(file_open, "regfile20: %h", sc.cpu31.cpu_ref.array_reg[20]);
                  $fdisplay(file_open, "regfile21: %h", sc.cpu31.cpu_ref.array_reg[21]);
                  $fdisplay(file_open, "regfile22: %h", sc.cpu31.cpu_ref.array_reg[22]);
                  $fdisplay(file_open, "regfile23: %h", sc.cpu31.cpu_ref.array_reg[23]);
                  $fdisplay(file_open, "regfile24: %h", sc.cpu31.cpu_ref.array_reg[24]);
                  $fdisplay(file_open, "regfile25: %h", sc.cpu31.cpu_ref.array_reg[25]);
                  $fdisplay(file_open, "regfile26: %h", sc.cpu31.cpu_ref.array_reg[26]);
                  $fdisplay(file_open, "regfile27: %h", sc.cpu31.cpu_ref.array_reg[27]);
                  $fdisplay(file_open, "regfile28: %h", sc.cpu31.cpu_ref.array_reg[28]);
                  $fdisplay(file_open, "regfile29: %h", sc.cpu31.cpu_ref.array_reg[29]);
                  $fdisplay(file_open, "regfile30: %h", sc.cpu31.cpu_ref.array_reg[30]);
                  $fdisplay(file_open, "regfile31: %h", sc.cpu31.cpu_ref.array_reg[31]);
        
        end
        if(cnt==400) begin
    
                        $fclose(file_open);
                  
        end
    end
    sccomp_dataflow sc(
        .clk(clk),
        .rst(rst),
        .inst(inst),
        .pc(pc),
        .dm_addr(dma), .im_addr(ima)
    );
endmodule