`timescale 1 ns / 1 ns
module iic_ctrl_tb();
reg             s_clk ;
reg             s_rst_n ;
reg             write_en ;
reg             read_en  ;
wire            i_clk    ;
wire [ 7:0]     led      ;
wire            sda      ;

/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter   CYCLE   =  20       ;
parameter   RST_TIME = 3        ;

/******************************************************************
* *************************** main   code *************************
* ****************************************************************/


initial begin
s_clk = 1'b1        ;
s_rst_n = 1'b1      ;
write_en= 1'b0      ;
read_en = 1'b0      ;
# (CYCLE*4)     ;
s_rst_n = 1'b0  ;
#(CYCLE*RST_TIME);
s_rst_n = 1'b1  ;
#(CYCLE*10) ;
write_en = 1'b1 ;
#(CYCLE);
write_en = 1'b0 ;
#500000    ;
read_en = 1'b1  ;
#(CYCLE);
read_en = 1'b0  ;
end

always #(CYCLE/2)  s_clk = ~s_clk   ;


iic_ctrl iic_ctrl_inst(
.s_clk           (s_clk        ),
.s_rst_n         (s_rst_n      ),
.write_en        (write_en     ),
.read_en         (read_en      ),
.i_clk           (i_clk        ),
.led             (led          ),
.sda             (sda          )
);

endmodule 
