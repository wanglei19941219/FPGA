module dds(
input                   s_clk       ,
input                   s_rst_n     ,
output wire[ 7:0]       sin_data    

);             
 reg [ 7:0]       addr  ;

always @(posedge s_clk or negedge s_rst_n)begin
        if(!s_rst_n)begin
            addr <= 8'd0            ;
        end
        else begin
            addr <= addr + 1'b1     ;
        end
end



sp_ram_256x8	sp_ram_256x8_inst (
	.clock ( s_clk ),
	.data (  ),
	.rdaddress ( addr ),
	.wraddress (  ),
	.wren (  ),
	.q ( sin_data )
	);




endmodule
