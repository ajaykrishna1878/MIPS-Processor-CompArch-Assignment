module Instruction_Fetch(
    input clk,
    input reset,
    output [31:0] Instruction_Code
);
reg [31:0] PC;

Instruction_Memory IM(.PC(PC), .reset(reset), .Instruction_Code(Instruction_Code));

always@(posedge reset) PC <= 0;
always@(posedge clk) begin
    if(Instruction_Code[31:26] == 6'b0000010) PC <= {{6{Instruction_Code[25]}}, Instruction_Code[25:0]};
    else PC <= PC + 4;

end

endmodule