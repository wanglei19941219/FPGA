module ctrl_top(
//system  signal
input                       s_clk                   ,
input                       s_rst_n                 ,
//uart  siganl
input                       data_in                 ,
output  wire                data_out                ,
//sdram  diganl
output  wire                sdram_clk               ,
output  wire                sdram_cke               ,
output                      sdram_cs_n              ,
output  wire[11:0]          sdram_addr              ,
output  wire[ 1:0]          sdram_baddr             ,
output  wire                sdram_ras_n             ,
output  wire                sdram_cas_n             ,
output  wire                sdram_we_n              ,
output  wire[ 1:0]          sdram_dqm               ,
inout       [15:0]          sdram_data              

);
/*==========================================================
* ************define parameter and internal signal**********
* =========================================================*/
//rx_uart  to decode 
wire                        flag_uart               ; 
wire       [ 7:0]           uart_data               ;
//decode to  wfifo
wire                        wfifo_wr_en  /*synthesis keep*/            ; 
wire       [ 7:0]           wfifo_wr_data /*synthesis keep*/           ;
//decode to  sdram_ctrl
wire                        sdram_rd_tring /*synthesis keep*/         ; 
wire                        sdram_wr_tring  /*synthesis keep*/        ;
//wfifo  to sdram_ctrl
wire                        wfifo_rd_en     /*synthesis keep*/         ;
wire       [ 7:0]           wfifo_rd_data   /*synthesis keep*/         ;
wire                        wfifo_empty     /*synthesis keep*/         ;

//sdram_ctrl to rfifo
wire                        rfifo_wr_en    /*synthesis keep*/          ;
wire       [ 7:0]           rfifo_wr_data   /*synthesis keep*/         ;
//rfifo  to   tx_uart
wire                        rfifo_rd_en    /*synthesis keep*/          ;
wire       [ 7:0]           rfifo_rd_data   /*synthesis keep*/         ;
wire                        rfifo_empty     /*synthesis keep*/         ;


/*==========================================================
* ************************main code*************************
* ==========================================================*/
//sdram_clk

/*==========================================================
* ************************module inst************************
* ==========================================================*/
uart_rx uart_rx_inst(
.s_clk                     (s_clk         ),//系统时钟  50M
.s_rst_n                   (s_rst_n       ),//系统复位，地有效
.data_in                   (data_in       ),//pc机发送的数据
.data_rx                   (uart_data     ),//uart输出数据
.po_flag                   (flag_uart     ) //数据采集结束标志

);

sdram_decode sdram_decode_inst(
.s_clk                     (s_clk              ),
.s_rst_n                   (s_rst_n            ),
.flag_uart                 (flag_uart          ),
.uart_data                 (uart_data          ),
.wfifo_wr_en               (wfifo_wr_en        ),
.rd_tring                  (sdram_rd_tring     ),
.wr_tring                  (sdram_wr_tring     ),
.wfifo_wr_data             (wfifo_wr_data      )   

);

fifo	wfifo_inst (
.clock               (s_clk         ),
.data                (wfifo_wr_data ),
.rdreq               (wfifo_rd_en   ),
.wrreq               (wfifo_wr_en   ),
.empty               (wfifo_empty   ),
.q                   (wfifo_rd_data )
);


fifo	rfifo_inst (
.clock               (s_clk         ),
.data                (rfifo_wr_data ),
.rdreq               (rfifo_rd_en   ),
.wrreq               (rfifo_wr_en   ),
.empty               (rfifo_empty   ),
.q                   (rfifo_rd_data )
);



uart_tx uart_tx_inst(
.s_clk                     (s_clk         ),//50M系统时钟
.s_rst_n                   (s_rst_n       ),//系统复位
.rfifo_rd_data             (rfifo_rd_data ),//数据输入
.rfifo_empty               (rfifo_empty   ),
.data_tx                   (data_out      ),//并转串数据输出
.rfifo_rd_en               (rfifo_rd_en   )  
);

sdram_top sdram_top_inst(
.s_clk                     (s_clk         ),
.s_rst_n                   (s_rst_n       ),
.sdram_clk                 (sdram_clk     ),
.sdram_cke                 (sdram_cke     ),
.sdram_cs_n                (sdram_cs_n    ),
.sdram_addr                (sdram_addr    ),
.sdram_baddr               (sdram_baddr   ),
.sdram_ras_n               (sdram_ras_n   ),
.sdram_cas_n               (sdram_cas_n   ),
.sdram_we_n                (sdram_we_n    ),
.sdram_dqm                 (sdram_dqm     ),
.sdram_data                (sdram_data    ),
.wr_tring                  (sdram_wr_tring),
.rd_tring                  (sdram_rd_tring),
.wfifo_rd_data             (wfifo_rd_data ),                   
.wfifo_rd_en               (wfifo_rd_en   ),                      
.rfifo_wr_data             (rfifo_wr_data ),                
.rfifo_wr_en               (rfifo_wr_en   ),
.wfifo_empty               (wfifo_empty   )
);


endmodule
