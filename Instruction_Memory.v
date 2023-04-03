module Instruction_Memory(
    input [31:0] PC,
    input reset,
    output [31:0] Instruction_Code
);

reg [7:0] Mem [23:0];

assign Instruction_Code = {Mem[PC], Mem[PC + 1], Mem[PC + 2], Mem[PC + 3]};

always @(posedge reset) begin
    Mem[0] = 8'ha1; Mem[1] = 8'h61; Mem[2] = 8'h00; Mem[3] = 8'h0c;
    Mem[4] = 8'hed; Mem[5] = 8'h02; Mem[6] = 8'h18; Mem[7] = 8'h00;
    Mem[8] = 8'hc8; Mem[9] = 8'h23; Mem[10] = 8'h10; Mem[11] = 8'h00;
    Mem[12] = 8'h08; Mem[13] = 8'h00; Mem[14] = 8'h00; Mem[15] = 8'h14;
    Mem[16] = 8'hec; Mem[17] = 8'hc6; Mem[18] = 8'h30; Mem[19] = 8'h00;
    Mem[20] = 8'hec; Mem[21] = 8'h65; Mem[22] = 8'h20; Mem[23] = 8'h00;
end

endmodule

/* instructions:
1.) 10100001 01100001 00000000 00001100 (A161000C) LW R1, R11, #12
    R1=Rt - 20:16, R11=Rs - 25:21
2.) 11101101 00000010 00011000 00000000 (ED021800) RSR R3, R8, R2
    R3 - 15:11, R2 - 20:16, R8 - 25:21; R3-Rd, R2-Rt, R8-Rs
3.) 11001000 00100011 00010000 00000000 (C8611000) LSR R2, R1, R3 (Ex_Rt == Mem_Rd, Ex_Rs == WB_Rd)
    R2 - 15:11, R1 - 25:21, R3 - 20:16; R2-Rd, R1-Rs, R3-Rt
4.) 00001000 00000000 00000000 00010100 (08000014) J L1
5.) 11101100 11000110 00110000 00000000 (ECC63000) RSR R6, R6, R6
6.) 11101100 01100101 00100000 00000000 (EC652000) RSR R4, R3, R5
    R4 - 15:11, R5 - 20:16, R3 - 25:21; R4-Rd, R5-Rt, R3-Rs

Check for RSR, LSR (R3):
if(Rd_Mem == Rt_Ex) ALU_B_ip = Mem_Forward; //(muxed with offset)

Check for LW, LSR (R1):
if(Rt_WB == Rt_Ex) ALU_B_ip = WB_Forward; //(muxed with offset)

*/