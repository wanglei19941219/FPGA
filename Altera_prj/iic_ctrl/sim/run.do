quit -sim

vlib work
vlog "./iic_top_tb.v"
vlog "./../sor/*.v"

vsim -voptargs=+acc work.iic_top_tb

view wave
view structure
view signals

add wave -divider {iic_top}
add wave iic_top_tb/iic_top_inst/*
add wave -divider {key_ctrl}
add wave iic_top_tb/iic_top_inst/key_ctrl_inst/*
add wave -divider {iic_ctrl}
add wave iic_top_tb/iic_top_inst/iic_ctrl_inst/*

.main clear
run  1ms