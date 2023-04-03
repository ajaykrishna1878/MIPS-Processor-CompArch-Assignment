module Decode(
    input clk,
    input reset,
    input [31:0] WD_Pipelined_recv, // write data from write back stage
    input [9:0] IC_Pipelined_recv, // write address from WB stage. Either [20:16] for LW or [15:11] for LSR RSR
    input [31:0] Instruction_Code,
    input [9:0] control_signals_ID,
    input [1:0] wb_control,
    output [9:0] IC_Pipelined_send, // send the reg num to be written into on write back
    output [31:0] Read_Data_1,
    output [31:0] Read_Data_2,
    output [31:0] lw_offset,
    output [8:0] control_signals // ALUSrc, ALUOp (3-bits), MemWrite, MemRead, MemtoReg, RegDst, RegWrite
);

Register_file rf(.Read_Reg_Num_1(Instruction_Code[25:21]), .Read_Reg_Num_2(Instruction_Code[20:16]), .Write_Reg_Num(wb_control[1] ? IC_Pipelined_recv[9:5] : IC_Pipelined_recv[4:0]),
                 .RegWrite(wb_control[0]), .RegRead(control_signals_ID[9]), .clk(clk), .reset(reset), .Write_Data(WD_Pipelined_recv), .Read_Data_1(Read_Data_1), .Read_Data_2(Read_Data_2));

assign control_signals = control_signals_ID[8:0];
assign lw_offset = {{16{Instruction_Code[15]}}, Instruction_Code[15:0]}; // sign extend and send load word offset to EXE
assign IC_Pipelined_send = Instruction_Code[20:11]; // send destination for lw and rsr/lsr to write back

endmodule