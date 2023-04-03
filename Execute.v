module Execute(
    input [31:0] Read_Data_1_ex,
    input [31:0] Read_Data_2_ex,
    input [31:0] lw_offset_op_ex,
    input [9:0] IC_send_ex,
    input [8:0] control_signals_EX,
    // forwarding unit inputs:
    input [1:0] ForwardRt,
    input [1:0] ForwardRs,
    input [31:0] WriteBackForwarded,
    input [31:0] MemoryForwarded,

    output [31:0] ALUResult,
    output [31:0] Mem_Data,
    output [9:0] IC_send_ex_op,
    output Zero,
    output [4:0] control_signals
);

wire [2:0] ALUOp;
wire ALUSrc;
reg [31:0] ALU_A_input;
reg [31:0] ALU_B_input;
wire [1:0] Data_Mux_Sel;
assign ALUOp = control_signals_EX[7:5];
assign ALUSrc = control_signals_EX[8];
assign control_signals = control_signals_EX[4:0];

/*
if(Data_Mux_Sel == 2'b00) assign ALU_B_input = control_signals_EX[8] ? lw_offset_op_ex : MemoryForwarded;
else if(Data_Mux_Sel == 2'b01) assign ALU_B_input = control_signals_EX[8] ? lw_offset_op_ex : Read_Data_2_ex;
else if(Data_Mux_Sel == 2'b10) assign ALU_B_input = control_signals_EX[8] ? lw_offset_op_ex : WriteBackForwarded;
*/

always@(*) begin
    case(ForwardRt)
        2'b00: ALU_B_input <= control_signals_EX[8] ? MemoryForwarded : lw_offset_op_ex;
        2'b01: ALU_B_input <= control_signals_EX[8] ? Read_Data_2_ex : lw_offset_op_ex;
        2'b10: ALU_B_input <= control_signals_EX[8] ? WriteBackForwarded : lw_offset_op_ex;
    endcase
    case(ForwardRs)
        2'b00: ALU_A_input <= MemoryForwarded;
        2'b01: ALU_A_input <= Read_Data_1_ex;
        2'b10: ALU_A_input <= WriteBackForwarded;
    endcase
end

ALU mips_alu(.A(ALU_A_input), .B(ALU_B_input), .shamt(5'b00000), .control_lines(ALUOp), .Zero(Zero), .result(ALUResult));

assign Mem_Data = Read_Data_2_ex;
assign IC_send_ex_op = IC_send_ex;

endmodule