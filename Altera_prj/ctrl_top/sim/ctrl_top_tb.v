`timescale   1 ns / 1 ns


module ctrl_top_tb();
reg                     s_clk       ;
reg                     s_rst_n     ;
reg   [ 7:0]            mem_a[ 5:0] ;
//uart  siganlendmodule
reg                     data_in     ;
wire                    data_out    ;
//sdram  diganl
wire                    sdram_clk   ;
wire                    sdram_cke   ;
wire                    sdram_cs_n  ;
wire[11:0]              sdram_addr  ;
wire[ 1:0]              sdram_baddr ;
wire                    sdram_ras_n ; 
wire                    sdram_cas_n ;
wire                    sdram_we_n  ;
wire[ 1:0]              sdram_dqm   ;
wire[15:0]              sdram_data  ;

defparam sdram_model_plus.addr_bits =	12;
defparam sdram_model_plus.data_bits = 	16;
defparam sdram_model_plus.col_bits  =	9;
defparam sdram_model_plus.mem_sizes =	2*1024*1024;

initial begin
s_clk   =   0   ;
s_rst_n =   1   ;
data_in =   1'b1;
#40             ;
s_rst_n =   0   ;
#60             ;
s_rst_n =   1   ;
#205000         ;
tx_byte()       ;

end

always  #10     s_clk = ~s_clk      ;

initial $readmemh("./tx_data.txt",mem_a);

task tx_byte();
    integer i ;
    for(i=0;i<6;i=i+1)begin
        tx_bit(mem_a[i]);
    end
endtask

task tx_bit(
input [ 7: 0]   data
);
     integer j;
     for(j=0;j<10;j=j+1)begin
        case (j)
              
              0 :  data_in    <=    1'b0   ;
              1 :  data_in    <=    data[0];
              2 :  data_in    <=    data[1];
              3 :  data_in    <=    data[2];
              4 :  data_in    <=    data[3];
              5 :  data_in    <=    data[4];
              6 :  data_in    <=    data[5];
              7 :  data_in    <=    data[6];
              8 :  data_in    <=    data[7];
              9 :  data_in    <=    1'b1   ;

            
         endcase
         #104160;
     end



 endtask

 ctrl_top ctrl_top_inst(
.s_clk                           (s_clk          ),
.s_rst_n                         (s_rst_n        ),
.data_in                         (data_in        ),
.data_out                        (data_out       ),
.sdram_cs_n                      (sdram_cs_n     ),
.sdram_addr                      (sdram_addr     ),
.sdram_baddr                     (sdram_baddr    ),
.sdram_ras_n                     (sdram_ras_n    ),
.sdram_cas_n                     (sdram_cas_n    ),
.sdram_we_n                      (sdram_we_n     ),
.sdram_dqm                       (sdram_dqm      ),
.sdram_data                      (sdram_data     ),
.sdram_clk                       (sdram_clk      ),
.sdram_cke                       (sdram_cke      )

);

sdram_model_plus sdram_model_plus (
   . Dq                  (sdram_data) ,
   . Addr                (sdram_addr) ,
   . Ba                  (sdram_baddr) ,
   . Clk                 (sdram_clk) ,
   . Cke                 (sdram_cke) ,
   . Cs_n                (sdram_cs_n) ,
   . Ras_n               (sdram_ras_n) ,
   . Cas_n               (sdram_cas_n) , 
   . We_n                (sdram_we_n ) ,
   . Dqm                 (sdram_dqm  ) ,
   . Debug               (1'b1       ) 
   );









endmodule
