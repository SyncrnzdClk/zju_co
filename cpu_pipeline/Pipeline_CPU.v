module Pipeline_CPU(
    input clk,
    input rst,
    input[31:0] Data_in,
    input[31:0] inst_IF,
    output[31:0] PC_out_IF,
    output[31:0] PC_out_ID,
    output[31:0] inst_ID,
    output[31:0] PC_out_EX,
    output       MemRW_Ex,
    output       MemRW_Mem,
    output[31:0] Addr_out,
    output[31:0] Data_out,
    output[31:0] Data_out_WB
);
    wire b1_dout;
    assign b1_dout = 1'b1;
    wire [31:0] Instruction_Fetch_PC_out_IF;
    wire [31:0] IF_reg_ID_PC_out_IFID;
    wire [31:0] IF_reg_ID_inst_out_IFID;
    wire [4:0] Instruction_Decoder_Rd_addr_out_ID;
    wire [31:0] Instruction_Decoder_Rs1_out_ID;
    wire [31:0] Instruction_Decoder_Rs2_out_ID;
    wire [31:0] Instruction_Decoder_Imm_out_ID;
    wire Instruction_Decoder_ALUSrc_B_ID;
    wire [3:0] Instruction_Decoder_ALU_control_ID;
    wire  Instruction_Decoder_Branch_ID;
    wire  Instruction_Decoder_BranchN_ID;
    wire  Instruction_Decoder_MemRW_ID;
    wire  [1:0] Instruction_Decoder_Jump_ID;
    wire [1:0] Instruction_Decoder_MemtoReg_ID;
    wire  Instruction_Decoder_RegWrite_out_ID;
    wire [31:0] ID_reg_EX_PC_out_IDEX;
    wire [4:0] ID_reg_EX_Rd_addr_out_IDEX;
    wire [31:0] ID_reg_EX_Rs1_out_IDEX;
    wire [31:0] ID_reg_EX_Rs2_out_IDEX;
    wire [31:0] ID_reg_EX_Imm_out_IDEX;
    wire ID_reg_EX_ALUSrc_B_out_IDEX;
    wire [3:0] ID_reg_EX_ALU_control_out_IDEX;
    wire ID_reg_EX_Branch_out_IDEX;
    wire ID_reg_EX_BranchN_out_IDEX;
    wire ID_reg_EX_MemRW_out_IDEX;
    wire [1:0] ID_reg_EX_Jump_out_IDEX;
    wire [1:0] ID_reg_EX_MemtoReg_out_IDEX;
    wire ID_reg_EX_RegWrite_out_IDEX;
    wire [31:0] Execute_PC_out_EX;
    wire [31:0] Execute_PC4_out_EX;
    wire Execute_zero_out_EX;
    wire [31:0] Execute_ALU_out_EX;
    wire [31:0] Execute_Rs2_out_EX;
    wire [31:0] Ex_reg_Mem_PC_out_EXMem;
    wire [31:0] Ex_reg_Mem_PC4_out_EXMem;
    wire [4:0] Ex_reg_Mem_Rd_addr_out_EXMem;
    wire Ex_reg_Mem_zero_out_EXMem;
    wire [31:0] Ex_reg_Mem_ALU_out_EXMem;
    wire [31:0] Ex_reg_Mem_Rs2_out_EXMem;
    wire Ex_reg_Mem_Branch_out_EXMem;
    wire Ex_reg_Mem_BranchN_out_EXMem;
    wire Ex_reg_Mem_MemRW_out_EXMem;
    wire [1:0] Ex_reg_Mem_Jump_out_EXMem;
    wire [1:0] Ex_reg_Mem_MemtoReg_out_EXMem;
    wire Ex_reg_Mem_RegWrite_out_EXMem;
    wire Memory_Access_PCSrc;
    wire [31:0] Mem_reg_WB_PC4_out_MemWB;
    wire [4:0] Mem_reg_WB_Rd_addr_out_MemWB;
    wire [31:0] Mem_reg_WB_ALU_out_MemWB;
    wire [31:0] Mem_reg_WB_DMem_data_out_MemWB;
    wire [1:0] Mem_reg_WB_MemtoReg_out_MemWB;
    wire Mem_reg_WB_RegWrite_out_MemWB;
    wire [31:0] Write_Back_Data_out_WB;
    



    Pipeline_IF Instruction_Fetch (
        .clk_IF(clk),
        .rst_IF(rst),
        .en_IF(b1_dout),
        .PC_in_IF(Ex_reg_Mem_PC_out_EXMem),
        .PCSrc(Memory_Access_PCSrc),

        .PC_out_IF(Instruction_Fetch_PC_out_IF)
    );

    IF_reg_ID IF_reg_ID (
        .clk_IFID(clk),
        .rst_IFID(rst),
        .en_IFID(b1_dout),
        .PC_in_IFID(Instruction_Fetch_PC_out_IF),
        .inst_in_IFID(inst_IF),

        .PC_out_IFID(IF_reg_ID_PC_out_IFID),
        .inst_out_IFID(IF_reg_ID_inst_out_IFID)  
    );

    Pipeline_ID Instruction_Decoder (
        .clk_ID(clk),
        .rst_ID(rst),
        .RegWrite_in_ID(Mem_reg_WB_RegWrite_out_MemWB),
        .Rd_addr_ID(Mem_reg_WB_Rd_addr_out_MemWB),
        .Wt_data_ID(Write_Back_Data_out_WB),
        .Inst_in_ID(IF_reg_ID_inst_out_IFID),

        .Rd_addr_out_ID(Instruction_Decoder_Rd_addr_out_ID),
        .Rs1_out_ID(Instruction_Decoder_Rs1_out_ID),
        .Rs2_out_ID(Instruction_Decoder_Rs2_out_ID),
        .Imm_out_ID(Instruction_Decoder_Imm_out_ID),
        .ALUSrc_B_ID(Instruction_Decoder_ALUSrc_B_ID),
        .ALU_control_ID(Instruction_Decoder_ALU_control_ID),
        .Branch_ID(Instruction_Decoder_Branch_ID),
        .BranchN_ID(Instruction_Decoder_BranchN_ID),
        .MemRW_ID(Instruction_Decoder_MemRW_ID),
        .Jump_ID(Instruction_Decoder_Jump_ID),
        .MemtoReg_ID(Instruction_Decoder_MemtoReg_ID),
        .RegWrite_out_ID(Instruction_Decoder_RegWrite_out_ID)
    );

    ID_reg_Ex ID_reg_Ex(
        .clk_IDEX(clk),
        .rst_IDEX(rst),
        .en_IDEX(b1_dout),
        .PC_in_IDEX(IF_reg_ID_PC_out_IFID),
        .Rd_addr_IDEX(Instruction_Decoder_Rd_addr_out_ID),
        .Rs1_in_IDEx(Instruction_Decoder_Rs1_out_ID),
        .Rs2_in_IDEX(Instruction_Decoder_Rs2_out_ID),
        .Imm_in_IDEX(Instruction_Decoder_Imm_out_ID),
        .ALUSrc_B_in_IDEX(Instruction_Decoder_ALUSrc_B_ID),
        .ALU_control_in_IDEX(Instruction_Decoder_ALU_control_ID),
        .Branch_in_IDEX(Instruction_Decoder_Branch_ID),
        .BranchN_in_IDEX(Instruction_Decoder_BranchN_ID),
        .MemRW_in_IDEX(Instruction_Decoder_MemRW_ID),
        .Jump_in_IDEX(Instruction_Decoder_Jump_ID),
        .MemtoReg_in_IDEX(Instruction_Decoder_MemtoReg_ID),
        .RegWrite_in_IDEX(Instruction_Decoder_RegWrite_out_ID),

        .PC_out_IDEX(ID_reg_EX_PC_out_IDEX),
        .Rd_addr_out_IDEX(ID_reg_EX_Rd_addr_out_IDEX),
        .Rs1_out_IDEX(ID_reg_EX_Rs1_out_IDEX),
        .Rs2_out_IDEX(ID_reg_EX_Rs2_out_IDEX),
        .Imm_out_IDEX(ID_reg_EX_Imm_out_IDEX),
        .ALUSrc_B_out_IDEX(ID_reg_EX_ALUSrc_B_out_IDEX),
        .ALU_control_out_IDEX(ID_reg_EX_ALU_control_out_IDEX),
        .Branch_out_IDEX(ID_reg_EX_Branch_out_IDEX),
        .BranchN_out_IDEX(ID_reg_EX_BranchN_out_IDEX),
        .MemRW_out_IDEX(ID_reg_EX_MemRW_out_IDEX),
        .Jump_out_IDEX(ID_reg_EX_Jump_out_IDEX),
        .MemtoReg_out_IDEX(ID_reg_EX_MemtoReg_out_IDEX),
        .RegWrite_out_IDEX(ID_reg_EX_RegWrite_out_IDEX)
    );

    Pipeline_Ex Execute (
        .PC_in_EX(ID_reg_EX_PC_out_IDEX),
        .Rs1_in_EX(ID_reg_EX_Rs1_out_IDEX),
        .Rs2_in_EX(ID_reg_EX_Rs2_out_IDEX),
        .Imm_in_EX(ID_reg_EX_Imm_out_IDEX),
        .ALUSrc_B_in_EX(ID_reg_EX_ALUSrc_B_out_IDEX),
        .ALU_control_in_EX(ID_reg_EX_ALU_control_out_IDEX),
        
        .PC_out_EX(Execute_PC_out_EX),
        .PC4_out_EX(Execute_PC4_out_EX),
        .zero_out_EX(Execute_zero_out_EX),
        .ALU_out_EX(Execute_ALU_out_EX),
        .Rs2_out_EX(Execute_Rs2_out_EX)
    );

    Ex_reg_Mem Ex_reg_Mem(
        .clk_EXMem(clk),
        .rst_EXMem(rst),
        .en_EXMem(b1_dout),
        .Rd_addr_EXMem(ID_reg_EX_Rd_addr_out_IDEX),
        .PC_in_EXMem(Execute_PC_out_EX),
        .PC4_in_EXMem(Execute_PC4_out_EX),
        .zero_in_EXMem(Execute_zero_out_EX),
        .ALU_in_EXMem(Execute_ALU_out_EX),
        .Rs2_in_EXMem(Execute_Rs2_out_EX),
        .Branch_in_EXMem(ID_reg_EX_Branch_out_IDEX),
        .BranchN_in_EXMem(ID_reg_EX_BranchN_out_IDEX),
        .MemRW_in_EXMem(ID_reg_EX_MemRW_out_IDEX),
        .Junp_in_EXMem(ID_reg_EX_Jump_out_IDEX),
        .MemtoReg_in_EXMem(ID_reg_EX_MemtoReg_out_IDEX),
        .RegWrite_in_EXMem(ID_reg_EX_RegWrite_out_IDEX),
        
        .PC_out_EXMem(Ex_reg_Mem_PC_out_EXMem),
        .PC4_out_EXMem(Ex_reg_Mem_PC4_out_EXMem),
        .Rd_addr_out_EXMem(Ex_reg_Mem_Rd_addr_out_EXMem),
        .zero_out_EXMem(Ex_reg_Mem_zero_out_EXMem),
        .ALU_out_EXMem(Ex_reg_Mem_ALU_out_EXMem),
        .Rs2_out_EXMem(Ex_reg_Mem_Rs2_out_EXMem),
        .Branch_out_EXMem(Ex_reg_Mem_Branch_out_EXMem),
        .BranchN_out_EXMem(Ex_reg_Mem_BranchN_out_EXMem),
        .MemRW_out_EXMem(Ex_reg_Mem_MemRW_out_EXMem),
        .Jump_out_EXMem(Ex_reg_Mem_Jump_out_EXMem),
        .MemtoReg_out_EXMem(Ex_reg_Mem_MemtoReg_out_EXMem),
        .RegWrite_out_EXMem(Ex_reg_Mem_RegWrite_out_EXMem)
    );

    Pipeline_Mem Memory_Access (
        .zero_in_Mem(Ex_reg_Mem_zero_out_EXMem),
        .Branch_in_Mem(Ex_reg_Mem_Branch_out_EXMem),
        .BranchN_in_Mem(Ex_reg_Mem_BranchN_out_EXMem),
        .Jump_in_Mem(Ex_reg_Mem_Jump_out_EXMem),

        .PCSrc(Memory_Access_PCSrc)
    );

    Mem_reg_WB Mem_reg_WB(
        .clk_MemWB(clk),
        .rst_MemWB(rst),
        .en_MemWB(b1_dout),
        .DMem_data_MemWB(Data_in),
        .PC4_in_MemWB(Ex_reg_Mem_PC4_out_EXMem), 
        .Rd_addr_MemWB(Ex_reg_Mem_Rd_addr_out_EXMem),
        .ALU_in_MemWB(Ex_reg_Mem_ALU_out_EXMem),
        .MemtoReg_in_MemWB(Ex_reg_Mem_MemtoReg_out_EXMem),
        .RegWrite_in_MemWB(Ex_reg_Mem_RegWrite_out_EXMem),

        .PC4_out_MemWB(Mem_reg_WB_PC4_out_MemWB),
        .Rd_addr_out_MemWB(Mem_reg_WB_Rd_addr_out_MemWB),
        .ALU_out_MemWB(Mem_reg_WB_ALU_out_MemWB),
        .DMem_data_out_MemWB(Mem_reg_WB_DMem_data_out_MemWB),
        .MemtoReg_out_MemWB(Mem_reg_WB_MemtoReg_out_MemWB),
        .RegWrite_out_MemWB(Mem_reg_WB_RegWrite_out_MemWB)
    );

    Pipeline_WB Write_Back(
        .PC4_in_WB(Mem_reg_WB_PC4_out_MemWB),
        .ALU_in_WB(Mem_reg_WB_ALU_out_MemWB),
        .DMem_data_WB(Mem_reg_WB_DMem_data_out_MemWB),
        .MemtoReg_in_WB(Mem_reg_WB_MemtoReg_out_MemWB),

        .Data_out_WB(Write_Back_Data_out_WB)
    );

    assign Data_out_WB = Write_Back_Data_out_WB;
    assign MemRW_Mem = Ex_reg_Mem_MemRW_out_EXMem;
    assign MemRW_Ex = ID_reg_EX_MemRW_out_IDEX;
    assign Data_out = Ex_reg_Mem_Rs2_out_EXMem;
    assign Addr_out = Ex_reg_Mem_ALU_out_EXMem;
    assign PC_out_IF = Instruction_Fetch_PC_out_IF;
    assign PC_out_ID = IF_reg_ID_PC_out_IFID;
    assign PC_out_EX = Execute_PC_out_EX;
    assign inst_ID = IF_reg_ID_inst_out_IFID;





endmodule