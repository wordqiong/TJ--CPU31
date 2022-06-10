module test_imem(
    );
    reg [10:0] a;
    wire [31:0] spo;
    IMEM imem(
        .addr(a),
        .instr(spo)
    );

    initial begin
        a = 11'b0;
    end

    always begin
        #20 a = a + 1'b1;
    end
endmodule