module MUX24(
    input [1:0] s,
    input [31:0] l0,
    input [31:0] l1,
    input [31:0] l2,
    input [31:0] l3,
    output reg [31:0] out
);
always @(*) begin
    case(s) 
    2'b00: out <= l0;
    2'b01: out <= l1;
    2'b10: out <= l2;
    2'b11: out <= l3;
    endcase 
end
endmodule   