module seg_ctrl(
input                   s_clk           ,
input                   s_rst_n         ,
input                   con_end         ,
input       [11:0]      vol             ,
output reg  [ 3:0]      seg_cs_n        ,
output reg  [ 7:0]      seg_data        
);

/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter               ONE_THD     =   12'd1000        ;
parameter               ONE_HAD     =   10'd100         ; 
parameter               ONE_TEN     =   6'd10           ; 
parameter               ONE_UNI     =   3'd1            ; 
parameter               TIME        =   17'd99999       ;
 
reg   [11:0]            vol_reg         ;
reg   [ 3:0]            thd_data        ;
reg   [ 3:0]            had_data        ;
reg   [ 3:0]            ten_data        ;
reg   [ 3:0]            uni_data        ;
reg   [ 3:0]            thd_cnt         ;
reg   [ 3:0]            had_cnt         ;
reg   [ 3:0]            ten_cnt         ;
reg   [ 3:0]            uni_cnt         ; 
reg                     dis_sta         ;
reg   [ 7:0]            dis_data        ;
reg   [16:0]            time_cnt        ;
reg   [ 1:0]            cs_cnt          ;





/******************************************************************
* *************************** main   code *************************
* ****************************************************************/

//vol_reg
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            vol_reg <= 12'd0            ;
        end
        else if(con_end)begin
            vol_reg <= vol              ;
        end        
        else if(vol_reg >= ONE_THD)begin
            vol_reg <= vol_reg + (~ONE_THD + 1'b1)  ;
        end
        else if(vol_reg < ONE_THD && vol_reg >= ONE_HAD)begin
            vol_reg <= vol_reg + (~ONE_HAD + 1'b1)  ;
        end
        else if(vol_reg < ONE_HAD && vol_reg >= ONE_TEN)begin
            vol_reg <= vol_reg + (~ONE_TEN + 1'b1)  ;
        end
        else if(vol_reg < ONE_TEN && vol_reg >= ONE_UNI)begin
            vol_reg <= vol_reg + (~ONE_UNI + 1'b1)  ;
        end
        else begin
            vol_reg <= vol_reg          ;
        end

end

//thd_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            thd_cnt <= 4'd0             ;
        end
        else if(con_end)begin
            thd_cnt <= 4'd0             ; 
        end
        else if(vol_reg >= ONE_THD)begin
            thd_cnt <= thd_cnt + 1'b1   ;
        end
        else begin
            thd_cnt <= thd_cnt          ;
        end
end

//had_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            had_cnt <= 4'd0             ;
        end
        else if(con_end)begin
            had_cnt <= 4'd0             ; 
        end
        else if(vol_reg < ONE_THD && vol_reg >= ONE_HAD)begin
            had_cnt <= had_cnt + 1'b1   ;
        end
        else begin
            had_cnt <= had_cnt          ;
        end
end

//ten_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            ten_cnt <= 4'd0             ;
        end
        else if(con_end)begin
            ten_cnt <= 4'd0             ; 
        end
        else if(vol_reg < ONE_HAD && vol_reg >= ONE_TEN)begin
            ten_cnt <= ten_cnt + 1'b1   ;
        end
        else begin
            ten_cnt <= ten_cnt          ;
        end
end

//uni_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            uni_cnt <= 4'd0             ;
        end
        else if(con_end)begin
            uni_cnt <= 4'd0             ; 
        end
        else if(vol_reg < ONE_TEN && vol_reg >= ONE_UNI)begin
            uni_cnt <= uni_cnt + 1'b1   ;
        end
        else begin
            uni_cnt <= uni_cnt          ;
        end
end

//dis_sta
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            dis_sta <= 1'b0             ;
        end
        else if(vol_reg < ONE_UNI)begin
            dis_sta <= 1'b1             ;
        end
        else begin
            dis_sta <= 1'b0             ;
        end
end

//thd_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            thd_data <= 4'd0            ;
        end
        else if(dis_sta)begin
            thd_data <= thd_cnt         ;
        end
        else begin
            thd_data <= thd_data        ;
        end
end

//had_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            had_data <= 4'd0            ;
        end
        else if(dis_sta)begin
            had_data <= had_cnt         ;
        end
        else begin
            had_data <= had_data        ;
        end
end

//ten_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            ten_data <= 4'd0            ;
        end
        else if(dis_sta)begin
            ten_data <= ten_cnt         ;
        end
        else begin
            ten_data <= ten_data        ;
        end
end

//uni_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            uni_data <= 4'd0            ;
        end
        else if(dis_sta)begin
            uni_data <= uni_cnt         ;
        end
        else begin
            uni_data <= uni_data        ;
        end
end

//time_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            time_cnt <= 17'd0           ;
        end
        else if(time_cnt == TIME)begin
            time_cnt <= 17'd0           ;
        end
        else begin
            time_cnt <= time_cnt + 1'b1 ;
        end
end

//cs_cnt
always @(posedge s_clk or negedge s_rst_n)begin
       if(!s_rst_n)begin
            cs_cnt <= 2'd0              ;
       end
       else if(time_cnt == TIME)begin
            cs_cnt <= cs_cnt + 1'b1     ;
       end
       else begin
            cs_cnt <= cs_cnt            ;
       end
end       



//seg_cs_n
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            seg_cs_n <= 4'hf            ;
        end
        else case(cs_cnt)
                0   :   seg_cs_n <= 4'b1110 ;
                1   :   seg_cs_n <= 4'b1101 ;
                2   :   seg_cs_n <= 4'b1011 ;
                3   :   seg_cs_n <= 4'b0111 ; 
           default : seg_cs_n <= 4'hf       ;     
        endcase
end 

//dis_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            dis_data <= 8'd0            ;
        end
        else case(cs_cnt)
                0   :   dis_data <= {4'd0,thd_data} ;
                1   :   dis_data <= {4'd0,had_data} ;
                2   :   dis_data <= {4'd0,ten_data} ;
                3   :   dis_data <= {4'd0,uni_data} ; 
           default : dis_data <=8'd0       ;     
        endcase
end 

//seg_data
always@(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            seg_data <= 8'b00000101     ;
        end
        else case(dis_data)
                0   :  seg_data <= 8'b00000011      ;
                1   :  seg_data <= 8'b10011111      ;
                2   :  seg_data <= 8'b00100101      ;                
                3   :  seg_data <= 8'b00001101      ;
                4   :  seg_data <= 8'b10011001      ;
                5   :  seg_data <= 8'b01001001      ;
                6   :  seg_data <= 8'b01000001      ;
                7   :  seg_data <= 8'b00011111      ;
                8   :  seg_data <= 8'b00000001      ;
                9   :  seg_data <= 8'b00001001      ;
             default : seg_data <= 8'b01110001      ;
         endcase
end


endmodule
