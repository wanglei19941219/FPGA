module key_ctrl(
input                   s_clk           ,
input                   s_rst_n         ,
input                   key_in1         ,
input                   key_in2         ,
output  wire            write_en        ,
output  wire            read_en         
);

/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter      DELAY_20MS    =   999999 ;//999999
reg              key_in1_r1             ;
reg              key_in1_r2             ;
reg              key_in2_r1             ;
reg              key_in2_r2             ;
reg              key_out1_r1            ;
reg              key_out2_r1            ;
reg [19:0]       delay_cnt              ;
wire             key1_flag              ;
wire             key2_flag              ;
reg              key_out1               ;
reg              key_out2               ;
/*reg              start_flag             ;*/


/******************************************************************
* *************************** main   code *************************
* ****************************************************************/

//key_in1 打拍
always @(posedge s_clk) begin
    key_in1_r1 <= key_in1    ;
    key_in1_r2 <= key_in1_r1 ;
end

//key_in2 打拍
always @(posedge s_clk) begin
    key_in2_r1 <= key_in2    ;
    key_in2_r2 <= key_in2_r1 ;
end

//key1_flag
assign      key1_flag = key_in1_r1 ^ key_in1_r2 ;

//key2_flag
assign      key2_flag = key_in2_r1 ^ key_in2_r2 ; 

//start_flag
/*always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            start_flag <= 1'b0          ;
        end
        else if(key1_flag == 1'b1 || key2_flag == 1'b1)begin
            start_flag <= 1'b1          ;
        end
        else if(delay_cnt == DELAY_20MS)begin
            start_flag <= 1'b0          ;
        end
        else begin
            start_flag <= start_flag    ;
        end
end*/

//delay_cnt
/*always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            delay_cnt <= 20'd0          ; 
        end
        else if(delay_cnt == DELAY_20MS || key1_flag == 1'b1 || key2_flag == 1'b1)begin
            delay_cnt <= 20'd0          ;
        end
        else if(start_flag == 1'b1)begin
            delay_cnt <= delay_cnt + 1'b1   ;
        end
        else begin
            delay_cnt <= 20'd0          ;
        end
end*/

always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            delay_cnt <= 20'd0          ; 
        end
        else if(delay_cnt == DELAY_20MS || key1_flag == 1'b1 || key2_flag == 1'b1)begin
            delay_cnt <= 20'd0          ;
        end
        else begin
            delay_cnt <= delay_cnt + 1'b1   ;
        end       
end

//key_out1_r1
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_out1_r1 <= 1'b1           ;
        end
        else if(delay_cnt == DELAY_20MS)begin
            key_out1_r1 <= key_in1_r2     ;
        end
        else begin
            key_out1_r1 <= key_out1_r1    ;
        end
end

//key_out1
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_out1 <= 1'b1            ;
        end
        else begin
            key_out1 <= key_out1_r1     ;
        end
end

//key_out2_r1       
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_out2_r1 <= 1'b1         ;
        end
        else if(delay_cnt == DELAY_20MS) begin
            key_out2_r1 <= key_in2_r2   ;
        end
        else begin
            key_out2_r1 <= key_out2_r1  ;
        end
end

//key_out2
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            key_out2 <= 1'b1            ;
        end
        else begin
            key_out2 <= key_out2_r1     ;
        end
end

//write_en
assign  write_en = (key_out1_r1 & (~key_out1))    ;

//read_en
assign  read_en  = (key_out2_r1 & (~key_out2))      ; 



endmodule
