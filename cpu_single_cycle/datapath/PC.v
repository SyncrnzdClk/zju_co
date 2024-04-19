module PC(
    input clk,
    input rst,
    input CE,
    input [31:0] D,
    output reg [31:0] Q
);
    
initial Q = 32'b0;  

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Q <= 32'b0;
    end
    else if (CE) begin
        Q <= D;
    end
end

endmodule