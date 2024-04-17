module DataPath(clk, rst, inst_field, Data_in, ALU_Control, ImmSel, 
  MemtoReg, ALUSrc_B, Jump, Branch, RegWrite, PC_out, Data_out, ALU_out,
  BranchN );
  input clk;
  input rst;
  input [31:0]inst_field;
  input [31:0]Data_in;
  input [3:0]ALU_Control;
  input [2:0]ImmSel;
  input [1:0]MemtoReg;
  input ALUSrc_B;
  input [1:0]Jump;
  input Branch;
  input BranchN;
  input RegWrite;
  output [31:0]PC_out;
  output [31:0]Data_out;
  output [31:0]ALU_out;

  // internal wires
  wire not1_Res;
  wire AND2_Res;
  wire AND3_Res;
  wire [31:0] ImmGen_0_Imm_out;
  wire [31:0] PC4_dout;
  assign PC4_dout = 32'd4;
  wire [31:0] add_32_0_c;
  wire [31:0] add_32_1_c;
  wire or2_Res;
  wire [31:0] MUX4T1_32_0_o;
  wire [4:0] Rs1_Dout;
  wire [4:0] Rs2_Dout;
  wire [4:0] Rd_Dout;
  wire [31:0] MUX2T1_32_1_o; 
  wire VCC_dout;
  assign VCC_dout = 1'b1;
  wire [31:0] MUX4T1_32_1_o;
  wire [31:0] MUX2T1_32_0_o;
  wire [31:0] Regs_0_Rs1_data;
  wire [31:0] Regs_0_Rs2_data;
  wire [31:0] PC_Q;
  wire [31:0] ALU_0_res;
  wire ALU_0_zero;


  // wiring
  assign AND3_Res = Branch & ALU_0_zero;
  assign not1_Res = ~ALU_0_zero;
  assign AND2_Res = not1_Res & BranchN;

  ImmGen ImmGen_0(
    .ImmSel(ImmSel),
    .inst_field(inst_field),
    .Imm_out(ImmGen_0_Imm_out)
  );

  add_32 add_32_0(
    .a(PC4_dout),
    .b(PC_Q),
    .c(add_32_0_c)
  );

  add_32 add_32_1(
    .a(PC_Q),
    .b(ImmGen_0_Imm_out),
    .c(add_32_1_c)
  );

  assign or2_Res = AND3_Res | AND2_Res;
  

  MUX2T1_32 MUX2T1_32_1(
    .I0(add_32_0_c),
    .I1(add_32_1_c),
    .s(or2_Res),
    .o(MUX2T1_32_1_o)
  );

  MUX4T1_32 MUX4T1_32_0(
    .s(MemtoReg),
    .I0(ALU_0_res),
    .I1(Data_in),
    .I2(add_32_0_c),
    .I3(ImmGen_0_Imm_out),
    .o(MUX4T1_32_0_o)
  );

  MUX4T1_32 MUX4T1_32_1(
    .s(Jump),
    .I0(MUX2T1_32_1_o),
    .I1(add_32_1_c),
    .I2(ALU_0_res),
    .I3(MUX2T1_32_1_o),
    .o(MUX4T1_32_1_o)
  );
  
  MUX2T1_32 MUX2T1_32_0(
    .I0(Regs_0_Rs1_data),
    .I1(ImmGen_0_Imm_out),
    .s(ALUSrc_B),
    .o(MUX2T1_32_0_o)
  );

  Regs Regs_0(
    .clk(clk),
    .rst(rst),
    .Rs1_addr(inst_field[19:15]),
    .Rs2_addr(inst_field[24:20]),
    .Wt_addr(inst_field[11:7]),
    .Wt_data(MUX4T1_32_0_o),
    .RegWrite(RegWrite),

    .Rs1_data(Regs_0_Rs1_data),
    .Rs2_data(Regs_0_Rs2_data)
  );

  REG32 PC(
    .clk(clk),
    .rst(rst),
    .CE(VCC_dout),
    .D(MUX4T1_32_1_o),
    
    .Q(PC_Q)
  );

  ALU ALU_0(
    .A(Regs_0_Rs1_data),
    .B(MUX2T1_32_0_o),
    .ALU_operation(ALU_Control),
    
    .res(ALU_0_res),
    .zero(ALU_0_zero)
  );


  assign PC_out = PC_Q;
  assign ALU_out = ALU_0_res;
  assign Data_out = Regs_0_Rs2_data;


endmodule
