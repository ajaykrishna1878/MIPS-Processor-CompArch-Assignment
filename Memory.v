module Memory(
    input [31:0] Mem_Addr,
    input [31:0] Mem_Data,
    input [9:0] RegMem,
    input reset,
    input [4:0] control_signals_MEM,
    output [31:0] Mem_Read_Data,
    output [31:0] Reg_File_Data,
    output [2:0] control_signals,
    output [9:0] RegWB,
    output [31:0] MemoryForwarded
);

wire MemRead;
wire MemWrite;
assign MemRead = control_signals_MEM[4];
assign MemWrite = control_signals_MEM[3];
assign control_signals = control_signals_MEM[2:0];
assign MemoryForwarded = Mem_Addr;

Memory_File mf(.Addr(Mem_Addr), .WriteData(Mem_Data), .MemRead(MemRead), .MemWrite(MemWrite), .reset(reset), .ReadData(Mem_Read_Data));

assign Reg_File_Data = Mem_Addr;
assign RegWB = RegMem;

endmodule