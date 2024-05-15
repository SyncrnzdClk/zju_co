module ALU (
  input [31:0]  A,
  input [31:0]  B,
  input [3:0]   ALU_operation,
  output [31:0]  res,
  output        zero
);
reg [31:0] temp;
always @(ALU_operation) begin

case (ALU_operation)
            4'b0000: temp <= A&B; // and 0
            4'b0001: temp <= A|B; // or 1
            4'b0010: temp <= A+B; // add 2
            4'b1100: temp <= A^B; // xor c
            4'b0110: temp <= A-B; // sub 6
            4'b1101: temp <= A >> B[4:0]; // srl d
            4'b0111: temp <= $signed(A) < $signed(B) ? 1:0; // slt 7
            4'b1110: temp <= A << B[4:0]; // sll e
            4'b1111: temp <= A >>> B[4:0]; // sra f
            4'b1001: temp <= $unsigned(A) < $unsigned(B) ? 1:0; // sltu 9
  default : temp <= 0;
endcase
end
assign zero = temp == 0 ? 1 : 0 ;
assign res = temp;
endmodule