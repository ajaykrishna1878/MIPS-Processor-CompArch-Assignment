module Memory_File(
    input [31:0] Addr,
    input [31:0] WriteData,
    input MemRead,
    input MemWrite,
    input reset,
    output reg [31:0] ReadData
);

reg [7:0] DataMem [0:159];
integer i;
always@(posedge reset) begin
    for(i = 0; i < 32; i = i + 8) begin
        DataMem[i] = 8'h01; DataMem[i + 1] = 8'h1c; DataMem[i + 2] = 8'h04; DataMem[i + 3] = 8'hee;
        DataMem[i + 4] = 8'h31; DataMem[i + 5] = 8'h42; DataMem[i + 6] = 8'hdf; DataMem[i + 7] = 8'hcc;
    end
end

always@(MemWrite, MemRead) begin
    if(MemRead == 1) ReadData <= {DataMem[Addr], DataMem[Addr + 1], DataMem[Addr + 2], DataMem[Addr + 3]};
    if(MemWrite == 1) DataMem[Addr] <= WriteData;
end

endmodule