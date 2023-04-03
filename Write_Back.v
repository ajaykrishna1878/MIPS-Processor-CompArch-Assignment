module Write_Back(
    input [9:0] RegWB,
    input [31:0] Mem_Read_Data_WB,
    input [31:0] Reg_File_Data_WB,
    input [2:0] control_signals_wb_ip,
    output [31:0] WriteBack,
    output [1:0] control_signals_wb,
    output [9:0] Reg_Addr_WB,
    output [31:0] WriteBackForwarded
);

// MemtoReg = control_signals_wb_ip[2]
assign WriteBack = control_signals_wb_ip[2] ? Reg_File_Data_WB : Mem_Read_Data_WB;
assign Reg_Addr_WB = RegWB;
assign control_signals_wb = control_signals_wb_ip[1:0];
assign WriteBackForwarded = control_signals_wb_ip[2] ? Reg_File_Data_WB : Mem_Read_Data_WB;

endmodule