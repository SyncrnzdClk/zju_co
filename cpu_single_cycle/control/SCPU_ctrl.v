module SCPU_ctrl(
  input [4:0]       OPcode, 
  input [2:0]       Fun3,
  input             Fun7,
  input             MIO_ready,
  output reg [2:0]  ImmSel,
  output reg        ALUSrc_B,
  output reg [1:0]  MemtoReg,
  output reg [1:0]  Jump,
  output reg        Branch,
  output reg        BranchN,
  output reg        RegWrite,
  output reg        MemRW,
  output reg [3:0]  ALU_Control,
  output reg        CPU_MIO
);

  `define CPU_ctrl_signals {ALUSrc_B, MemtoReg, RegWrite, MemRW, Branch, BranchN, Jump, ALU_Control, ImmSel}
  wire [3:0] Fun;
  assign Fun = {Fun3, Fun7};
  always @* begin
    case(OPcode)
    5'b01100: // R
        case(Fun)
            4'b0000: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0010, 3'b0}; end // add
            4'b0001: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0110, 3'b0}; end // sub
            4'b0010: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1110, 3'b0}; end // sll
            4'b0100: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0111, 3'b0}; end // slt
            4'b0110: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1001, 3'b0}; end // sltu
            4'b1000: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1100, 3'b0}; end // xor
            4'b1010: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1101, 3'b0}; end // srl
            4'b1011: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1111, 3'b0}; end // sra
            4'b1100: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0001, 3'b0}; end // or
            4'b1110: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0000, 3'b0}; end // and
        endcase
    5'b00000: begin `CPU_ctrl_signals = {1'b1, 2'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0010, 3'b001}; end // load
    5'b01000: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b0, 4'b0010, 3'b010}; end // store
    5'b00100:  // addi, slti, ...
        case(Fun3)
            3'b000: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0010, 3'b001}; end // addi
            3'b010: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0111, 3'b001}; end // slti
            3'b011: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1001, 3'b001}; end // sltiu
            3'b100: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1100, 3'b001}; end // xori
            3'b110: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0001, 3'b001}; end // ori
            3'b111: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0000, 3'b001}; end // andi
            3'b001: begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1110, 3'b001}; end // slli
            3'b101: 
            begin 
                if (Fun7 == 1'b0) begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1101, 3'b001}; end // srli
                else if (Fun7 == 1'b1) begin `CPU_ctrl_signals = {1'b1, 2'b0, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b1111, 3'b001}; end // srai 
            end
        endcase
    5'b11000: // B
        case(Fun3) 
        3'b000: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b0, 1'b0, 1'b1, 1'b0, 2'b0, 4'b0110, 3'b011}; end // beq
        3'b001: begin `CPU_ctrl_signals = {1'b0, 2'b0, 1'b0, 1'b0, 1'b0, 1'b1, 2'b0, 4'b0110, 3'b011}; end // bne
        endcase
    5'b11011: begin `CPU_ctrl_signals = {1'b0, 2'b10, 1'b1, 1'b0, 1'b0, 1'b0, 2'b1, 4'b0, 3'b100}; end // jal
    5'b11001: begin `CPU_ctrl_signals = {1'b1, 2'b10, 1'b1, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0010, 3'b001}; end //jalr
    5'b01101: begin `CPU_ctrl_signals = {1'b0, 2'b11, 1'b1, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0, 3'b000}; end // lui
    default: begin `CPU_ctrl_signals = {1'b0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 2'b0, 4'b0, 3'b000}; end 

        endcase 
        CPU_MIO = MIO_ready;
  end
  

endmodule
