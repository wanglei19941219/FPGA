module dac_ctrl_tb();
reg                 s_clk       ;
reg                 s_rst_n     ;
reg  [ 9:0]         data_in     ;
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
data_in = 10'd0     ;
#(CYCLE*6)      ;
s_rst_n = 1'b0      ;
#(CYCLE*RST_TIME)   ;
s_rst_n = 1'b1      ;
#(CYCLE*8)      ;
data_in = 10'd1000 ;
end

always # (CYCLE/2)  s_clk = ~s_clk ;


dac_ctrl dac_ctrl_inst(
.s_clk              (s_clk       ),//50MHZ    
.s_rst_n            (s_rst_n     ),
.data_in            (data_in     ),
.spi_clk            (spi_clk     ),//12.5MHZ  
.mosi               (mosi        ),
.spi_cs_n           (spi_cs_n    )

);



endmodule 
