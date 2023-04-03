module ALU(
    input [31:0] A,
    input [31:0] B,
    input [4:0] shamt,
    input [2:0] control_lines,
    output reg Zero,
    output reg [31:0] result
);

always@(control_lines, A, B, shamt) begin
    case(control_lines)
        3'b000 : result = A + B;
        //3'b001 : result = A - B;
        //3'b010 : result = A & B;
        //3'b011 : result = A | B;
        3'b100 : result = A << B;
        3'b101 : result = A >> B;
        default : result = A;
    endcase
    Zero = (result == 0) ? 1 : 0;
end

endmodule