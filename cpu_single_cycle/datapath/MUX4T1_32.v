module MUX4T1_32(
    input wire [1:0] s,
    input wire [31:0] I0,
    input wire [31:0] I1,
    input wire [31:0] I2,
    input wire [31:0] I3,
    output wire [31:0] o   
);

reg [31:0] out;
always@(*) begin
    case(s)
    2'b00: out <= I0;
    2'b01: out <= I1;
    2'b10: out <= I2;
    2'b11: out <= I3;
endcase
end

assign o = out;
endmodule