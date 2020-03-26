`timescale   1 ns / 1 ns
module uart_rx_tb();
reg     s_clk                  ;
reg     s_rst_n                ;
reg     data_in                ;
wire   [ 7: 0] data_rx                ;
wire    po_flag                ;
reg  [ 7: 0]  mem_a[ 3: 0]     ;

parameter   CYCLE = 20  ;
parameter   RST_TIME = 3 ;

initial begin
    s_clk =1'b0    ;
    s_rst_n = 1'b1  ;
    data_in = 1'b1  ;
    #100           ;
    s_rst_n = 1'b0 ;
    #(CYCLE*RST_TIME);
    s_rst_n = 1'b1  ;
#100;
tx_byte();
end
always #(CYCLE/2)  s_clk  =  ~s_clk ;
initial $readmemh("./tx_data.txt",mem_a);

task tx_byte();
    integer i ;
    for(i=0;i<4;i=i+1)begin
        tx_bit(mem_a[i]);
    end
endtask

task tx_bit(
input [ 7: 0]   data
);
     integer j;
     for(j=0;j<10;j=j+1)begin
        case (j)
              
              0 :  data_in    =    1'b0   ;
              1 :  data_in    =    data[0];
              2 :  data_in    =    data[1];
              3 :  data_in    =    data[2];
              4 :  data_in    =    data[3];
              5 :  data_in    =    data[4];
              6 :  data_in    =    data[5];
              7 :  data_in    =    data[6];
              8 :  data_in    =    data[7];
              9 :  data_in    =    1'b1   ;
            
         endcase
         #104000;
     end



 endtask

 uart_rx   uart_rx_inst(
.s_clk                      (s_clk  ),
.s_rst_n                    (s_rst_n),
.data_in                    (data_in),
.data_rx                    (data_rx),
.po_flag                    (po_flag)

);






endmodule
