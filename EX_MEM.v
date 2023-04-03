module EX_MEM(
    input [31:0] ALUResult,
    input [31:0] store_data,
    input [9:0] RegWriteAddr,
    input clk,
    input [4:0] control_signals_ip,
    input [14:0] registers,
    input [5:0] check_lw,
    output reg [31:0] ALUResult_mem,
    output reg [31:0] store_data_mem,
    output reg [9:0] RegWriteAddr_op,
    output reg [4:0] control_signals,
    output reg [14:0] registers_MEM,
    output reg [5:0] check_lw_MEM
);

always@(posedge clk) begin
    ALUResult_mem <= ALUResult;
    store_data_mem <= store_data;
    RegWriteAddr_op <= RegWriteAddr;
    control_signals <= control_signals_ip;
    registers_MEM <= registers;
    check_lw_MEM <= check_lw;
end

endmodule