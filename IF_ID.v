module IF_ID(
    input clk,
    input [31:0] Instruction_Code,
    output reg [31:0] IF_ID_op
);

always@(posedge clk) IF_ID_op <= Instruction_Code;

endmodule