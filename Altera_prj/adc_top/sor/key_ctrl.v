module key_ctrl(
input                   s_clk           ,
input                   s_rst_n         ,
input                   key_in2         ,
output  wire            adc_en         
);

/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter      DELAY_20MS    =   999999 ;//999999

reg              key_in2_r1             ;
reg              key_in2_r2             ;
reg              key_out2_r1            ;
reg [19:0]       delay_cnt              ;
wire             key2_flag              ;
reg              key_out2               ;



/******************************************************************
* *************************** main   code *************************
* ****************************************************************/



//key_in2 打拍
always @(posedge s_clk) begin
    key_in2_r1 <= key_in2    ;
    key_in2_r2 <= key_in2_r1 ;
end

//key2_flag
assign      key2_flag = key_in2_r1 ^ key_in2_r2 ; 

always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            delay_cnt <= 20'd0          ; 
        end
        else if(delay_cnt == DELAY_20MS || key2_flag == 1'b1)begin
            delay_cnt <= 20'd0          ;
        end
        else begin
            delay_cnt <= delay_cnt + 1'b1   ;
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

//adc_en
assign  adc_en  = (key_out2_r1 & (~key_out2))      ; 



endmodule

