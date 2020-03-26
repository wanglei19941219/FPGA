module adc_top(
input                   s_clk        ,
input                   s_rst_n      ,
input                   key          ,
input                   adc_out      ,
output wire             adc_clk      ,//400KHZ
output wire             adc_cs_n     ,
output wire [ 3:0]      seg_cs_n     ,
output wire [ 7:0]      seg_data            


);

wire        adc_en          ;
wire        con_end         ;
wire[11:0]  vol             ;  
wire        con_ok          ;
wire        sam_end         ;
wire[ 7:0]  dout            ;





key_ctrl key_ctrl_inst(
.s_clk                 (s_clk     ),
.s_rst_n               (s_rst_n   ),
.key_in2               (key       ),
.adc_en                (adc_en    )
);



seg_ctrl srg_ctrl_inst(
.s_clk                 (s_clk),
.s_rst_n               (s_rst_n),
.con_end               (con_end),
.vol                   (vol),
.seg_cs_n              (seg_cs_n),
.seg_data              (seg_data)
);




adc_ctrl adc_ctrl_inst(
.s_clk                  (s_clk),//50MHZ
.s_rst_n                (s_rst_n),
.adc_en                 (adc_en),
.adc_out                (adc_out),
.adc_clk                (adc_clk),//400KHZ
.adc_cs_n               (adc_cs_n),
.dout                   (dout),
.con_ok                 (con_ok),
.sam_end                (sam_end)

);




adc_con adc_con_inst(
.s_clk                  (s_clk),
.s_rst_n                (s_rst_n),
.sam_end                (sam_end),
.dout                   (dout),
.vol                    (vol),
.con_end                (con_end) 
);








endmodule
