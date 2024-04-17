module MUX2T1_32(
    input wire [31:0] I0,
    input wire [31:0] I1,
    input s,
    output wire [31:0] o
);

    assign o = (s == 1'b0) ? I0 : I1;

    
endmodule