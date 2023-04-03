module ID_EX(
    input [31:0] Read_Data_1,
    input [31:0] Read_Data_2,
    input [31:0] lw_offset,
    input [9:0] IC_Pipelined_send,
    input [8:0] control_signals_ip,
    input clk,
    input [14:0] registers,
    input [5:0] check_lw,
    output reg [31:0] RD1_op,
    output reg [31:0] RD2_op,
    output reg [31:0] lw_offset_op,
    output reg [9:0] IC_send,
    output reg [8:0] control_signals,
    output reg [14:0] registers_EX,
    output reg [5:0] check_lw_EX
);

always@(posedge clk) begin
    RD1_op <= Read_Data_1;
    RD2_op <= Read_Data_2;
    lw_offset_op <= lw_offset;
    IC_send <= IC_Pipelined_send;
    control_signals <= control_signals_ip;
    registers_EX <= registers;
    check_lw_EX <= check_lw;
end

endmodule