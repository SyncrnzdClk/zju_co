module REG32(
    input clk,
    input rst,
    input CE,
    input wire [31:0] D,
    output [31:0] Q
);
    reg [31:0] temp = 0;
    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) temp <= 32'b0;
        else if (CE == 1'b1) temp <= D;
    end
    assign Q = temp;
endmodule