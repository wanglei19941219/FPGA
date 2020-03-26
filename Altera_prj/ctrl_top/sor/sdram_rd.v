module sdram_rd(

//system signal
input                   s_clk                   ,
input                   s_rst_n                 ,
//sdram signal                                  
/*input                   sdram_clk               ,*/
/*input                   sdram_cke               ,*/
//others                                        
input                   rd_tring                ,
input                   req_aref                ,
input                   en_rd                   ,
input       [ 15:0]     sdram_data              ,
output  wire            req_rd                  ,
output  reg             rd_end                  ,
output  reg [ 3:0]      rd_cmd                  ,
output  reg [11:0]      rd_addr                 ,
output  wire[ 1:0]      rd_bank                 ,
output  wire[ 7:0]      rfifo_wr_data           ,
output  reg             rfifo_wr_en             

);

/*==========================================================
* ************define parameter and internal signal**********
* =========================================================*/
//define  parameter  wr_state
parameter       RD_IDLE     =   5'b0_0001           ;
parameter       RD_REQ      =   5'b0_0010           ;
parameter       RD_ACT      =   5'b0_0100           ;
parameter       READ        =   5'b0_1000           ;
parameter       RD_PRE      =   5'b1_0000           ;

//define  parameter command
parameter       ACT         =   4'b0011             ;
parameter       NOP         =   4'b0111             ;
parameter       PRECHAR     =   4'b0010             ;
parameter       RD          =   4'b0101             ;



//define mid signal
reg     [ 4:0]          rd_state                    ;
reg                     flag_rd                     ;
reg                     rd_data_end                 ;
reg     [ 1:0]          cnt_act                     ;
reg                     act_end                     ;
reg     [ 1:0]          cnt_burst                   ;
reg     [ 1:0]          cnt_burst_r                 ;
reg                     burst_end                   ; 
reg     [ 1:0]          cnt_pre                     ;
reg                     pre_end                     ;
reg     [11:0]          row_addr                    ;
reg                     row_end                     ;
wire    [ 8:0]          col_addr                    ;
reg     [ 6:0]          cnt_col                     ;
reg                     rfifo_wr_en_r               ;
reg                     rfifo_wr_en_rr              ;


/*==========================================================
* ************************main code*************************
* ==========================================================*/
//rfifo_wr_en
always @(posedge s_clk)begin
        rfifo_wr_en_r  <= rd_state[3]       ;
        rfifo_wr_en_rr <= rfifo_wr_en_r     ;
        rfifo_wr_en    <= rfifo_wr_en_rr    ;
end

//rd_end
always @(*)begin
        if(req_aref == 1'b1 && pre_end == 1'b1 && rd_state == RD_PRE)begin
            rd_end = 1'b1                           ;
        end
        else if(rd_data_end == 1'b1 && cnt_pre == 2'd2)begin
            rd_end = 1'b1                           ;
        end
        else begin
            rd_end = 1'b0                           ;
        end
end

// state    
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_state <= RD_IDLE                     ;
        end
        else case (rd_state)
                    RD_IDLE : if(rd_tring)begin
                                  rd_state <= RD_REQ;
                              end
                              else begin
                                  rd_state <= RD_IDLE;
                              end
                    RD_REQ  : if(en_rd)begin
                                  rd_state <= RD_ACT ;
                              end
                              else begin
                                  rd_state <= RD_REQ ;
                              end
                    RD_ACT  : if(act_end)begin
                                  rd_state <= READ   ;
                              end
                              else begin
                                  rd_state <= RD_ACT ;
                              end
                    READ    : if(req_aref == 1'b1 && burst_end == 1'b1 && flag_rd == 1'b1)begin
                                  rd_state <= RD_PRE ;
                              end
                              else if(row_end == 1'b1 && flag_rd == 1'b1)begin
                                  rd_state <= RD_PRE ;
                              end
                              else if(rd_data_end == 1'b1)begin
                                  rd_state <= RD_PRE ;
                              end
                              else begin
                                  rd_state <= READ   ;
                              end
                    RD_PRE  : if(req_aref == 1'b1 && pre_end == 1'b1 && flag_rd == 1'b1)begin
                                  rd_state <= RD_REQ ;
                              end
                              else if(pre_end == 1'b1 && flag_rd == 1'b1)begin
                                  rd_state <= RD_ACT ;
                              end
                              else if(rd_end == 1'b1 && flag_rd == 1'b0)begin
                                  rd_state <= RD_IDLE;
                              end
                              else begin
                                  rd_state <= RD_PRE ;
                              end
                 default : rd_state <= RD_IDLE          ;
             endcase
    end


//req_rd
assign  req_rd  =  (rd_state == RD_REQ)?  1'b1 : 1'b0;

//cnt_pre
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_pre <= 2'd0                         ;
        end
        else if(cnt_pre == 2'd3)begin
            cnt_pre <= 2'd0                         ;
        end
        else if(rd_state == RD_PRE)begin
            cnt_pre <= cnt_pre + 1'b1               ;
        end
        else begin
            cnt_pre <= 1'b0                         ;
        end
end

//pre_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            pre_end <= 1'b0                         ;
        end
        else if(cnt_pre == 2'd2)begin
            pre_end <= 1'b1                         ;
        end
        else begin
            pre_end <= 1'b0                         ;
        end
end


//cnt_act
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_act <= 2'd0                         ;
        end
        else if(cnt_act == 2'd3)begin
            cnt_act <= 2'd0                         ;
        end
        else if(rd_state == RD_ACT)begin
            cnt_act <= cnt_act + 1'b1               ;
        end
        else begin
            cnt_act <= 2'b0                         ;
        end
end
//act_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            act_end <= 1'b0                         ;
        end
        else if(cnt_act == 2'd2)begin
            act_end <= 1'b1                         ;
        end
        else begin
            act_end <= 1'b0                         ;
        end
end



//cnt_burst
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_burst <= 2'd0                       ;
        end
        else if(cnt_burst == 2'd3)begin
            cnt_burst <= 2'd0                       ;
        end
        else if(rd_state == READ)begin
            cnt_burst <= cnt_burst + 1'b1           ;
        end
        else begin
            cnt_burst <= cnt_burst                  ;
        end
end

//burst_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            burst_end <= 1'b0                       ;
        end
        else if(cnt_burst == 2'd2)begin
            burst_end <= 1'b1                       ;
        end
        else begin
            burst_end <= 1'b0                       ;
        end
end

//cnt_burst_r
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_burst_r <= 2'd0                     ;
        end
        else begin
            cnt_burst_r <= cnt_burst                ;
        end
end

//cnt_col
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_col <= 7'd0                          ;
        end
        else if(cnt_burst_r == 2'd3)begin
            cnt_col <= cnt_col +1'b1                 ;
        end
        else begin
            cnt_col <= cnt_col                       ;
        end
end
//col_addr
assign      col_addr = {7'd0,cnt_burst_r}          ;


//row_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            row_end <= 1'b0                          ;
        end
        else if(col_addr == 9'd509)begin
            row_end <= 1'b1                          ;
        end
        else begin
            row_end <= 1'b0                          ;
        end
end
//row_addr
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            row_addr <= 12'd0                       ;
        end
        else if(col_addr == 9'd511)begin
            row_addr <= row_addr +1'b1              ;
        end
        else begin
            row_addr <= row_addr                    ;
        end
end
//rd_data_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_data_end <= 1'b0                     ;
        end
        else if(row_addr == 12'd0 && col_addr == 9'd1)begin
            rd_data_end <= 1'b1                     ;
        end
        else if(cnt_pre == 2'd2)begin
            rd_data_end <= 1'b0                     ;
        end
        else begin
            rd_data_end <= rd_data_end              ;
        end
end

//flag_rd
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            flag_rd <= 1'b0                         ;
        end
        else if(rd_data_end)begin
            flag_rd <= 1'b0                         ;
        end
        else if(rd_tring == 1'b1)begin
            flag_rd <= 1'b1                         ;
        end
        else begin
            flag_rd <= flag_rd                      ;
        end
end

//rd_cmd
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_cmd <= NOP                           ;
        end
        else case (rd_state)
                    RD_ACT : if(cnt_act == 2'd0)begin
                                rd_cmd <= ACT       ;
                             end
                             else begin
                                rd_cmd <= NOP       ;
                             end
                    READ   : if(cnt_burst == 2'd0)begin
                                rd_cmd <= RD        ;
                             end
                             else begin
                                rd_cmd <= NOP       ;
                             end
                    RD_PRE  : if(cnt_pre == 2'd0)begin
                                rd_cmd <= PRECHAR   ;
                             end
                             else begin
                                rd_cmd <= NOP       ;
                             end
                     default : rd_cmd <= NOP        ;

        endcase
end

//rd_addr

always @(*)begin
       
       case (rd_state)
                    RD_ACT : if(cnt_act == 2'd1)begin
                                rd_addr = row_addr ;
                             end
                             else begin
                                rd_addr = 12'd0       ;
                             end
                            
                    READ   : rd_addr = {3'b000,col_addr}         ;
                            
                    RD_PRE  : if(cnt_pre == 2'd1)begin
                                rd_addr = 12'b0100_0000_0000       ;                            
                             end
                             else begin
                                rd_addr = {3'b000,col_addr}  ;
                             end
                     default : rd_addr = 12'd0        ;
                    
           endcase
end

//rd_bank
assign rd_bank = 2'b00                                  ;
assign rfifo_wr_data = sdram_data[ 7:0]                 ;




endmodule
