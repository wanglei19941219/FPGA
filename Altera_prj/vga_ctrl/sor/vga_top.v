module vga_top (
input           s_clk           ,
input           s_rst_n         ,
input           key_in          ,
output wire     red             ,
output wire     green           ,
output wire     blue            ,
output wire     hysy            ,
output wire     vysy            

);


wire            key_out         ;         



 key_ctrl key_ctrl_inst(
.s_clk                (s_clk     ),
.s_rst_n              (s_rst_n   ),
.key_in2              (key_in    ),
.adc_en               (key_out   )  
);



vga_ctrl vga_ctrl_inst(
.s_clk                (s_clk     ),
.s_rst_n              (s_rst_n   ),
.key_en               (key_out   ),
//  key_sto              ,    
//  color                ,
.red                  (red       ),
.green                (green     ),
.blue                 (blue      ),
.hysy                 (hysy      ),
.vysy                 (vysy      ) 

);



endmodule
