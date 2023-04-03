module Main_Control_Unit(
    input [5:0] opcode,
    output reg [9:0] control_signals
);

always@(opcode) begin
    case(opcode)
    6'b101000: control_signals <= 10'b1000010011; // lw - 213
    6'b100011: control_signals <= 10'b1000001010; // sw - 20a
    6'b110010: control_signals <= 10'b1110000101; // lsr - 385
    6'b111011: control_signals <= 10'b1110100101; // rsr - 3a5
    6'b000010: control_signals <= 10'b0011100000; // j - 0
    endcase
end

endmodule

// RegRead-9, ALUSrc-8, ALUOp-7:5, MemRead-4, MemWrite-3, MemtoReg-2, RegDst-1, RegWrite-0