module ALU(
    input [31:0] A,
    input [3:0] ALU_operation,
    input [31:0] B,
    output [31:0] res,
    output zero
);
    reg [31:0]reg_res;
    reg reg_zero;

    always @(*)
        case(ALU_operation)
            4'b0000: reg_res <= A&B; // and 0
            4'b0001: reg_res <= A|B; // or 1
            4'b0010: reg_res <= A+B; // add 2
            4'b1100: reg_res <= A^B; // xor c
            4'b0110: reg_res <= A-B; // sub 6
            4'b1101: reg_res <= A >> B[4:0]; // srl d
            4'b0111: reg_res <= $signed(A) < $signed(B) ? 1:0; // slt 7
            4'b1110: reg_res <= A << B[4:0]; // sll e
            4'b1111: reg_res <= A >>> B[4:0]; // sra f
            4'b1001: reg_res <= $unsigned(A) < $unsigned(B) ? 1:0; // sltu 9
        endcase
        assign res = reg_res;
        assign zero = (res==0 ? 1:0);
endmodule