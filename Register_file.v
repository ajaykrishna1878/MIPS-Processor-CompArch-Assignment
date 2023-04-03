module Register_file(
    input [4:0] Read_Reg_Num_1,
    input [4:0] Read_Reg_Num_2,
    input [4:0] Write_Reg_Num,
    input [31:0] Write_Data,
    input RegWrite,
    input RegRead,
    input clk,
    input reset,
    output reg [31:0] Read_Data_1,
    output reg [31:0] Read_Data_2
);

reg [31:0] RegMem [31:0];
integer i;

/*
always@(reset) begin
    if (reset == 1) begin
        for(i = 0; i < 32; i = i + 8) begin
            RegMem[i] = 32'h0001a443; RegMem[i + 1] = 32'h000414bf;
            RegMem[i + 2] = 32'h7538a112; RegMem[i + 3] = 32'h00000000;
            RegMem[i + 4] = 32'h0033c14d; RegMem[i + 5] = 32'h01000189;
            RegMem[i + 6] = 32'h81f8cd22; RegMem[i + 7] = 32'h000bbaab;
        end
    end
end
*/

always@(reset) begin
    if (reset == 1) begin
        for(i = 0; i < 32; i = i + 8) begin
            RegMem[i] = 32'h00000000; RegMem[i + 1] = 32'h00000000;
            RegMem[i + 2] = 32'h00000000; RegMem[i + 3] = 32'h00000000;
            RegMem[i + 4] = 32'h00000000; RegMem[i + 5] = 32'h00000000;
            RegMem[i + 6] = 32'h00000000; RegMem[i + 7] = 32'h00000000;
        end
    end
end

always@(posedge clk) begin
    if (RegWrite == 1) RegMem[Write_Reg_Num] <= Write_Data;
end
always@(negedge clk) begin
    if(RegRead == 1) begin
        Read_Data_1 <= RegMem[Read_Reg_Num_1];
        Read_Data_2 <= RegMem[Read_Reg_Num_2];
    end
end
endmodule