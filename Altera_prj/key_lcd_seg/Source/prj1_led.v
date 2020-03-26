module prj1_led(
   input              clk    ,//时钟50Mhz
   input              rst_n  ,//低复位
   output reg[7:0]    led     //led灯输出
   
    );

   
    parameter      CNT_1S     =  49 ;//计数1秒
    parameter      CNT_7S     =  7         ;//计数7秒

    reg [7:0]          cnt_1s              ;
    reg [2: 0]         cnt_7s                ;

    /*-----------------------------------------
    /*-------main -------------------
    /*-----------------------------------*/

    //1秒计数器
    always@(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            cnt_1s<=8'd0                     ;
        end
        else if(cnt_1s==CNT_1S)begin
               cnt_1s<=3'd0                  ;    
        end
        else begin
               cnt_1s<=cnt_1s+1'b1            ;
        end
    end
    //7秒计数器
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            cnt_7s<=3'd0                      ;
        end
        else if(cnt_1s==CNT_1S&&cnt_7s==CNT_7S)begin
            cnt_7s<=3'd0                      ;
        end
        else if(cnt_1s==CNT_1S)begin
            cnt_7s<=cnt_7s+1'b1               ;
        end
        else begin
            cnt_7s<=cnt_7s                    ;
        end
    end
    //跑马灯led闪烁程序
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            led<=8'd1                          ;
        end
        else if(cnt_7s<=3'd0&&cnt_1s!=CNT_1S)begin
             led<=8'b01111111                  ;    
        end
         else if(cnt_7s<=3'd0&&cnt_1s==CNT_1S)begin
             led<=8'b10111111                  ;    
        end
         else if(cnt_7s<=3'd1&&cnt_1s==CNT_1S)begin
             led<=8'b11011111                  ;    
        end
         else if(cnt_7s<=3'd2&&cnt_1s==CNT_1S)begin
             led<=8'b11101111                  ;    
        end
         else if(cnt_7s<=3'd3&&cnt_1s==CNT_1S)begin
             led<=8'b11110111                  ;    
        end
         else if(cnt_7s<=3'd4&&cnt_1s==CNT_1S)begin
             led<=8'b11111011                  ;    
        end
         else if(cnt_7s<=3'd5&&cnt_1s==CNT_1S)begin
             led<=8'b11111101                  ;    
        end
         else if(cnt_7s<=3'd6&&cnt_1s==CNT_1S)begin
             led<=8'b11111110                  ;    
        end
         else if(cnt_7s<=3'd7&&cnt_1s==CNT_1S)begin
             led<=8'd1                         ;    
        end
        else begin
            led<=led                           ;
        end
    end



    endmodule
    
