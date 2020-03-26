module uart_rx(
input                      s_clk             ,//系统时钟  50M
input                      s_rst_n           ,//系统复位，地有效
input                      data_in           ,//pc机发送的数据
output reg   [7:0]         data_rx           ,//uart输出数据
output reg                 po_flag            //数据采集结束标志

);
//参数定义
parameter    BAND_END       =   5207         ;//一波特计数
parameter    HALF_BAND_END  =   2603         ;//半波特计数

//中间变量定义
 
reg          [12: 0 ]       band_cnt          ;//波特计数器
reg          [ 3: 0 ]       bit_cnt           ;//比特计数器
reg                         half_band_flag    ;//半波特标志信号
reg                         data_in_1         ;//接收数据打一拍
reg                         data_in_2         ;//接收数据打两拍
reg                         data_in_3         ;//接收数据打三拍
reg                         data_rx_flag      ;//数据开始接受标志信号
wire                        rx_nege           ;//下降沿标志信号


/*-----------------------------------------------------------------------
---------------------main  core------------------------------------------
-------------------------------------------------------------------------*/


//波特计数器
always @(posedge s_clk or negedge s_rst_n)begin
    if(!s_rst_n)begin
        band_cnt <=  13'd0                    ;//复位计数器
    end 
    else if(band_cnt==BAND_END||rx_nege == 1'b1|| data_rx_flag == 1'b0 )begin
        band_cnt <=  13'd0                    ;//计满5208，清零
    end
    else begin
        band_cnt <=  band_cnt + 1'b1          ;//使能信号为低时开始加一
    end
end
//比特计数器
always @(posedge s_clk or negedge s_rst_n )begin
    if(!s_rst_n )begin
        bit_cnt  <=  4'd0                     ;
    end
    else if(bit_cnt == 4'd8 && half_band_flag == 1'b1)begin
        bit_cnt  <=  4'd0                     ;
    end
    else if(half_band_flag ==1'b1)begin
        bit_cnt  <=  bit_cnt  +  1'b1         ;
    end
    else begin
        bit_cnt  <=  bit_cnt                  ;
    end
end
//半波特标志信号
always @(posedge s_clk or negedge s_rst_n)begin
    if(!s_rst_n)begin
        half_band_flag  <=  1'b0              ;
    end
    else if(band_cnt == HALF_BAND_END)begin
        half_band_flag  <=  1'b1              ;
    end
    else begin
        half_band_flag  <=  1'b0              ;
    end
end

//数据data_in同步
always @(posedge s_clk or negedge s_rst_n )begin
        if(!s_rst_n )begin
            data_in_1   <=    1'b0            ;
        end
        else begin
            data_in_1   <=    data_in         ;
        end
end

always @(posedge s_clk or negedge s_rst_n )begin
        if(!s_rst_n )begin
            data_in_2   <=    1'b0            ;
        end
        else begin
            data_in_2   <=    data_in_1       ;
        end
end

always @(posedge s_clk or negedge s_rst_n )begin
        if(!s_rst_n )begin
            data_in_3   <=    1'b0            ;
        end
        else begin
            data_in_3   <=    data_in_2       ;
        end
end

//数据采集结束标志信号
always @(posedge s_clk or negedge s_rst_n )begin
        if(!s_rst_n )begin
            po_flag     <=    1'b0            ;
        end
        else if(bit_cnt == 4'd8 && half_band_flag == 1'b1 )begin
            po_flag     <=    1'b1            ;
        end
        else begin
            po_flag     <=    1'b0            ;
        end
end

//下降沿标志信号赋值
assign  rx_nege     =    data_in_3  &  (~data_in_2)     ;

//开始接受数据标志信号
always @(posedge s_clk or negedge s_rst_n )begin
        if(!s_rst_n)begin            
            data_rx_flag <=    1'b0             ;
        end
        else if(rx_nege == 1'b1)begin
            data_rx_flag <=    1'b1             ;
        end
        else if(bit_cnt == 1'b0 & band_cnt == BAND_END)begin
            data_rx_flag <=    1'b0             ;
        end
        else begin
            data_rx_flag <= data_rx_flag        ;
        end
end

//uart 输出数据

always @(posedge s_clk or negedge s_rst_n)begin
        if (!s_rst_n)begin
            data_rx  <=  8'd0                   ;
        end
        else if(data_rx_flag == 1'b1 && half_band_flag == 1'b1 && bit_cnt >= 4'd1 )begin
            data_rx  <=  {data_in_3,data_rx[ 7: 1]} ;
        end
        else begin
            data_rx  <=  data_rx                 ;
        end
end
endmodule
































