module dac_ctrl(
//system signal
input                         s_clk       ,//50MHZ    
input                         s_rst_n     ,
//spi signal
input     [ 9:0]              data_in     ,
output reg                    spi_clk     ,//12.5MHZ  
output reg                    mosi        ,
output reg                    spi_cs_n    

);
/*========================================================
* ===================define  parameter====================
* ====================================================== */
parameter                DIV_END  =  3          ;
parameter                DA_END  =  11          ;

reg  [ 1:0]             div_cnt                 ;
reg                     div_clk                 ;
reg  [ 3:0]             da_cnt                  ;
reg  [ 9:0]             data_in_r               ; 
wire                    sta_trig                ;
reg                     cs_n_r                  ;
wire [ 1:0]             extra_bit               ;
wire [11:0]             spi_data                ;
reg                     spi_end                 ;


/*========================================================
* =====================main     code======================
* ====================================================== */

//data_in_r
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            data_in_r <= 10'd0      ;
        end 
        else begin
        data_in_r <= data_in        ;
        end
end

//sta_trig 
assign  sta_trig = (data_in != data_in_r)? 1'b1 : 1'b0      ;

//extra_bit
assign  extra_bit = 2'd0         ;

//spi_data
assign spi_data = {data_in_r,extra_bit} ;

//cs_n_r
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cs_n_r <= 1'b1        ;
        end
        else if(spi_end == 1'b1)begin
            cs_n_r <= 1'b1        ;
        end
        else if(sta_trig == 1'b1)begin
            cs_n_r <= 1'b0        ;
        end
        else begin
            cs_n_r <= cs_n_r      ;
        end
end

//spi_cs_n
always @(posedge s_clk)begin
       spi_cs_n <= cs_n_r           ;
end

//div_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            div_cnt <= 2'd0         ;
        end
        else if(cs_n_r == 1'b0)begin
            div_cnt <= div_cnt + 1'b1     ;
        end
        else begin
            div_cnt <= 2'd0         ;
        end
end

//div_clk
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            div_clk <= 1'b0         ;
        end
        else if(cs_n_r == 1'b0 && div_cnt[0] == 1'b1)begin
            div_clk <= ~div_clk     ;
        end
        else begin
            div_clk <= div_clk      ;
        end
end

//spi_clk
always @(posedge s_clk)begin
        spi_clk <= div_clk          ;
end

//da_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            da_cnt <= 4'd0          ;
        end
        else if((da_cnt == DA_END && div_cnt == DIV_END) || cs_n_r == 1'b1)begin
            da_cnt <= 4'd0          ;
        end
        else if(div_cnt == 2'd3)begin
            da_cnt <= da_cnt + 1'b1 ;
        end
        else begin
            da_cnt <= da_cnt        ;
        end
end

//mosi
always @(*)begin
        if(cs_n_r == 1'b0)begin
            case (da_cnt)
                    0  : mosi = spi_data[11] ;
                    1  : mosi = spi_data[10] ;
                    2  : mosi = spi_data[ 9] ;
                    3  : mosi = spi_data[ 8] ;
                    4  : mosi = spi_data[ 7] ;
                    5  : mosi = spi_data[ 6] ;
                    6  : mosi = spi_data[ 5] ;
                    7  : mosi = spi_data[ 4] ;
                    8  : mosi = spi_data[ 3] ;
                    9  : mosi = spi_data[ 2] ;
                    10 : mosi = spi_data[ 1] ;
                    11 : mosi = spi_data[ 0] ;                   
                default: mosi = 1'b0         ;
            endcase
        end
        else begin
            mosi = 1'b0                      ;
        end
end

//spi_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            spi_end <= 1'b0                 ;
        end
        else if(da_cnt == DA_END && div_cnt == (DIV_END-1))begin
            spi_end <= 1'b1                 ;
        end
        else begin
            spi_end <= 1'b0                 ;
        end
end

endmodule
