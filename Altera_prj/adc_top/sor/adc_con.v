module adc_con(
input               s_clk           ,
input               s_rst_n         ,
input               sam_end         ,
input      [ 7:0]   dout            ,
output reg [11:0]   vol             ,
output reg          con_end      
);


/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter           SUM_END      =   216268799        ;  

reg  [27:0]         sum_cnt                           ;
reg                 con_sta_flag                      ;
reg                 cnt_end                           ;
reg  [35:0]         sum_reg                           ;          

/******************************************************************
* *************************** main   code *************************
* ****************************************************************/
//con_sta_flag
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            con_sta_flag <= 1'b0                ;
        end
        else if(cnt_end == 1'b1)begin
            con_sta_flag <= 1'b0                ;
        end
        else if(sam_end)begin
            con_sta_flag <= 1'b1                ;
        end
        else begin
            con_sta_flag <= con_sta_flag        ;
        end
end

//sum_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            sum_cnt <= 28'd0                    ;
        end
        else if(cnt_end == 1'b1 || sum_cnt == SUM_END)begin
            sum_cnt <= 28'd0                    ;
        end
        else if(con_sta_flag)begin
            sum_cnt <= sum_cnt + 1'b1           ;
        end
        else begin
            sum_cnt <= 28'd0                    ;
        end
end

//cnt_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_end <= 1'b0                     ;
        end
        else if(sum_cnt == (SUM_END-1))begin
            cnt_end <= 1'b1                     ;
        end
        else begin
            cnt_end <= 1'b0                     ;
        end
end

//sum_reg
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            sum_reg <= 36'd0                    ;
        end       
        else if(con_sta_flag)begin
            sum_reg <= sum_reg + dout           ;
        end
        else begin
            sum_reg <= 36'd0                    ;
        end
end

//con_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            con_end <= 1'b0                 ;
        end
        else if(cnt_end)begin
            con_end <= 1'b1                 ;
        end
        else begin
            con_end <= 1'b0                 ;
        end
end

//vol
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            vol <= 12'd0                        ;
        end
        else if(con_end)begin
            vol <= sum_reg[35:24]               ;
        end
        else begin
            vol <= vol                          ;
        end

end




endmodule
