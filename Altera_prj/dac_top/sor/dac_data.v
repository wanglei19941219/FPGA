module dac_data(
//system signal
input               s_clk       ,
input               s_rst_n     ,
//module signal
output reg [ 9:0]   dac_data    

);
/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter                   DELAY_TM    =   49_9999         ;

reg [18:0]          delay_cnt   ;

/******************************************************************
* *************************** main   code *************************
* ****************************************************************/
//delay_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            delay_cnt <= 19'd0          ;
        end
        else if(delay_cnt == DELAY_TM)begin
            delay_cnt <= 19'd0          ;
        end
        else begin
            delay_cnt <= delay_cnt + 1'b1 ;
        end
end

//dac_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            dac_data <= 10'd0       ;
        end
        else if(delay_cnt == DELAY_TM)begin
            dac_data <= dac_data + 1'b1 ;
        end
        else begin
            dac_data <= dac_data        ;
        end
end




endmodule
