module adc_ctrl(
//system signal
input                       s_clk       ,//50MHZ
input                       s_rst_n     ,
//module signal
input                       adc_en      ,
input                       adc_out     ,
output  reg                 adc_clk     ,//400KHZ
output  reg                 adc_cs_n    ,
output  reg [ 7:0]          dout        ,
output  reg                 con_ok      ,
output  wire                sam_end     

);
/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter                DIV_END        =   124            ;
parameter                DA_END         =   7              ;
parameter                STA_END        =   99             ;
parameter                CON_END        =   849            ;

//状态机定义
parameter                IDLE           =   5'b0_0001      ;
parameter                STA            =   5'b0_0010      ;
parameter                READ           =   5'b0_0100      ;
parameter                STO            =   5'b0_1000      ;
parameter                CON            =   5'b1_0000      ;

//middle siganl
reg  [ 4:0]         state                                  ;//状态机
reg  [ 6:0]         div_cnt                                ;//分频计数器
reg                 div_clk                                ;//400kHZ时钟
reg  [ 2:0]         da_cnt                                 ;//数据计数器
reg  [ 6:0]         sta_cnt                                ;//cs建立时间计数器
reg  [ 9:0]         con_cnt                                ;//转换时间计数器
reg                 adc_out_r1                             ;//输入数据打一拍
reg                 read_end                               ;
reg                 sta_end                                ;
reg                 sto_end                                ;
reg                 con_end                                ;
reg                 cs_n_r                                 ;
reg  [ 7:0]         dout_r                                 ;



/******************************************************************
* *************************** main   code *************************
* ****************************************************************/

//state
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            state <= IDLE           ;
        end
        else begin 
            case (state)
                    IDLE   :    if(adc_en)begin
                                    state <= STA        ;
                                end
                                else begin
                                    state <= IDLE       ;
                                end
                    STA    :    if(sta_end)begin
                                    state <= READ       ;
                                end
                                else begin
                                    state <= STA        ;
                                end
                    READ   :    if(read_end)begin
                                    state <= STO        ;
                                end
                                else begin
                                    state <= READ       ;
                                end
                    STO    :    if(sto_end)begin
                                    state <= CON        ;
                                end
                                else begin
                                    state <= STO        ;
                                end         
                    CON    :    if(con_end)begin
                                    state <= IDLE       ;
                                end
                                else begin
                                    state <= CON        ;
                                end
                default :   state <= IDLE               ;        
            endcase  
        end
end

//cs_n_r
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cs_n_r <= 1'b1          ;
        end
        else if(state == STA || state == READ)begin
            cs_n_r <= 1'b0          ;
        end
        else begin
            cs_n_r <= 1'b1          ;
        end
end


//div_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            div_cnt <= 7'd0         ;
        end
        else if(div_cnt == DIV_END)begin
            div_cnt <= 7'd0         ;
        end
        else if(state == READ || state == STO)begin
            div_cnt <= div_cnt + 1'b1   ;
        end
        else begin
            div_cnt <= 7'd0         ;
        end
end

//div_clk
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            div_clk <= 1'b0         ;
        end
        else if(div_cnt == DIV_END && state == READ)begin
            div_clk <= ~div_clk     ;
        end
        else begin
            div_clk <= div_clk      ;
        end
end

//da_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            da_cnt <= 3'd0          ;
        end
        else if(da_cnt == DA_END && div_clk == 1'b1 && div_cnt == DIV_END)begin
            da_cnt <= 3'd0           ;
        end
        else if(div_clk == 1'b1 && div_cnt == DIV_END)begin
            da_cnt <= da_cnt + 1'b1  ;
        end
        else begin
            da_cnt <=da_cnt          ;
        end
end

//read_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            read_end <= 1'b0        ;
        end
        else if(da_cnt == DA_END && div_cnt == (DIV_END-1) && div_clk == 1'b1)begin
            read_end <= 1'b1        ;
        end
        else begin
            read_end <= 1'b0        ;
        end
end

//sta_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            sta_cnt <= 7'b0         ;       
        end
        else if(sta_cnt == STA_END)begin
            sta_cnt <= 7'd0         ;
        end
        else if(state == STA)begin
            sta_cnt <= sta_cnt + 1'b1   ;
        end
        else begin
            sta_cnt <= 7'd0             ;
        end
end

//sta_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            sta_end <= 1'b0             ;
        end
        else if(sta_cnt == (STA_END-1))begin
            sta_end <= 1'b1             ;
        end
        else begin
            sta_end <= 1'b0             ;
        end
end

//con_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            con_cnt <= 10'd0            ;
        end
        else if(con_cnt == CON_END)begin
            con_cnt <= 10'd0            ;
        end
        else if(state == CON)begin
            con_cnt <= con_cnt + 1'b1   ;
        end
        else begin
            con_cnt <= 10'd0            ;
        end
end

//con_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            con_end <= 1'b0             ;
        end
        else if(con_cnt == (CON_END-1))begin
            con_end <= 1'b1             ;
        end
        else begin
            con_end <= 1'b0             ;
        end
end

//sto_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            sto_end <= 1'b0             ;
        end
        else if(state == STO && div_cnt == (DIV_END-1))begin
            sto_end <= 1'b1             ;
        end
        else begin
            sto_end <= 1'b0             ;
        end
end

//adc_clk
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            adc_clk <= 1'b0             ;
        end
        else begin
            adc_clk <= div_clk          ;
        end
end

//adc_cs_n
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            adc_cs_n <= 1'b1            ;
        end
        else begin
            adc_cs_n <= cs_n_r          ;
        end
end

//adc_out_r1
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            adc_out_r1 <= 1'b0          ;
        end
        else begin
            adc_out_r1 <= adc_out       ;
        end
end

//dout_r
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            dout_r <= 8'd0                ;
        end
        else if(div_cnt == DIV_END && div_clk == 1'b0 && state == READ)begin
            dout_r <= {dout_r[6:0],adc_out_r1}   ;
        end
        else begin
            dout_r <= dout_r                ;
        end
end

//dout
always @(posedge s_clk)begin
        dout <= dout_r                  ;
end

//con_ok
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            con_ok <= 1'b1              ;
        end
        else if(state == STA)begin
            con_ok <= 1'b1              ;
        end
        else if(con_end == 1'b1)begin
            con_ok <= 1'b0              ;
        end
        else begin
            con_ok <= con_ok            ;
        end
end

//sam_end
assign      sam_end     = (state == STO)?  1'b1 :  1'b0     ;

endmodule 
