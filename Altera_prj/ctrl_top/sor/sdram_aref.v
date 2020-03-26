module sdram_aref(
    //system signal
    input                 s_clk                   ,
    input                 s_rst_n                 ,
    //aref signal
   /* input                 sdram_clk               ,
    input                 sdram_cke               ,*/
    input                 en_aref                 ,
    input                 flag_init_end           ,
    output  reg           req_aref                ,
    output  reg           end_aref                ,
    output  reg[ 3:0]     aref_cmd                ,
    output  reg[11:0]     sdram_addr              ,
    output  wire[ 1:0]    sdram_bank
 
);
/*==========================================================
* ************define parameter and internal signal**********
* =========================================================*/
parameter       PRECHAR     =    4'b0010          ;
parameter       NOP         =    4'b0111          ;
parameter       AREF        =    4'b0001          ;
parameter       TIME_15US   =    749              ;

//内部信号
reg   [ 9:0]             cnt_15us                 ;
reg                      flag_15us                ;
reg   [ 3:0]             cnt_cmd                  ;

/*==========================================================
* ************************main code*************************
* ==========================================================*/
//15us计数器
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_15us <= 9'd0                      ;
        end
        else if(cnt_15us == TIME_15US )begin
            cnt_15us <= 9'd0                      ;
        end
        else if(flag_init_end == 1'b1) begin
            cnt_15us <= cnt_15us + 1'b1           ;
        end

end

//15us标志信号
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            flag_15us <= 1'b0                     ;
        end
        else if(cnt_15us == TIME_15US)begin
            flag_15us <= 1'b1                     ;
        end
        else begin
            flag_15us <= 1'b0                     ;
        end       
end

//请求信号输出
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin           
            req_aref <= 1'b0                      ;
        end
        else if(cnt_15us == TIME_15US && flag_init_end == 1'b1 )begin
            req_aref <= 1'b1                      ;
        end
        else if(en_aref == 1'b1)begin
            req_aref <= 1'b0                      ;
        end
        else begin
            req_aref <= req_aref                  ;
        end
end

//指令计数器
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_cmd <= 4'd0                       ;
        end
        else if(en_aref == 1'b1 && end_aref == 1'b0)begin
            cnt_cmd <= cnt_cmd +1'b1              ;
        end
        else begin
            cnt_cmd <= 4'd0                       ;
        end
end

//aref结束信号
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            end_aref <= 1'b0                      ;
        end     
        else if(cnt_cmd == 4'd3)begin
            end_aref <= 1'b1                      ;
        end
        else begin
            end_aref <= 1'b0                      ;
        end
end

//命令输出
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            aref_cmd <= NOP                       ;
        end
        else if(en_aref == 1'b1)begin
            case (cnt_cmd)
                   /* 1 : aref_cmd <= PRECHAR       ;*/
                    2 : aref_cmd <= AREF          ;                  
               default : aref_cmd <= NOP          ;
             endcase
        end
        else begin
            aref_cmd <= NOP                       ;
        end
end

//行地址输出
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            sdram_addr <= 12'd0                   ;
        end
        else if(cnt_cmd == 4'd1 && en_aref == 1'b1 )begin
            sdram_addr <= 12'b0100_0000_0000      ;
        end
        else begin
            sdram_addr <= 12'b0000_0000_0000      ;
        end
end

assign  sdram_bank = 2'b00                          ;
endmodule
