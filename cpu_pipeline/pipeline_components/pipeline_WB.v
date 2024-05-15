module Pipeline_WB(
    input [1:0] MemtoReg_in_WB,
    input [31:0] ALU_in_WB,
    input [31:0] DMem_data_WB,
    input [31:0] PC4_in_WB,
    output reg [31:0] Data_out_WB   
);
always @(MemtoReg_in_WB) begin
    case(MemtoReg_in_WB)
        2'b00: Data_out_WB <= ALU_in_WB;
        2'b01: Data_out_WB <= DMem_data_WB;
        2'b10: Data_out_WB <= PC4_in_WB;
        2'b11: Data_out_WB <= PC4_in_WB;
    endcase
end
endmodule