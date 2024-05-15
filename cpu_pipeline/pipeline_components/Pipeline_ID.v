module Pipeline_ID (
    clk_ID, rst_ID, RegWrite_in_ID, Rd_addr_ID, 
  Wt_data_ID, Inst_in_ID, Rd_addr_out_ID, Rs1_out_ID, Rs2_out_ID, Imm_out_ID, ALUSrc_B_ID, 
  ALU_control_ID, Branch_ID, BranchN_ID, MemRW_ID, Jump_ID, MemtoReg_ID, RegWrite_out_ID)
/* synthesis syn_black_box black_box_pad_pin="clk_ID,rst_ID,RegWrite_in_ID,Rd_addr_ID[4:0],Wt_data_ID[31:0],Inst_in_ID[31:0],Rd_addr_out_ID[31:0],Rs1_out_ID[31:0],Rs2_out_ID[31:0],Imm_out_ID[31:0],ALUSrc_B_ID,ALU_control_ID[2:0],Branch_ID,BranchN_ID,MemRW_ID,Jump_ID,MemtoReg_ID[1:0],RegWrite_out_ID" */;
  input clk_ID;
  input rst_ID;
  input RegWrite_in_ID;
  input [4:0]Rd_addr_ID;
  input [31:0]Wt_data_ID;
  input [31:0]Inst_in_ID;
  output [4:0]Rd_addr_out_ID;
  output [31:0]Rs1_out_ID;
  output [31:0]Rs2_out_ID;
  output [31:0]Imm_out_ID;
  output ALUSrc_B_ID;
  output [3:0]ALU_control_ID;
  output Branch_ID;
  output BranchN_ID;
  output MemRW_ID;
  output [1:0] Jump_ID;
  output [1:0]MemtoReg_ID;
  output RegWrite_out_ID;


    wire [2:0] SCPU_ctrl_ImmSel;
    Regs Regs_0(
        .clk(clk_ID),
        .rst(rst_ID),
        .RegWrite(RegWrite_in_ID),
        .Wt_data(Wt_data_ID),
        .Wt_addr(Rd_addr_ID),
        .Rs1_addr(Inst_in_ID[19:15]),
        .Rs2_addr(Inst_in_ID[24:20]),
        
        .Rs1_data(Rs1_out_ID),
        .Rs2_data(Rs2_out_ID)
    );
    ImmGen ImmGen_0(
        .ImmSel(SCPU_ctrl_ImmSel),
        .inst_field(Inst_in_ID),

        .Imm_out(Imm_out_ID)
    );

    SCPU_ctrl SCPU_ctrl_0(
        .OPcode(Inst_in_ID[6:2]),
        .Fun3(Inst_in_ID[14:12]),
        .Fun7(Inst_in_ID[30]),
        // MIO_ready 就不接了
        .ImmSel(SCPU_ctrl_ImmSel),
        .ALUSrc_B(ALUSrc_B_ID),
        .ALU_Control(ALU_control_ID),
        .Branch(Branch_ID),
        .BranchN(BranchN_ID),
        .MemRW(MemRW_ID),
        .Jump(Jump_ID),
        .MemtoReg(MemtoReg_ID),
        .RegWrite(RegWrite_out_ID)
        // CPU_MIO就不接了
    );
    assign Rd_addr_out_ID = Inst_in_ID[11:7];
endmodule