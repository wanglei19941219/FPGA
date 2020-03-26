module dac_top(
//system signal
input                   s_clk           ,
input                   s_rst_n         ,
//module signal
output                  spi_clk         ,
output                  spi_cs_n        ,
output                  mosi            

);

/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
wire[ 9:0]              data_in         ;



 dac_data dac_data_inst(
.s_clk                           (s_clk       ),
.s_rst_n                         (s_rst_n     ),
.dac_data                        (data_in     )

);

dac_ctrl dac_ctrl_inst(
.s_clk                           (s_clk       ),//50MHZ    
.s_rst_n                         (s_rst_n     ),
.data_in                         (data_in     ),
.spi_clk                         (spi_clk     ),//12.5MHZ  
.mosi                            (mosi        ),
.spi_cs_n                        (spi_cs_n    )

);

endmodule

