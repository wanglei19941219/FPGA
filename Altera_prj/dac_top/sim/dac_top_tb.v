module dac_top_tb();
reg                 s_clk       ;
reg                 s_rst_n     ;
wire                spi_clk     ;
wire                mosi        ;
wire                spi_cs_n    ;

/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter           CYCLE   =    20     ;
parameter           RST_TIME =   3      ;        

/******************************************************************
* *************************** main   code *************************
* ****************************************************************/

initial begin
s_clk = 1'b0        ;
s_rst_n = 1'b1      ;
#(CYCLE*6)      ;
s_rst_n = 1'b0      ;
#(CYCLE*RST_TIME)   ;
s_rst_n = 1'b1      ;
end

always # (CYCLE/2)  s_clk = ~s_clk ;


dac_top dac_top_inst(
.s_clk               (s_clk         ),
.s_rst_n             (s_rst_n       ),
.spi_clk             (spi_clk       ),
.spi_cs_n            (spi_cs_n      ),
.mosi                (mosi          )

);



endmodule 

