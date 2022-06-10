`timescale 1ns / 1ns
module alu(
    input [31:0] a,        //OP1
    input [31:0] b,        //OP2
    input [4:0] aluc,    //controller
    output [31:0] r,    //result
    output zero,
    output carry,
    output negative,
    output overflow);
        
    //instrution set
        parameter ADDU = 5'b 00000;
        parameter ADD = 5'b 00001;
        parameter SUB = 5'b 00010;
        parameter SUBU = 5'b 00011;
        parameter AND = 5'b 00100;
        parameter OR = 5'b 00101;
        parameter XOR = 5'b 00110;
        parameter NOR = 5'b 00111;
        parameter SLL = 5'b 01000;
        parameter SRL = 5'b 01001;
        parameter SRA = 5'b 01010;
        parameter SLLV = 5'b 01011;
    
        parameter LUI = 5'b 01101;
        parameter SRLV = 5'b 01110;
        parameter SRAV = 5'b 01111;
    
        parameter SLT = 5'b 10010;
        parameter SLTU = 5'b 10011;
        parameter LW = 5'b 10001;//SW

 
    //easy to calculate
    wire signed [31:0]aSign,bSign ;
    assign aSign =a;
    assign bSign =b;

    //store res 
    //use [32:0] instead of [31:0] use [32] to change CF SF OF ZF 
    reg [32:0]res;

    always @(*) begin
        case(aluc)
            ADD:    res<=aSign+bSign;
            LW:    begin res<=aSign+bSign;
            
            end
            ADDU:   res<=a+b;
            
            SUB:    res<=aSign-bSign;
            SLT:    res<=aSign<bSign?32'b1:32'b0;
            
            SUBU:   res<=a-b;
            SLTU:   res<=a<b?1:0;
            
            AND:    res<=a&b;
            OR:     res<=a|b;
            XOR:    res<=a^b;
            NOR:    res<=~(a|b);

            SLL:    res<=b<<a;
            SRL:    res<=b>>a;
            SRA:    res<=bSign>>>aSign;
            SLLV:   res<=b<<a[4:0];
            SRLV:   res<=b>>a[4:0];
            SRAV:   res<=bSign>>>aSign[4:0];
            
            LUI:    res<={b[15:0],16'b0};
            
         default:
         res<=32'b0;
        endcase
    end

    //process output
    assign r=res[31:0];

    //process ZF,OF,CF,SF
    assign zero =(res==32'b0)?1'b1:1'b0;//ZF
    //only add  sub is not process 明天写
    assign overflow=(aluc==ADD)?(res[32]?((aSign>0&&bSign>0)?1'b1:1'b0):((aSign<0&&bSign<0)?1'b1:1'b0)):(aluc==SUB?(res[32]?((aSign>0&&bSign<0)?1'b1:1'b0):((aSign<0&&bSign>0)?1'b1:1'b0)):1'b0);//OF
   assign carry = (aluc==ADDU|aluc==SUBU|aluc==SLTU|aluc==SRA|aluc==SRL|aluc==SLL)?res[32]:1'bz;//CF
    assign negative=(aluc==SUB?(aSign<bSign):((aluc==SUBU)?(a<b):1'b0));//SF
endmodule