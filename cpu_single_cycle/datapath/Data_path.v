module DataPath(
    input clk,
    input rst,
    input [31:0] inst_field,
    input ALUSrc_B,
    input [1:0] MemtoReg,
    input [1:0] Jump,
    input Branch,
    input RegWrite,
    input BranchN,
    input [31:0] Data_in,
    input [3:0] ALU_Control,
    input [2:0] ImmSel,
    output [31:0] ALU_out,
    output [31:0] Data_out,
    output [31:0] PC_out
);  
wire [31:0] D;
wire [31:0] A;
wire [31:0] B;
wire zero;
wire [31:0] PC;
assign PC_out = PC;
wire [31:0] rs2_data;
wire [31:0] imm_data;
wire [31:0] ALU_res;
wire [31:0] data;
wire sel;
wire [31:0] afterBranch;
assign ALU_out = ALU_res;
assign Data_out = rs2_data;
assign B = ALUSrc_B ? imm_data : rs2_data;
assign sel = (BranchN & (~zero)) | (Branch & zero);
assign afterBranch = sel ? PC+imm_data : PC+4;
MUX24 MUX24_inst_1(
    .s(Jump),
    .l0(afterBranch),
    .l1(PC+imm_data),
    .l2(ALU_res),
    .l3(afterBranch),
    .out(D)
);
PC PC_inst(
    .clk(clk),
    .rst(rst),
    .CE(1'b1),
    .D(D),
    .Q(PC)
);
ALU ALU_inst(
    .A(A),
    .ALU_operation(ALU_Control),
    .B(B),
    .res(ALU_res),
    .zero(zero)
);

Regs Regs_inst(
    .clk(clk),
    .rst(rst),
    .Rs1_addr(inst_field[19:15]),
    .Rs2_addr(inst_field[24:20]),
    .Wt_addr(inst_field[11:7]),
    .Wt_data(data),
    .RegWrite(RegWrite),
    .Rs1_data(A),
    .Rs2_data(rs2_data)
);

ImmGen ImmGen_inst(
    .ImmSel(ImmSel),
    .inst_field(inst_field),
    .Imm_out(imm_data)
);  
MUX24 MUX24_inst(
    .s(MemtoReg),
    .l0(ALU_res),
    .l1(Data_in),
    .l2(PC+4),
    .l3(imm_data),
    .out(data)
);



endmodule