module vga_ctrl(

//system  signal
input                       s_clk           ,
input                       s_rst_n         ,

//module signal 
input                       key_en          ,
//input                       key_sto         ,    
//input       [ 2:0]          color           ,
output  reg                 red             ,
output  reg                 green           ,
output  reg                 blue            ,
output  reg                 hysy            ,
output  reg                 vysy             

);

/*========================================================
===================define  parameter====================
====================================================== */

parameter                   DIV_PID         =       2       ;
parameter                   HYSY_SYS        =       96      ;
parameter                   HYSY_BPORCH     =       48      ;
parameter                   HYSY_DISPLAY    =       640     ;
parameter                   HYSY_FPORCH     =       16      ;
parameter                   HYSY_TOAL       =       800     ;
parameter                   VYSY_SYS        =       2       ;
parameter                   VYSY_BPORCH     =       33      ;
parameter                   VYSY_DISPLAY    =       480     ;
parameter                   VYSY_FPORCH     =       10      ;
parameter                   VYSY_TOAL       =       525     ;
//parameter                   TOAL            =       HYSY_TOAL + VYSY_TOAL       ;


reg                     key_en_r1           ;
reg                     key_en_r2           ;
//reg                     key_sto_r1          ;
//reg                     key_sto_r2          ;
reg                     div_clk             ;//25MHZ
reg [ 1:0]              div_cnt             ;//div_clk_25m计数器
reg [ 9:0]              hysy_cnt            ;//行扫描计数器
reg [ 9:0]              vysy_cnt            ;//场扫描计数器
reg                     start_flag          ;//开始输出数据
//reg                     hysy_down           ;
//reg                     hysy_up             ;
//reg                     vysy_down           ;
//reg                     vysy_up             ;
reg                     hysy_end            ;
//reg                     vysy_end            ;
reg                     value               ; 
/*reg                     cnt_flag            ;*/



/*========================================================
* =====================main     code======================
* ====================================================== */

/*-------------flag signal main code--------------------*/


//key_en_r1
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_en_r1 <= 1'b0                  ;
        end
        else begin
            key_en_r1 <= key_en                   ;
        end
end

//key_en_r2
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_en_r2 <= 1'b0                  ;
        end
        else begin
            key_en_r2 <= key_en_r1                ;
        end
end

//key_sto_r1    
/*always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_sto_r1 <= 1'b0              ;
        end
        else begin
            key_sto_r1 <= key_sto           ;
        end        
end

//key_sto_r2    
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_sto_r2 <= 1'b0              ;
        end
        else begin
            key_sto_r2 <= key_sto_r1        ;
        end        
end*/


//start_flag
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            start_flag <= 1'b0              ;
        end
        else if(key_en_r2 == 1'b1)begin
            start_flag <= ~start_flag       ;                 
        end
        else begin
            start_flag <= start_flag        ;
        end
end

//cnt_flag

/*always@(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            cnt_flag <= 1'b0                ;
        end
        else if(start_flag == 1'b0)begin
            cnt_flag <= 1'b0
        end
        else if(start_flag == 1'b1 && )
end*/



/*------------div_clk code----------------------*/

//div_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            div_cnt <= 2'd0                 ;
        end
        else if(div_cnt == (DIV_PID - 1'b1) )begin
            div_cnt <= 2'd0                 ;
        end
        else if(start_flag == 1'b1)begin
            div_cnt <= div_cnt + 1'b1       ;
        end
        else begin
            div_cnt <= div_cnt              ;
        end
end

//div_clk
always @(posedge s_clk or negedge s_rst_n )begin
        if(!s_rst_n)begin
            div_clk <= 1'b0                 ;
        end       
        else if(start_flag == 1'b1 && div_cnt==DIV_PID-1'b1)begin
            div_clk <= 1'b0                 ;
        end
        else if(start_flag == 1'b1 && div_cnt == 2'd0)begin
            div_clk <= 1'b1                 ;
        end
        else begin
            div_clk <= div_clk               ;
        end
end


/*----------------hysy main code-------------------------*/


//hysy_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            hysy_cnt <= 10'd0               ;
        end
        else if(start_flag == 1'b0)begin
            hysy_cnt <= 10'd0               ;
        end
        else if(hysy_cnt == (HYSY_TOAL - 1'b1) && div_clk == 1'b0)begin
            hysy_cnt <= 10'd0               ;
        end
        else if(start_flag == 1'b1 && div_clk == 1'b0)begin
            hysy_cnt <= hysy_cnt + 1'b1     ;
        end 
        else begin
            hysy_cnt <= hysy_cnt            ;
        end
end

//hysy_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            hysy_end <= 1'b0                ;
        end
        else if(hysy_cnt == (HYSY_TOAL-2'd2) && div_clk == 1'b0)begin
            hysy_end <= 1'b1                ;
        end
        else if(div_clk == 1'b0)begin
            hysy_end <= 1'b0                ;
        end
        else begin
            hysy_end <= hysy_end            ;
        end
end


//hysy_down
/*always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            hysy_down <= 1'b0               ;
        end
        else if(key_en_r2 == 1'b1 || (hysy_end == 1'b1 && div_clk == 1'b0))begin
            hysy_down <= 1'b1               ;
        end
        else if(div_clk == 1'b0)begin
            hysy_down <= 1'b0               ;
        end
        else begin
            hysy_down <= hysy_down          ;
        end
end

//hysy_up
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            hysy_up <= 1'b0                 ;
        end
        else if(hysy_cnt == (HYSY_SYS - 2'd2)&&div_clk == 1'b0)begin
            hysy_up <= 1'b1                 ; 
        end
        else if(div_clk == 1'b0)begin
            hysy_up <= 1'b0                 ;
        end
        else begin
            hysy_up <= hysy_up              ;
        end
end*/

//hysy
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            hysy <= 1'b1                    ;
        end
        else if((hysy_end == 1'b1 && div_clk == 1'b0) || key_en_r2 == 1'b1)begin
            hysy <= 1'b0                    ;
        end
        else if(hysy_cnt == HYSY_SYS - 1'b1 && div_clk == 1'b0)begin
            hysy <= 1'b1                    ; 
        end
        else begin
            hysy <= hysy                    ;
        end
end

/*----------------vysy main code-------------------------*/


//vysy_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            vysy_cnt <= 10'd0               ;
        end
        else if(start_flag == 1'b0)begin
            vysy_cnt <= 10'd0               ;
        end
        else if(vysy_cnt == (VYSY_TOAL -1'b1) && div_clk == 1'b0 && hysy_end == 1'b1)begin
            vysy_cnt <= 10'd0               ;
        end
        else if(hysy_end == 1'b1 && div_clk == 1'b0)begin
            vysy_cnt <= vysy_cnt + 1'b1     ;
        end
        else begin
            vysy_cnt <= vysy_cnt            ;
        end
end

//vysy_end
/*always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            vysy_end <= 1'b0                ;
        end
        else if(vysy_cnt == (VYSY_TOAL-1'b1) && div_clk == 1'b0 && hysy_end == 1'b1)begin
            vysy_end <= 1'b1                ;
        end
        else if(div_clk == 1'b0)begin
            vysy_end <= 1'b0                ;
        end
        else begin
            vysy_end <= vysy_end            ;
        end
end*/


//vysy_down
/*always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            vysy_down <= 1'b0               ;
        end
        else if( key_en_r2 == 1'b1 || (vysy_end == 1'b1 && div_clk == 1'b0))begin
            vysy_down <= 1'b1               ;
        end
        else if(div_clk == 1'b0)begin
            vysy_down <= 1'b0               ;
        end
        else begin
            vysy_down <= vysy_down          ;
        end
end

//vysy_up
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            vysy_up <= 1'b0                 ;
        end
        else if(vysy_cnt == (VYSY_SYS - 2'd2) && div_clk == 1'b0)begin
            vysy_up <= 1'b1                 ; 
        end
        else if(div_clk == 1'b0)begin
            vysy_up <= 1'b0                 ;
        end
        else begin
            vysy_up <= vysy_up              ;
        end
end*/

//vysy
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            vysy <= 1'b1                    ;
        end
        else if(key_en_r2 == 1'b1 || (vysy_cnt == (VYSY_TOAL -1'b1) && div_clk == 1'b0 && hysy_end == 1'b1))begin
            vysy <= 1'b0                    ;
        end
        else if(vysy_cnt == (VYSY_SYS - 1'B1) && div_clk == 1'b0)begin
            vysy <= 1'b1                    ; 
        end
        else begin
            vysy <= vysy                    ;
        end
end

/*--------------------dispay code----------------------*/


//value
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            value <= 1'b0                   ;
        end
        else if(hysy_cnt >(HYSY_SYS + HYSY_BPORCH - 1'b1) && hysy_cnt <(HYSY_SYS + HYSY_BPORCH + HYSY_DISPLAY - 1'b1) && vysy_cnt >(VYSY_SYS + VYSY_BPORCH - 1'b1) && vysy_cnt <(VYSY_SYS + VYSY_BPORCH + VYSY_DISPLAY - 1'b1))begin
            value <= 1'b1                   ;
        end
        else begin
            value <= 1'b0                   ;
        end
end

//red
//assign  red   = (value == 1'b1)? 1'b1 : 1'b0      ;
always @(*)begin
    if(value == 1'b1)begin
        if(hysy_cnt <= 10'd356)begin
            red = 1'b1          ;
        end
        else begin
            red = 1'b0          ;
        end
    end
    else begin
        red = 1'b0              ;
    end
end



//green
//assign  green = (value == 1'b1)? 1'b1 : 1'b0      ;
always @(*)begin
    if(value == 1'b1)begin
        if(hysy_cnt > 10'd356 && hysy_cnt <= 10'd569 )begin
            green = 1'b1          ;
        end
        else begin
            green = 1'b0          ;
        end
    end
    else begin
        green = 1'b0              ;
    end
end

//red
//assign  blue  = (value == 1'b1)? 1'b1 : 1'b0      ;
always @(*)begin
    if(value == 1'b1)begin
        if(hysy_cnt > 10'd569)begin
            blue = 1'b1          ;
        end
        else begin
            blue = 1'b0          ;
        end
    end
    else begin
        blue = 1'b0              ;
    end
end














endmodule
