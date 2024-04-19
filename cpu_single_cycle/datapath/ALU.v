module ALU (
  input [31:0]  A,
  input [31:0]  B,
  input [3:0]   ALU_operation,
  output [31:0]  res,
  output        zero
);
reg [31:0] temp;
always @(*) begin

case (ALU_operation)
  4'd0 : begin
    temp = A & B;
  end
  4'd1 : begin
    temp = A | B;
  end
  4'd2 : begin
    temp = A + B;
  end
  4'd3 : begin
    temp = A ^ B;
  end
  4'd4 : begin
    temp = ~(A | B);
  end
  4'd5 : begin
    temp = A >> B[3:0];
  end
  4'd6 : begin
    temp = A - B;
  end
  4'd7 : begin
    temp = $unsigned(A) < $unsigned(B) ? 1 : 0;
  end
  4'd9 : begin
    temp = $signed(A) <$signed(B) ? 1 : 0;
  end
  4'd14 : begin
    temp = A << B[3:0];
  end
  4'd15 : begin //sra
    temp = A >>> B[3:0];
  end
  default : temp = 0;
endcase
end
assign zero = temp == 0 ? 1 : 0 ;
assign res = temp;
endmodule