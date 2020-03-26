quit -sim

vlib work

vlog "./dac_top_tb.v"
vlog "./../sor/*.v"

vsim -voptargs=+acc work.dac_top_tb

view wave
view structure
view signals

add wave -divider {dac_top}
add wave dac_top_tb/dac_top_inst/*
add wave -divider {dac_data}
add wave dac_top_tb/dac_top_inst/dac_data_inst/*
add wave -divider {dac_ctrl}
add wave dac_top_tb/dac_top_inst/dac_ctrl_inst/*

.main clear

run 40ms