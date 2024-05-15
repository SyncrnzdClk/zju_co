module Pipeline_Ex(
    input [31:0] PC_in_EX,
    input [31:0] Rs1_in_EX,
    input [31:0] Rs2_in_EX,
    input [31:0] Imm_in_EX,
    input ALUSrc_B_in_EX,
    input [3:0] ALU_control_in_EX,
    output [31:0] PC_out_EX,
    output [31:0] PC4_out_EX,
    output zero_out_EX,
    output [31:0] ALU_out_EX,
    output [31:0] Rs2_out_EX
);
assign PC_out_EX = PC_in_EX + Imm_in_EX;
assign PC4_out_EX = PC_in_EX + 4;
assign Rs2_out_EX = Rs2_in_EX;
wire [31:0] B;
assign B = ALUSrc_B_in_EX ? Imm_in_EX : Rs2_in_EX;
ALU alu_inst(
    .A(Rs1_in_EX),
    .B(B),
    .ALU_operation(ALU_control_in_EX),
    .res(ALU_out_EX),
    .zero(zero_out_EX)
);

endmodule