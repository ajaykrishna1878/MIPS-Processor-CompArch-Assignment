module Forwarding_Unit(
    input [4:0] WB_Rt,
    input [4:0] Mem_Rd,
    input [4:0] Ex_Rt,
    input [4:0] Ex_Rs,
    input [4:0] ID_Rs,
    input [5:0] check_lw,
    output reg [1:0] Data1_Mux_Sel,
    output reg [1:0] Data2_Mux_Sel
);

initial begin
    Data1_Mux_Sel <= 2'b01;
    Data2_Mux_Sel <= 2'b01;
end

always@(Mem_Rd, Ex_Rt, WB_Rt) begin
    if(Mem_Rd == Ex_Rt) begin
        Data2_Mux_Sel <= 2'b00;
    end
    if((Ex_Rt == WB_Rt) && (check_lw != 6'b101000)) begin
        Data2_Mux_Sel <= 2'b01;
    end
    else if((Ex_Rt == WB_Rt) && (check_lw == 6'b101000)) begin
        Data2_Mux_Sel <= 2'b10;
    end
    if((Ex_Rt != Mem_Rd) && (Ex_Rt != WB_Rt)) begin
        Data2_Mux_Sel <= 2'b01;
    end
    if(Ex_Rs == Mem_Rd) begin
        Data1_Mux_Sel <= 2'b00;
    end
    if((Ex_Rs == WB_Rt) && (check_lw != 6'b101000)) begin
        Data1_Mux_Sel <= 2'b01;
    end
    else if((Ex_Rs == WB_Rt) && (check_lw == 6'b101000)) begin
        Data1_Mux_Sel <= 2'b10;
    end
    if((Ex_Rs != Mem_Rd) && (Ex_Rs != WB_Rt)) begin
        Data1_Mux_Sel <= 2'b01;
    end
end

endmodule
