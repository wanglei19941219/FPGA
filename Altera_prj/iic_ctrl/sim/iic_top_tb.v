module iic_top_tb();
reg                 s_clk       ;
reg                 s_rst_n     ;
reg                 key_in1     ;
reg                 key_in2     ;
wire                i_clk       ;
wire  [ 7:0]        led         ;
wire                sda         ;


/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter           CYCLE       =       20          ;
parameter           RST_TIME    =       3           ;

/******************************************************************
* *************************** main   code *************************
* ****************************************************************/

initial begin
s_clk  =  1'b1      ;
s_rst_n = 1'b1      ;
key_in1 = 1'b1      ;
key_in2 = 1'b1      ;
#(CYCLE*2);
s_rst_n = 1'b0      ;
#(CYCLE*RST_TIME)   ;
s_rst_n = 1'b1      ;
#(CYCLE*10);
key_in1 = 1'b0      ;
#(CYCLE*20);
key_in1 = 1'b1      ;
#500000;
key_in2 = 1'b0      ;
#(CYCLE*20);
key_in2 = 1'b1      ;
end

always #(CYCLE/2)  s_clk = ~s_clk   ;




iic_top iic_top_inst(
.s_clk                    (s_clk       ),
.s_rst_n                  (s_rst_n     ),
.key_in1                  (key_in1     ),
.key_in2                  (key_in2     ),
.i_clk                    (i_clk       ),
.led                      (led         ),
.sda                      (sda         )
);




endmodule
