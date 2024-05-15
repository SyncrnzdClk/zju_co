module Pipeline_IF(
    input wire clk_IF,
    input wire rst_IF,
    input wire en_IF,
    input wire [31:0] PC_in_IF,
    input wire PCSrc,
    output wire[31:0] PC_out_IF
);
    wire [31:0] Four_dout;
    assign Four_dout = 32'd4;
    wire [31:0] add_32_c;
    wire [31:0] MUX_o;
    wire [31:0] PC_out_Q; 
    add_32 add_32_0(
        .a(Four_dout),
        .b(PC_out_Q),
        .c(add_32_c)
    );
    REG32 PC(
        .clk(clk_IF),
        .rst(rst_IF),
        .CE(en_IF),
        .D(MUX_o),
        .Q(PC_out_Q)
    );
    assign MUX_o = (PCSrc == 1'b0) ? add_32_c : PC_in_IF;
    assign PC_out_IF = PC_out_Q;
endmodule