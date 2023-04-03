module MEM_WB(
    input [31:0] Mem_Read_Data,
    input [31:0] Reg_File_Data,
    input [9:0] RegMem,
    input [14:0] registers,
    input [5:0] check_lw,
    input clk,
    input [2:0] control_signals_ip,
    output reg [31:0] Mem_Read_Data_WB,
    output reg [31:0] Reg_File_Data_WB,
    output reg [9:0] RegWB,
    output reg [2:0] control_signals,
    output reg [14:0] registers_MEM,
    output reg [5:0] check_lw_WB
);

always@(posedge clk) begin
    Mem_Read_Data_WB <= Mem_Read_Data;
    Reg_File_Data_WB <= Reg_File_Data;
    RegWB <= RegMem;
    control_signals <= control_signals_ip;
    registers_MEM <= registers;
    check_lw_WB <= check_lw;
end

endmodule