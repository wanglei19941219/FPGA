`timescale   1 ns / 1 ns
module uart_rx_tb();
reg            s_clk                  ;
reg            s_rst_n                ;
reg  [ 7: 0]   data_in                ;
wire           data_tx                ;
wire           end_flag               ;
reg            po_flag                ;

parameter   CYCLE = 20  ;
parameter   RST_TIME = 3 ;

initial begin
    s_clk =1'b0    ;
    s_rst_n = 1'b1  ;
    data_in = 8'h00  ;
    #100           ;
    s_rst_n = 1'b0 ;
    #(CYCLE*RST_TIME);
    s_rst_n = 1'b1  ;
    #10;
    po_flag = 1'b1  ;
    data_in = 8'd245 ;
    #1000000;
    $stop    ;
end
always #(CYCLE/2)  s_clk  =  ~s_clk ;


       



 uart_tx   uart_tx_inst(
.s_clk                      (s_clk   ),
.s_rst_n                    (s_rst_n ),
.data_in                    (data_in ),
.data_tx                    (data_tx ),
.po_flag                    (po_flag ),
.end_flag                   (end_flag)

);






endmodule

