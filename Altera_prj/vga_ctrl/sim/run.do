quit    -sim

vlib    work

vlog    "./*.v "
vlog    "./../sor/vga_ctrl.v"

vsim -voptargs=+acc     work.vga_ctrl_tb

view wave
view structure
view signals


add wave -divider {vga_ctrl}
add wave vga_ctrl_tb/vga_ctrl_inst/*

.main clear
run 12ms





































