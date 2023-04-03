module MIPS_Processor(
    input clk,
    input reset
);

wire [31:0] Instruction_Code;
wire [31:0] IF_ID_op;
wire [9:0] IC_Pipelined_send;
wire [31:0] WD_From_WB;
wire [9:0] WReg_From_WB;
wire [31:0] rd1; wire [31:0] rd1_ex;
wire [31:0] rd2; wire [31:0] rd2_ex;
wire [31:0] lw_offset; wire [31:0] lw_offset_op;
wire [9:0] control_lines;
wire [8:0] control_signals_ID; wire [9:0] IC_send_ex_op;
wire [31:0] ALUResult; wire [31:0] Mem_Data;
wire [4:0] control_signals_MEM;
wire [31:0] ALUResult_mem; wire [31:0] store_data_mem;
wire [9:0] IC_Pipelined_send_ex;
wire [9:0] RegMem; wire [4:0] control_signals_m;
wire [31:0] Mem_Read_Data; wire [31:0] Reg_File_Data;
wire [2:0] control_signals_mem_op; wire [9:0] RegWB_wb;
wire [31:0] Mem_Read_Data_WB; wire [31:0] Reg_File_Data_WB;
wire [9:0] RegMem_wb; wire [2:0] control_signals_wb;
wire [1:0] CSWB; wire [31:0] writebacksignal; wire [9:0] Reg_Addr_WB;
wire [8:0] control_signals_EX; wire [14:0] registers_EX;
wire [31:0] WriteBackForwarded; wire [31:0] MemoryForwarded;
wire [1:0] Data2_Mux_Sel; wire [14:0] registers_MEM;
wire [14:0] registers_WB; wire [4:0] WB_Rt;
wire [1:0] Data1_Mux_Sel; wire [5:0] check_lw_EX_op;
wire [5:0] check_lw_WB; wire [5:0] check_lw_MEM_op;
assign WB_Rt = registers_WB[9:5];

Instruction_Fetch I_F(.clk(clk), .reset(reset), .Instruction_Code(Instruction_Code));
IF_ID if_id(.clk(clk), .Instruction_Code(Instruction_Code), .IF_ID_op(IF_ID_op));
// Instruction_Code is input, IF_ID_op is output
Main_Control_Unit mcu(.opcode(IF_ID_op[31:26]), .control_signals(control_lines));
Decode I_D(.clk(clk), .reset(reset), .WD_Pipelined_recv(WD_From_WB), .IC_Pipelined_recv(WReg_From_WB), .Instruction_Code(IF_ID_op), .control_signals_ID(control_lines), .wb_control(CSWB), .IC_Pipelined_send(IC_Pipelined_send), .Read_Data_1(rd1), .Read_Data_2(rd2), .lw_offset(lw_offset), .control_signals(control_signals_ID));
// WD_Pipelined_recv from WB stage, IC_Pipelined_recv is reg num from WB stage, control_signals (o/p) is [8:0]
ID_EX id_ex(.Read_Data_1(rd1), .Read_Data_2(rd2), .lw_offset(lw_offset), .IC_Pipelined_send(IC_Pipelined_send), .control_signals_ip(control_signals_ID), .clk(clk), .registers({IF_ID_op[25:21], IF_ID_op[20:16], IF_ID_op[15:11]}), .check_lw(IF_ID_op[31:26]), .RD1_op(rd1_ex), .RD2_op(rd2_ex), .lw_offset_op(lw_offset_op), .IC_send(IC_Pipelined_send_ex), .control_signals(control_signals_EX), .registers_EX(registers_EX), .check_lw_EX(check_lw_EX_op));
//
Forwarding_Unit fu(.WB_Rt(WB_Rt), .Mem_Rd(registers_MEM[4:0]), .Ex_Rt(registers_EX[9:5]), .Ex_Rs(registers_EX[14:10]), .check_lw(check_lw_WB), .Data1_Mux_Sel(Data1_Mux_Sel), .Data2_Mux_Sel(Data2_Mux_Sel));
//
Execute exe(.Read_Data_1_ex(rd1_ex), .Read_Data_2_ex(rd2_ex), .lw_offset_op_ex(lw_offset_op), .IC_send_ex(IC_Pipelined_send_ex), .control_signals_EX(control_signals_EX), .ForwardRt(Data2_Mux_Sel), .ForwardRs(Data1_Mux_Sel), .WriteBackForwarded(WriteBackForwarded), .MemoryForwarded(MemoryForwarded), .ALUResult(ALUResult), .Mem_Data(Mem_Data), .IC_send_ex_op(IC_send_ex_op), .Zero(Zero), .control_signals(control_signals_MEM));
//
EX_MEM ex_mem(.ALUResult(ALUResult), .store_data(Mem_Data), .RegWriteAddr(IC_send_ex_op), .clk(clk), .control_signals_ip(control_signals_MEM), .registers(registers_EX), .check_lw(check_lw_EX_op), .ALUResult_mem(ALUResult_mem), .store_data_mem(store_data_mem), .RegWriteAddr_op(RegMem), .control_signals(control_signals_m), .registers_MEM(registers_MEM), .check_lw_MEM(check_lw_MEM_op));
//
Memory mem(.Mem_Addr(ALUResult_mem), .Mem_Data(store_data_mem), .RegMem(RegMem), .reset(reset), .control_signals_MEM(control_signals_m), .Mem_Read_Data(Mem_Read_Data), .Reg_File_Data(Reg_File_Data), .control_signals(control_signals_mem_op), .RegWB(RegWB_wb), .MemoryForwarded(MemoryForwarded));
//
MEM_WB mem_wb(.Mem_Read_Data(Mem_Read_Data), .Reg_File_Data(Reg_File_Data), .RegMem(RegWB_wb), .registers(registers_MEM), .check_lw(check_lw_MEM_op), .clk(clk), .control_signals_ip(control_signals_mem_op), .Mem_Read_Data_WB(Mem_Read_Data_WB), .Reg_File_Data_WB(Reg_File_Data_WB), .RegWB(RegMem_wb), .control_signals(control_signals_wb), .registers_MEM(registers_WB), .check_lw_WB(check_lw_WB));
//
Write_Back wb(.RegWB(RegMem_wb), .Mem_Read_Data_WB(Mem_Read_Data_WB), .Reg_File_Data_WB(Reg_File_Data_WB), .control_signals_wb_ip(control_signals_wb), .WriteBack(WD_From_WB), .control_signals_wb(CSWB), .Reg_Addr_WB(WReg_From_WB), .WriteBackForwarded(WriteBackForwarded));

endmodule