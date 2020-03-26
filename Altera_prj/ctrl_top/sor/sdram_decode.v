module sdram_decode(
//system signal
input               s_clk                       ,
input               s_rst_n                     ,
//decode signal
input               flag_uart                   ,
input        [ 7:0] uart_data                   ,
output   wire       wfifo_wr_en                 ,
output   wire       rd_tring                    ,
output   wire       wr_tring                    ,
output   wire[ 7:0] wfifo_wr_data                  

);
/*==========================================================
* ************define parameter and internal signal**********
* =========================================================*/
parameter           CNT_DATA_END = 3'd4         ; 

//middle signal
reg   [ 2:0]            cnt_data                ;
reg   [ 7:0]            cmd_reg                 ;



/*==========================================================
* ************************main code*************************
* ==========================================================*/
//cnt_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_data <= 3'd0                    ;
        end       
        else if(flag_uart == 1'b1 && cnt_data == 3'd0 && uart_data == 8'haa)begin
            cnt_data <= 3'd0                    ;
        end
        else if(cnt_data == CNT_DATA_END && flag_uart == 1'b1)begin
            cnt_data <= 3'd0                    ;
        end
        else if(flag_uart == 1'b1)begin
            cnt_data <= cnt_data + 1'b1         ;
        end
        else begin
            cnt_data <= cnt_data                ;
        end
end

//cmd_reg
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cmd_reg <= 8'h00                    ;
        end
        else if(flag_uart == 1'b1 && cnt_data == 3'd0)begin
            cmd_reg <= uart_data                ;
        end       
        else begin
            cmd_reg <= cmd_reg                  ;
        end
end

assign   wfifo_wr_en   =   (cnt_data >= 3'd1)? flag_uart : 1'b0     ;
assign   wr_tring      =   (cnt_data == 3'd4 && cmd_reg == 8'h55)? flag_uart : 1'b0 ;
assign   rd_tring      =   (cnt_data == 3'd0 && uart_data == 8'haa)? flag_uart : 1'b0 ;
assign   wfifo_wr_data    =    uart_data       ;






endmodule
