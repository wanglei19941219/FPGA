

vlib work
vlog "../sor/*.v"
vlog "./*.v"
vlog "./altera_libary/*.v"
vlog "./../db/ipcore_dir/*.v"
vsim -voptargs=+acc work.ctrl_top_tb
view wave
view structure
view signals

add wave  -divider {ctrl_top}
add wave  ctrl_top_tb/ctrl_top_inst/* 
add wave  -divider {uart_rx}
add wave  ctrl_top_tb/ctrl_top_inst/uart_rx_inst/*
add wave  -divider {decode}
add wave  ctrl_top_tb/ctrl_top_inst/sdram_decode_inst/*
add wave  -divider {wfifo}
add wave  ctrl_top_tb/ctrl_top_inst/wfifo_inst/*
add wave  -divider {sdram_write}
add wave  ctrl_top_tb/ctrl_top_inst/sdram_top_inst/sdram_write_inst/*
add wave  -divider {sdram_read}
add wave  ctrl_top_tb/ctrl_top_inst/sdram_top_inst/sdram_rd_inst/*
add wave  -divider {rfifo}
add wave  ctrl_top_tb/ctrl_top_inst/rfifo_inst/*
add wave  -divider {uart_tx}
add wave  ctrl_top_tb/ctrl_top_inst/uart_tx_inst/*
add wave  -divider {sdram_top}
add wave  ctrl_top_tb/ctrl_top_inst/sdram_top_inst/*
.main  clear 
run  12ms