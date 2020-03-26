`timescale 1 ns / 1 ns
module vga_ctrl_tb();

//system signal
reg                 s_clk                   ;
reg                 s_rst_n                 ;
//module signal 
reg                 key_en                  ;
//input                       key_sto         ;    
//input       [ 2:0]          color           ;
wire                red                     ;
wire                green                   ;
wire                blue                    ;
wire                hysy                    ;
wire                vysy                    ;



/*========================================================
=====================main     code======================
====================================================== */

initial begin

s_clk    = 1'b1         ;
s_rst_n  = 1'b1         ;
key_en   = 1'b0         ;
#60     ;
s_rst_n  = 1'b0         ;
#60     ;
s_rst_n  = 1'b1         ;
#100    ;
key_en   = 1'b1         ;
#20     ;
key_en   = 1'b0         ;

end

always  # 10    s_clk = ~s_clk      ;




vga_ctrl vga_ctrl_inst(


.s_clk                            (s_clk             ),
.s_rst_n                          (s_rst_n           ), 
.key_en                           (key_en            ),
//key_sto                         (/key_sto          ) ,    
//color                           (/color            ) ,
.red                              (red               ),
.green                            (green             ),
.blue                             (blue              ),
.hysy                             (hysy              ),
.vysy                             (vysy              ) 

);






endmodule 
