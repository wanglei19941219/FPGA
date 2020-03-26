quit -sim

vlib work

vlog "./*.v"
vlog "./../sor/*.v"

vsim -voptargs=+acc work.adc_ctrl_tb

view wave
view structure
view signals

add wave -divider {adc_crtl}
add wave adc_ctrl_tb/adc_ctrl_inst/*

.main clear

run 100us