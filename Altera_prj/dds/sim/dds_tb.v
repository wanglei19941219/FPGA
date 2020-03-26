`timescale 1 ns /1 ns

module dds_tb();
reg               s_clk           ;
reg               s_rst_n         ;
wire [ 7:0]       sin_data        ;

initial begin
s_clk = 1'b0 ;
s_rst_n = 1'b1;
#60;
s_rst_n = 1'b0    ;
#60;
s_rst_n  = 1'b1   ;
end


always #10 s_clk = ~s_clk ;


dds dds_inst(
.s_clk          (s_clk),
.s_rst_n        (s_rst_n),
.sin_data       (sin_data)

);
endmodule
