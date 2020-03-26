module sdram_write(
    //system signal
    input                s_clk               ,
    input                s_rst_n             ,
    /*input                sdram_clk           ,
    input                sdram_cke           ,*/
    //community  with TOP
    input                en_wr               ,
    output  wire         req_wr              ,
    output  reg          wr_end              ,
    //others
    input                req_aref            ,
    input                wr_tring            ,
    //write interface
    output  reg [ 3:0]   wr_cmd              ,
    output  reg [11:0]   wr_addr             ,
    output  wire[ 1:0]   wr_bank             ,
    output  wire[15:0]   wr_data             ,
    input       [ 7:0]   wfifo_rd_data        ,
    output  wire         wfifo_rd_en          ,
    input                wfifo_empty

);

/*==========================================================
* ************define parameter and internal signal**********
* =========================================================*/
//state define
parameter       WR_IDLE     =       5'b0_0001       ;
parameter       WR_REQ      =       5'b0_0010       ;
parameter       WR_ACT      =       5'b0_0100       ;
parameter       WRITE       =       5'b0_1000       ;
parameter       WR_PRE      =       5'b1_0000       ;
//command define
parameter       ACT         =       4'b0011         ;
parameter       NOP         =       4'b0111         ;
parameter       PRECHAR     =       4'b0010         ;
parameter       WR          =       4'b0100         ;
//other signal
reg             flag_wr                             ;
reg     [ 4:0]  wr_state                            ;
reg     [ 3:0]  cnt_act                             ;
reg             act_end                             ;
reg     [ 1:0]  cnt_burst                           ;
reg     [ 3:0]  cnt_pre                             ;
reg             pre_end                             ;
reg             row_end                             ;
reg     [11:0]  row_addr                            ;
wire    [ 8:0]  col_addr                            ;
reg     [ 6:0]  cnt_col                             ;
reg     [ 1:0]  cnt_burst_r                         ;
reg             wr_data_end                         ;

/*==========================================================
* ************************main code*************************
* ==========================================================*/

//state change
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_state <= WR_IDLE                 ;
        end
        else case(wr_state)
            WR_IDLE : if(wr_tring == 1'b1)begin
                         wr_state <= WR_REQ     ;
                      end
                      else begin
                         wr_state <= WR_IDLE    ;
                      end
            WR_REQ  : if(en_wr == 1'b1)begin
                         wr_state <= WR_ACT     ;
                      end
                      else begin
                         wr_state <= WR_REQ     ;
                      end
            WR_ACT  : if(cnt_act == 4'd3)begin
                         wr_state <= WRITE      ;
                      end
                      else begin
                         wr_state <= WR_ACT     ;
                      end
            WRITE   : if(wr_data_end == 1'b1)begin
                         wr_state <= WR_PRE     ;
                      end
                      else if(req_aref == 1'b1 && cnt_burst == 2'd3)begin
                         wr_state <= WR_PRE     ;
                      end
                      else if(row_end == 1'b1)begin
                         wr_state <= WR_PRE     ;
                      end
                      else begin
                         wr_state <= WRITE      ;
                      end                                                      
            WR_PRE  : if(req_aref == 1'b1 && pre_end == 1'b1 && flag_wr == 1'b1)begin
                         wr_state <= WR_REQ     ;
                      end
                      else if(pre_end == 1'b1 && flag_wr == 1'b1)begin
                         wr_state <= WR_ACT     ;
                      end
                      else if(wr_end == 1'b1)begin
                         wr_state <= WR_IDLE    ;
                      end
                      else begin
                         wr_state <= WR_PRE     ;
                      end
              default :  wr_state <= WR_IDLE    ;
            endcase

end

//req_wr
assign  req_wr = (wr_state == WR_REQ)? 1'b1 : 1'b0 ;

//wr_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_end <= 1'b0                      ;
        end
        else if(wr_data_end == 1'b1 && cnt_pre == 2'd2 )begin
            wr_end <= 1'b1                      ;
        end
        else if(req_aref == 1'b1 && pre_end == 1'b1 )begin
            wr_end <= 1'b1                      ;
        end
        else begin
            wr_end <= 1'b0                      ;
        end
end

//flag_wr
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            flag_wr <= 1'b0                     ;
        end
        else if(wr_data_end == 1'b1)begin
            flag_wr <= 1'b0                     ;
        end
        else if(wr_tring == 1'b1)begin
            flag_wr <= 1'b1                     ;
        end
        else begin
            flag_wr <= flag_wr                  ;
        end
end

//wr_data_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_data_end <= 1'b0                 ;
        end
        else if(row_addr == 12'd0 && col_addr == 9'd1)begin
            wr_data_end <= 1'b1                 ;
        end
        else if(cnt_pre == 2'd2)begin
            wr_data_end <= 1'b0                 ;
        end
        else begin
            wr_data_end <= wr_data_end          ;
        end
end
//cnt_act
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_act <= 4'd0                     ;
        end
        else if(wr_state == WR_ACT)begin
            cnt_act <= cnt_act +1'b1            ;
        end
        else begin
            cnt_act <= 4'd0                     ;
        end
end

//act_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            act_end <= 1'b0                     ;
        end
        else if(cnt_act == 4'd3) begin
            act_end <= 1'b1                     ;
        end            
        else begin
            act_end <= 1'b0                     ;
        end
end

//cnt_burst
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_burst <= 2'd0                   ;
        end
        else if(cnt_burst == 2'd0 && req_aref == 1'b1)begin
            cnt_burst <= 2'd0                   ;
        end
        else if(cnt_burst == 2'd3 )begin
            cnt_burst <= 2'd0                   ;
        end
        else if(wr_state == WRITE )begin
            cnt_burst <= cnt_burst + 1'b1       ;
        end
        else begin
            cnt_burst <= 2'd0                   ;
        end
end

//cnt_burst_r
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_burst_r <= 2'd0                 ;
        end 
        else begin
            cnt_burst_r <= cnt_burst            ;
        end
end

//cnt_pre
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_pre <= 4'd0                     ;
        end
        else if(cnt_pre == 4'd3)begin
            cnt_pre <= 4'd0                     ;
        end
        else if(wr_state == WR_PRE)begin
            cnt_pre <= cnt_pre + 1'b1           ;
        end
        else begin
            cnt_pre <= 4'd0                     ;
        end
end

//pre_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            pre_end <= 1'b0                   ;
        end
        else if(cnt_pre == 4'd2)begin
            pre_end <= 1'b1                   ;
        end
        else begin
            pre_end <= 1'b0                   ;
        end
end

//row_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            row_end <= 1'b0                     ;
        end
        else if(col_addr == 9'd509)begin
            row_end <= 1'b1                     ;
        end
        else begin
            row_end <= 1'b0                     ;
        end
end

//row_addr
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            row_addr <= 12'd0                   ;
        end
        else if(col_addr == 9'd511)begin
            row_addr <= row_addr +1'b1          ;
        end
        else begin
            row_addr <= row_addr                ;
        end
end

//col_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_col <= 7'd0                     ;
        end
        else if(cnt_col == 7'd127 && cnt_burst_r == 2'd3)begin
            cnt_col <= 7'd0                     ;
        end
        else if(cnt_burst_r == 2'd3)begin
            cnt_col <= cnt_col + 1'b1           ;
        end
        else begin
            cnt_col <= cnt_col                  ;
        end
end

//col_addr
assign   col_addr = {7'd0,cnt_burst_r}        ;

//wr_cmd
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_cmd <= NOP                       ;
        end
        else case (wr_state)
                    WR_ACT : if(cnt_act == 4'd0)begin
                                wr_cmd <= ACT   ;
                             end
                             else begin
                                wr_cmd <= NOP   ;
                             end
                    WRITE  : if(cnt_burst == 2'd0 && req_aref == 1'b0)begin
                                wr_cmd <= WR    ;
                             end
                             else begin
                                wr_cmd <= NOP   ;
                             end
                    WR_PRE : if(cnt_pre == 4'd0)begin
                                wr_cmd <= PRECHAR ;
                             end
                             else begin
                                wr_cmd <= NOP       ;
                             end
                     default : wr_cmd <= NOP        ;
                endcase
end

//wr_addr
always @(*)begin
             case (wr_state)
                    WR_ACT  : if(cnt_act == 4'd1)begin
                                    wr_addr = row_addr;
                              end
                              else begin
                                    wr_addr = 12'd0        ;
                              end
                    WRITE   : wr_addr = {3'b000,col_addr};
                              
                             
                    WR_PRE  : if(cnt_pre == 4'd1)begin
                                    wr_addr = 12'b0100_0000_0000 ;
                              end  
                              else begin
                                    wr_addr = {3'b000,col_addr}        ;
                              end
            default : wr_addr = 12'd0              ;
    endcase
end

//bank
assign wr_bank = 2'b00                          ;

/* wr_data
always @(*)begin
       
             case(cnt_burst_r)
                    0 : wr_data <= 16'd3        ;
                    1 : wr_data <= 16'd5        ;
                    2 : wr_data <= 16'd7        ;
                    3 : wr_data <= 16'd9        ;
                default : wr_data = 16'd0      ;
        endcase
end*/
//wr_data
assign   wr_data  =  {8'd0,wfifo_rd_data}                  ;
assign   wfifo_rd_en = (wr_state == WRITE)? 1'b1 : 1'b0     ;

endmodule
