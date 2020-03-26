`timescale  1 ns / 1 ns
module iic_write_tb();
reg             s_clk           ;
reg             s_rst_n         ;
reg             write_en        ;
wire            sda             ;
wire            c_clk           ;
wire            ack             ;

/****************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter       CYCLE   =   20      ;
parameter       RST_TIME =  3       ;


/****************************************************************
* *************************** main   code *************************
* ****************************************************************/
initial begin
s_clk = 1'b0        ;
s_rst_n = 1'b1      ;
write_en = 1'b0     ;
#(CYCLE*5)  ;
s_rst_n  = 1'b0     ;
#(CYCLE*RST_TIME)   ;
s_rst_n = 1'b1      ;
#(CYCLE*5)  ;
write_en = 1'b1 ;
#(CYCLE)    ;
write_en = 1'b0 ;
end

always #(CYCLE/2) s_clk = ~s_clk    ;


iic_write iic_write_inst(
//system signal   
.s_clk              (s_clk     ),
.s_rst_n            (s_rst_n   ),
//iic signal                            
.write_en           (write_en  ),
.sda                (sda       ),
.c_clk              (c_clk     ),
.ack                (ack       )
);












endmodule
