// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Tue Mar  5 18:10:29 2024
// Host        : LAPTOP-6G31RL0V running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub E:/FPGA/ip/Ex_reg_Mem.v
// Design      : Ex_reg_Mem
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module Ex_reg_Mem(clk_EXMem, rst_EXMem, en_EXMem, PC_in_EXMem, 
  PC4_in_EXMem, Rd_addr_EXMem, zero_in_EXMem, ALU_in_EXMem, Rs2_in_EXMem, Branch_in_EXMem, 
  BranchN_in_EXMem, MemRW_in_EXMem, Junp_in_EXMem, MemtoReg_in_EXMem, RegWrite_in_EXMem, 
  PC_out_EXMem, PC4_out_EXMem, Rd_addr_out_EXMem, zero_out_EXMem, ALU_out_EXMem, 
  Rs2_out_EXMem, Branch_out_EXMem, BranchN_out_EXMem, MemRW_out_EXMem, Jump_out_EXMem, 
  MemtoReg_out_EXMem, RegWrite_out_EXMem)
/* synthesis syn_black_box black_box_pad_pin="clk_EXMem,rst_EXMem,en_EXMem,PC_in_EXMem[31:0],PC4_in_EXMem[31:0],Rd_addr_EXMem[4:0],zero_in_EXMem,ALU_in_EXMem[31:0],Rs2_in_EXMem[31:0],Branch_in_EXMem,BranchN_in_EXMem,MemRW_in_EXMem,Junp_in_EXMem,MemtoReg_in_EXMem[1:0],RegWrite_in_EXMem,PC_out_EXMem[31:0],PC4_out_EXMem[31:0],Rd_addr_out_EXMem[4:0],zero_out_EXMem,ALU_out_EXMem[31:0],Rs2_out_EXMem[31:0],Branch_out_EXMem,BranchN_out_EXMem,MemRW_out_EXMem,Jump_out_EXMem,MemtoReg_out_EXMem[1:0],RegWrite_out_EXMem" */;
  input clk_EXMem;
  input rst_EXMem;
  input en_EXMem;
  input [31:0]PC_in_EXMem;
  input [31:0]PC4_in_EXMem;
  input [4:0]Rd_addr_EXMem;
  input zero_in_EXMem;
  input [31:0]ALU_in_EXMem;
  input [31:0]Rs2_in_EXMem;
  input Branch_in_EXMem;
  input BranchN_in_EXMem;
  input MemRW_in_EXMem;
  input [1:0] Junp_in_EXMem;
  input [1:0]MemtoReg_in_EXMem;
  input RegWrite_in_EXMem;
  output reg [31:0]PC_out_EXMem;
  output reg [31:0]PC4_out_EXMem;
  output reg [4:0]Rd_addr_out_EXMem;
  output reg zero_out_EXMem;
  output reg [31:0]ALU_out_EXMem;
  output reg [31:0]Rs2_out_EXMem;
  output reg Branch_out_EXMem;
  output reg BranchN_out_EXMem;
  output reg MemRW_out_EXMem;
  output reg [1:0] Jump_out_EXMem;
  output reg [1:0]MemtoReg_out_EXMem;
  output reg RegWrite_out_EXMem;
  always @(posedge clk_EXMem or posedge rst_EXMem) begin
    if(rst_EXMem) begin 
        PC_out_EXMem <= 32'b0;
        PC4_out_EXMem <= 32'b0;
        Rd_addr_out_EXMem <= 5'b0;
        zero_out_EXMem <= 1'b0;
        ALU_out_EXMem <= 32'b0;
        Rs2_out_EXMem <= 32'b0;
        Branch_out_EXMem <= 1'b0;
        BranchN_out_EXMem <= 1'b0;
        MemRW_out_EXMem <= 1'b0;
        Jump_out_EXMem <= 1'b0;
        MemtoReg_out_EXMem <= 2'b0;
        RegWrite_out_EXMem <= 1'b0;
        end
        else if(en_EXMem == 1'b1) begin
        PC_out_EXMem <= PC_in_EXMem;
        PC4_out_EXMem <= PC4_in_EXMem;
        Rd_addr_out_EXMem <= Rd_addr_EXMem;
        zero_out_EXMem <= zero_in_EXMem;
        ALU_out_EXMem <= ALU_in_EXMem;
        Rs2_out_EXMem <= Rs2_in_EXMem;
        Branch_out_EXMem <= Branch_in_EXMem;
        BranchN_out_EXMem <= BranchN_in_EXMem;
        MemRW_out_EXMem <= MemRW_in_EXMem;
        Jump_out_EXMem <= Junp_in_EXMem;
        MemtoReg_out_EXMem <= MemtoReg_in_EXMem;
        RegWrite_out_EXMem <= RegWrite_in_EXMem;
    end
  end
endmodule
