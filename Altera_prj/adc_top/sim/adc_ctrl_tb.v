module adc_ctrl_tb();
//system signal
reg                     s_clk           ;
reg                     s_rst_n         ;
//module signal
reg                     adc_en          ;
reg                     adc_out         ;
wire                    adc_clk         ;
wire                    adc_cs_n        ;
wire  [ 7:0]            dout            ;
wire                    con_ok          ;


/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter               CYCLE       =   20      ;
parameter               RST_TM      =   3       ;

/******************************************************************
* *************************** main   code *************************
* ****************************************************************/

initial begin
s_clk = 1'b0            ;
s_rst_n = 1'b1            ;
adc_en= 1'b0            ;
adc_out= 1'b0           ;
#(CYCLE * 2);
s_rst_n= 1'b0           ;
#(CYCLE * RST_TM);
s_rst_n=1'b1            ;
#(CYCLE * 10);
adc_en = 1'b1           ;
adc_out=1'b1            ;
#(CYCLE);
adc_en = 1'b0       ;
#(CYCLE * 350)      ;
adc_out = 1'b0      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;
#(CYCLE * 250)      ;
adc_out = 1'b0      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;
#(CYCLE * 250)      ;
adc_out = 1'b0      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;
#(CYCLE * 250)      ;
adc_out = 1'b0      ;

#30000;
adc_en = 1'b1       ;
adc_out=1'b1        ;
#(CYCLE);
adc_en = 1'b0       ;
#(CYCLE * 250)      ;
adc_out = 1'b0      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;
#(CYCLE * 250)      ;
adc_out = 1'b0      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;
#(CYCLE * 250)      ;
adc_out = 1'b1      ;

end


always #(CYCLE/2)       s_clk = ~s_clk      ;







adc_ctrl adc_ctrl_inst(
//system signal
.s_clk                 (s_clk           ),//50MHZ
.s_rst_n               (s_rst_n         ),
//module signal
.adc_en                (adc_en          ),
.adc_out               (adc_out         ),
.adc_clk               (adc_clk         ),//400KHZ
.adc_cs_n              (adc_cs_n        ),
.dout                  (dout            ),
.con_ok                (con_ok          )

);

endmodule
