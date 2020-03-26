module sdram_init(
//系统信号
    input                    s_clk               ,//50M系统时钟
    input                    s_rst_n             ,//系统复位信号
    output   reg   [11:0]    sdram_addr          ,//行地址
    output   wire  [ 1:0]    bank_addr           ,//块地址
    output   reg   [ 3:0]    cmd                 ,//命令
    output   reg             flag_init_end        //初始化结束


);
/*==========================================================
* ************define parameter and internal signal**********
* =========================================================*/
localparam      DELAY_200US = 9999                      ;
localparam      NOP         = 4'b0111                   ;
localparam      PRECHAR     = 4'b0010                   ;
localparam      AREF        = 4'b0001                   ;
localparam      MRSET       = 4'b0000                   ;

reg         [13:0]      delay_200us_cnt                 ;
reg         [ 3:0]      cmd_cnt                         ;
reg                     flag_dalay_200us                ;         

/*==========================================================
* ************************main code*************************
* ==========================================================*/

//200us计数器
always @(posedge s_clk or negedge s_rst_n)begin
            if(!s_rst_n)begin
                delay_200us_cnt <= 1'b0                     ;
            end
            else if(delay_200us_cnt == DELAY_200US || flag_dalay_200us == 1'b1)begin
                delay_200us_cnt <= 1'b0                     ;
            end
            else begin
                delay_200us_cnt <= delay_200us_cnt + 1'b1   ;
            end
end

//200us标志信号
always @(posedge s_clk or negedge s_rst_n)begin
            if(!s_rst_n)begin
                flag_dalay_200us <= 1'b0                    ;
            end
            else if(delay_200us_cnt == DELAY_200US)begin
                flag_dalay_200us <= 1'b1                    ;
            end                     
            else begin
                flag_dalay_200us <= flag_dalay_200us        ;
            end
end

//命令计数器
always @(posedge s_clk or negedge s_rst_n)begin
            if(!s_rst_n)begin
                cmd_cnt <= 4'd0                             ; 
            end           
            else if(flag_dalay_200us == 1'b1 && flag_init_end == 1'b0)begin
                cmd_cnt <= cmd_cnt + 1'b1                   ;
            end
            else begin
                cmd_cnt <= 4'd0                             ;
            end
end

//命令输出
always @(posedge s_clk or negedge s_rst_n)begin
            if(!s_rst_n)begin
                cmd <= NOP                                  ;
            end
            else if(flag_dalay_200us == 1'b1 && flag_init_end == 1'b0)begin
                    case(cmd_cnt) 
                            0 : cmd <= PRECHAR              ;
                            1 : cmd <= AREF                 ;
                            5 : cmd <= AREF                 ;
                            9 : cmd <= MRSET                ;
                      default : cmd <= NOP                  ;
                    endcase
             end
            else begin
                cmd <= NOP                                  ;    
            end
end
//行地址输出
always @(posedge s_clk or negedge s_rst_n)begin
            if(!s_rst_n)begin
                sdram_addr <= 12'd0                               ;
            end
            else if(flag_dalay_200us == 1'b1)
                    case (cmd_cnt)                       
                          0 : sdram_addr <= 12'b0100_0000_0000 ;
                          9 : sdram_addr <= 12'b0000_0011_0010 ;
                          default : sdram_addr <= 12'd0           ;
                    endcase
            
            else begin
                sdram_addr <= sdram_addr                        ;
            end
end
//块地址输出
assign      bank_addr    =2'b00                                  ;

//初始化结束标志
always @(posedge s_clk or negedge s_rst_n)begin
            if(!s_rst_n)begin
                flag_init_end <= 1'b0                           ;
            end
            else if(cmd_cnt == 4'd9)begin
                flag_init_end <= 1'b1                           ;
            end
            else begin
                flag_init_end <= flag_init_end                  ;
            end 


end


endmodule
