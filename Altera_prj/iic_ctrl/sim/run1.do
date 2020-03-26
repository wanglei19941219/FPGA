quit -sim
vlib work

vlog "./*.v"
vlog "./../sor/*.v"

vsim -voptargs=+acc  work.iic_write_tb

view wave
view structure
view signals

add wave -divider {iic_write}
add wave iic_write_tb/iic_write_inst/*

.main clear
run 1ms