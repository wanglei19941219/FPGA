module iic_ctrl(
//system signal
input                   s_clk           ,
input                   s_rst_n         ,
//iic signal
input                   write_en        ,
input                   read_en         ,
output  reg             i_clk           ,
output  wire[ 7:0]      led             ,
inout                   sda             
);
/******************************************************************
* *************************define parameter ***********************
* ****************************************************************/
parameter           H_CYC        =   7'd124     ;
parameter           IDLE         =   7'b000_0001;
parameter           START        =   7'b000_0010;
parameter           WRITE        =   7'b000_0100;
parameter           READ         =   7'b000_1000;
parameter           CHK_ACK      =   7'b001_0000;
parameter           GEN_STOP     =   7'b100_0000;
parameter           GEN_ACK_NCK  =   7'b010_0000;


reg [ 6:0]              state /*synthesis preserve*/              ;
reg                     start_flag          ;
reg                     write_end           ;
reg                     write_flag          ;
reg                     read_flag           ;
reg                     stop_end            ;
reg [ 6:0]              div_cnt             ;
reg                     div_clk             ;
reg                     rx_clk              ;
reg                     rx_clk_r1           ;
reg [ 3:0]              wr_bit_cnt          ;
reg                     wr_bit_end          ;
reg [ 3:0]              rd_bit_cnt          ;
reg                     rd_bit_end          ;
reg [ 1:0]              wr_byte_cnt         ;
reg [ 1:0]              rd_byte_cnt         ;
reg                     rd_sta_flag         ;
reg                     gen_ack_nck_end     ;
wire[ 7:0]              wr_cmd              ;
wire[ 7:0]              rd_cmd              ;
wire[ 7:0]              wr_addr             ;
wire[ 7:0]              rd_addr             ;
wire[ 7:0]              wr_data             ;
reg [ 7:0]              rd_data             ;
reg                     wr_sda              ;
reg [ 7:0]              wr_rx_data          ;
reg                     rx_sda              ;
reg                     sda_r1              ;
reg                     ack_end             ;
reg                     rd_wr_end           ;

/******************************************************************
* *************************** main   code *************************
* ****************************************************************/
//state
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            state <= IDLE                   ;
        end
        else case(state)
            IDLE                : if(write_en == 1'b1 || read_en == 1'b1 || (read_flag == 1'b1 && rd_wr_end == 1'b1 && rd_sta_flag == 1'b0))begin
                                     state <= START      ;
                                  end
                                  else if(write_flag == 1'b1 || (read_flag == 1'b1 && rd_wr_end == 1'b0 && rd_sta_flag == 1'b0))begin
                                       state <= WRITE      ;   
                                  end
                                  else if(rd_sta_flag == 1'b1)begin
                                       state <= READ       ;
                                  end
                                  else begin
                                       state <= IDLE       ;
                                  end                          
            START               : if(div_cnt == H_CYC && div_clk == 1'b0 && rx_clk == 1'b1)begin
                                       state <= WRITE      ;            
                                  end
                                  else begin
                                       state <= START      ;
                                  end
            WRITE               : if(wr_bit_end == 1'b1 || rd_bit_end == 1'b1)begin
                                       state <= CHK_ACK    ;
                                  end
                                  else begin
                                       state <= WRITE      ;
                                  end
            READ                : if(rd_bit_end == 1'b1)begin
                                       state <= GEN_ACK_NCK ; 
                                  end
                                  else begin
                                       state <= READ        ;
                                  end
            CHK_ACK             : if(sda == 1'b0 && write_end == 1'b0 && ack_end == 1'b1)begin
                                       state <= IDLE        ;
                                  end
                                  else if(sda == 1'b0 && write_end == 1'b1 && ack_end == 1'b1)begin
                                       state <= GEN_STOP    ;
                                  end
                                  else begin
                                       state <= CHK_ACK     ;
                                  end           
            GEN_ACK_NCK         : if(sda == 1'b0 && gen_ack_nck_end == 1'b1)begin
                                       state <= IDLE        ;
                                  end
                                  else if(sda == 1'b1 && gen_ack_nck_end == 1'b1)begin
                                       state <= GEN_STOP    ;
                                  end
                                  else begin
                                       state <= GEN_ACK_NCK ;
                                  end
             GEN_STOP           : if(stop_end == 1'b1)begin
                                       state <= IDLE        ;
                                  end
                                  else begin
                                       state <= GEN_STOP    ;  
                                  end
                            default :  state <= IDLE        ;             
        endcase
end

//stop_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            stop_end <= 1'b0                ;
        end
        else if(state == GEN_STOP && div_cnt == (H_CYC-3) && rx_clk == 1'b1 && div_clk == 1'b0)begin
            stop_end <= 1'b1                ;
        end
        else begin
            stop_end <= 1'b0                ;
        end
end
//start_flag
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            start_flag <= 1'b0              ;
        end
        else if(write_en == 1'b1 || read_en == 1'b1)begin
            start_flag <= 1'b1              ;
        end
        else if(stop_end == 1'b1)begin
            start_flag <= 1'b0              ;
        end
        else begin
            start_flag <= start_flag        ;
        end
end

//wr_bit_end
/*always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_bit_end <= 1'b0             ;
        end
        else if((&wr_bit_cnt) == 1'b1 && state == WRITE && div_cnt == (H_CYC-1) && div_clk == 1'b1 && rx_clk == 1'b0)begin
            wr_bit_end <= 1'b1             ;
        end
        else begin
            wr_bit_end <= 1'b0             ;
        end
end*/

//wr_bit_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_bit_cnt <= 4'd0              ;
        end
        else if(wr_bit_cnt == 4'd8 && wr_bit_end == 1'b1 || write_flag == 1'b0)begin
            wr_bit_cnt <= 4'd0              ;
        end
        else if( state == WRITE && div_cnt == H_CYC && div_clk == 1'b1 && rx_clk == 1'b0)begin
            wr_bit_cnt <= wr_bit_cnt + 1'b1 ;
        end
        else begin
            wr_bit_cnt <= wr_bit_cnt        ;
        end
end

//wr_byte_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_byte_cnt <= 2'd0             ;
        end
        else if(wr_bit_end == 1'b1 && wr_byte_cnt == 2'd2 || write_flag == 1'b0)begin
            wr_byte_cnt <= 2'd0                 ;
        end
        else if(wr_bit_end)begin
            wr_byte_cnt <= wr_byte_cnt + 1'b1   ;
        end
        else begin
            wr_byte_cnt <= wr_byte_cnt          ;
        end
end

//write_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            write_end <= 1'b0               ;
        end
        else if(wr_bit_end == 1'b1 && wr_byte_cnt == 2'd2)begin
            write_end <= 1'b1               ;
        end
        else if(state == CHK_ACK)begin
            write_end <= write_end          ;
        end
        else begin
            write_end <= 1'b0               ;
        end
end
//write_flag
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            write_flag <= 1'b0              ;
        end
        else if(write_en)begin
            write_flag <= 1'b1              ;
        end
        else if(stop_end)begin
            write_flag <= 1'b0              ;
        end
        else begin
            write_flag <= write_flag        ;
        end
end

//rd_bit_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_bit_cnt <= 4'd0              ;
        end
        else if((rd_bit_cnt == 4'd8 && div_cnt == H_CYC &&div_clk == 1'b1 && rx_clk == 1'b0) || read_flag == 1'b0)begin
            rd_bit_cnt <= 4'd0              ;
        end
        else if((state == WRITE ||state == READ) && div_cnt == H_CYC &&div_clk == 1'b1 && rx_clk == 1'b0)begin
            rd_bit_cnt <= rd_bit_cnt + 1'b1 ;
        end
        else begin
            rd_bit_cnt <= rd_bit_cnt        ;
        end
end

//wr_bit_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            wr_bit_end <= 1'b0              ;
        end
        else if(state == WRITE && wr_bit_cnt == 4'd8 && div_cnt == (H_CYC-1) && div_clk == 1'b1 && rx_clk == 1'b0)begin
            wr_bit_end <= 1'b1              ;
        end
        else begin
            wr_bit_end <= 1'b0              ;
        end
end

//rd_bit_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_bit_end <= 1'b0             ;
        end       
        else if(rd_bit_cnt == 4'd8 && (state == READ || state == WRITE) && div_cnt == (H_CYC-3) && div_clk == 1'b1 && rx_clk == 1'b0)begin
            rd_bit_end <= 1'b1             ;
        end
        else begin
            rd_bit_end <= 1'b0             ;
        end
end



//rd_byte_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_byte_cnt <= 2'd0             ;
        end
         else if((rd_bit_end == 1'b1 && rd_byte_cnt == 2'd3) || read_flag == 1'b0)begin
            rd_byte_cnt <= 2'd0                 ;
        end
        else if(rd_bit_end)begin
            rd_byte_cnt <= rd_byte_cnt + 1'b1   ;
        end       
        else begin
            rd_byte_cnt <= rd_byte_cnt          ;
        end
end

//read_flag
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            read_flag <= 1'b0               ;
        end
        else if(read_en == 1'b1)begin
            read_flag <= 1'b1               ;
        end
        else if(stop_end == 1'b1)begin
            read_flag <= 1'b0               ;
        end
        else begin
            read_flag <= read_flag          ;
        end
end

//div_cnt
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            div_cnt <= 7'd0                 ;
        end
        else if(div_cnt == H_CYC || start_flag == 1'b0)begin
            div_cnt <= 7'd0                 ;
        end
        else if(start_flag == 1'b1)begin
            div_cnt <= div_cnt + 1'b1       ; 
        end
        else begin
            div_cnt <= 1'b0                 ;
        end
end

//div_clk
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            div_clk <= 1'b1                 ;
        end
        else if(start_flag == 1'b0)begin
            div_clk <= 1'b1                 ;
        end
        else if(div_cnt == H_CYC)begin
            div_clk <= ~div_clk             ;
        end
        else begin
            div_clk <= div_clk              ;
        end
end

//rx_clk
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rx_clk <= 1'b1                  ;
        end
        else if(start_flag == 1'b0)begin
            rx_clk <= 1'b1                  ;
        end
        else if(div_cnt == H_CYC && div_clk == 1'b0)begin
            rx_clk <= ~rx_clk               ;
        end
        else begin
            rx_clk <= rx_clk                ;
        end
end

//rx_clk_r1
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rx_clk_r1 <= 1'b1               ;
        end
        else begin
            rx_clk_r1 <= rx_clk             ;
        end
end

//i_clk
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            i_clk <= 1'b1                   ;
        end
        else begin
            i_clk <= rx_clk_r1              ;
        end
end

//rd_sta_flag       
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_sta_flag <= 1'b0             ;
        end
        else if(state == GEN_STOP || read_flag == 1'b0)begin
            rd_sta_flag <= 1'b0             ;
        end
        else if(ack_end == 1'b1 && rd_byte_cnt == 2'd3)begin
            rd_sta_flag <= 1'b1             ;
        end
        else begin
            rd_sta_flag <= 1'b0             ;
        end
end

//gen_ack_nck_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            gen_ack_nck_end <= 1'b0         ;
        end
        else if(state == GEN_ACK_NCK && div_cnt == (H_CYC-1) && div_clk == 1'b1 && rx_clk == 1'b0 )begin
            gen_ack_nck_end <= 1'b1         ;
        end
        else begin
            gen_ack_nck_end <= 1'b0         ;
        end
end

//wr_cmd 
assign  wr_cmd    = 8'b1010_0000               ;
//rd_cmd 
assign  rd_cmd    = 8'b1010_0001               ;
//wr_addr
assign  wr_addr   = 8'd104                     ;
//rd_addr
assign  rd_addr   = 8'd104                     ;
//wr_data
assign  wr_data   = 8'd22                     ;
//wr_rx_data
always @(*)begin
        if(write_flag == 1'b1 && state == WRITE)begin
            case (wr_byte_cnt)
                    0   :  wr_rx_data <= wr_cmd  ;
                    1   :  wr_rx_data <= wr_addr ;
                    2   :  wr_rx_data <= wr_data ;
                  default : wr_rx_data <= 8'd0   ;
            endcase
        end
        else if(read_flag == 1'b1 && state == WRITE)begin
            case (rd_byte_cnt)
                    0   :  wr_rx_data <= wr_cmd  ;
                    1   :  wr_rx_data <= rd_addr ;
                    2   :  wr_rx_data <= rd_cmd  ;
                  default : wr_rx_data <= 8'd0   ;
            endcase
        end
        else begin
            wr_rx_data = 8'd0                   ;
        end
end

//rd_data
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_data <= 8'd0                   ;
        end
        else if(state == READ && div_cnt == (H_CYC-3) && div_clk == 1'b0 && rx_clk == 1'b0)begin
            rd_data <= {sda,rd_data[7:1]}       ;
        end
        else begin
            rd_data <= rd_data                  ;                     
        end
end
//wr_sda 
always @(*)begin
        if(state == WRITE && write_flag == 1'b1)begin
              case (wr_bit_cnt)
                    0   : wr_sda = 1'b0            ;
                    1   : wr_sda = wr_rx_data[7]   ;
                    2   : wr_sda = wr_rx_data[6]   ;
                    3   : wr_sda = wr_rx_data[5]   ;
                    4   : wr_sda = wr_rx_data[4]   ;
                    5   : wr_sda = wr_rx_data[3]   ;
                    6   : wr_sda = wr_rx_data[2]   ;
                    7   : wr_sda = wr_rx_data[1]   ;
                    8   : wr_sda = wr_rx_data[0]   ;
                    default : wr_sda = 1'b0        ;
              endcase
        end
        else if(state == WRITE && read_flag == 1'b1)begin
              case (rd_bit_cnt)
                    0   : wr_sda = 1'b0            ;
                    1   : wr_sda = wr_rx_data[7]   ;
                    2   : wr_sda = wr_rx_data[6]   ;
                    3   : wr_sda = wr_rx_data[5]   ;
                    4   : wr_sda = wr_rx_data[4]   ;
                    5   : wr_sda = wr_rx_data[3]   ;
                    6   : wr_sda = wr_rx_data[2]   ;
                    7   : wr_sda = wr_rx_data[1]   ;
                    8   : wr_sda = wr_rx_data[0]   ;
                    default : wr_sda = 1'b0        ;
              endcase
        end
        else begin
                wr_sda = 1'b0       ;
        end
end

//rx_sda
always @(*)begin
        case (state)
            IDLE            : rx_sda = 1'b1 ;
            START           : if(div_cnt == (H_CYC) && div_clk == 1'b1 && rx_clk == 1'b1)begin
                                    rx_sda = 1'b0         ;
                              end
                              else begin
                                    rx_sda = rx_sda       ;
                              end
            WRITE           :       rx_sda = wr_sda       ;            
            /*READ            :       rx_sda = sda          ;
            CHK_ACK         :       rx_sda = sda          ;*/
            GEN_STOP        : if(div_cnt == 7'd0 && div_clk == 1'b0 && rx_clk == 1'b0)begin
                                    rx_sda = 1'b0         ;
                              end
                              else if(div_cnt == (H_CYC-4) && div_clk == 1'b1 && rx_clk == 1'b1)begin
                                    rx_sda = 1'b1         ;
                              end                            
                              else begin
                                    rx_sda = rx_sda       ;
                              end
            GEN_ACK_NCK     : rx_sda = 1'b1               ;  
           default   :   rx_sda = 1'b0                    ;
        endcase
end

//sda_r1
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            sda_r1 <= 1'b1      ;
        end
        else begin
            sda_r1 <= rx_sda    ;
        end
end

//ack_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
           ack_end <= 1'b0      ; 
        end
        else if(state == CHK_ACK && div_cnt == 2 && div_clk == 1'b1 && rx_clk == 1'b0)begin
           ack_end <= 1'b1      ;
        end
        else begin
           ack_end <= 1'b0      ;
        end
end

//rd_wr_end
always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            rd_wr_end <= 1'b0   ;
        end
        else if(ack_end == 1'b1 && rd_byte_cnt == 2'd2)begin
            rd_wr_end <= 1'b1   ;
        end
        else begin
            rd_wr_end <= 1'b0   ;
        end
end


//led
assign led = rd_data            ;

//sda 
assign sda = (state == READ || state == CHK_ACK)? 1'bz : sda_r1 ;
/*assign sda = (state == READ)? 1'bz : sda_r1 ;*/

endmodule
