module iic_top(
//system signal
input                   s_clk           ,
input                   s_rst_n         ,
//interface signal
input                   key_in1         ,
input                   key_in2         ,
output  wire            i_clk           ,
output  wire[ 7:0]      led             ,
inout                   sda             
);

wire                    write_en /*synthesis keep*/       ;
wire                    read_en /*synthesis keep*/       ;

key_ctrl key_ctrl_inst(
.s_clk                    (s_clk          ),
.s_rst_n                  (s_rst_n        ),
.key_in1                  (key_in1        ),
.key_in2                  (key_in2        ),
.write_en                 (write_en       ),
.read_en                  (read_en        )
);




 iic_ctrl iic_ctrl_inst(  
.s_clk                    (s_clk          ),
.s_rst_n                  (s_rst_n        ),
.write_en                 (write_en       ),
.read_en                  (read_en        ),
.i_clk                    (i_clk          ),
.led                      (led            ),
.sda                      (sda            ) 
);




endmodule 
