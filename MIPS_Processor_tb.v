`timescale 10us / 10ns

module MIPS_Processor_tb;

reg clk; reg reset;
MIPS_Processor mips(.clk(clk), .reset(reset));

initial begin
    reset = 1;
    clk = 1;    
    repeat(5000) begin
        #1 clk = ~clk;
    end
end

endmodule
