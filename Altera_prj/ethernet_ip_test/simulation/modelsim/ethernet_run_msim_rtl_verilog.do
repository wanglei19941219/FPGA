transcript on
if ![file isdirectory ethernet_iputf_libs] {
	file mkdir ethernet_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
vlib ethernet_iputf_libs/i_tse_mac
vmap i_tse_mac ./ethernet_iputf_libs/i_tse_mac
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_eth_tse_mac.v"                  -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_clk_cntl.v"                 -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_crc328checker.v"            -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_crc328generator.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_crc32ctl8.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_crc32galois8.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_gmii_io.v"                  -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_lb_read_cntl.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_lb_wrt_cntl.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_hashing.v"                  -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_host_control.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_host_control_small.v"       -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mac_control.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_register_map.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_register_map_small.v"       -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_counter_cntl.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_shared_mac_control.v"       -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_shared_register_map.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_counter_cntl.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_lfsr_10.v"                  -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_loopback_ff.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_altshifttaps.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_fifoless_mac_rx.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mac_rx.v"                   -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_fifoless_mac_tx.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mac_tx.v"                   -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_magic_detection.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mdio.v"                     -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mdio_clk_gen.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mdio_cntl.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_mdio.v"                 -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mii_rx_if.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_mii_tx_if.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_pipeline_base.v"            -work i_tse_mac
vlog -sv "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_pipeline_stage.sv"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_dpram_16x32.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_dpram_8x32.v"               -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_dpram_ecc_16x32.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_quad_16x32.v"               -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_quad_8x32.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_fifoless_retransmit_cntl.v" -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_retransmit_cntl.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rgmii_in1.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rgmii_in4.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_nf_rgmii_module.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rgmii_module.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rgmii_out1.v"               -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rgmii_out4.v"               -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_ff.v"                    -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_min_ff.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_ff_cntrl.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_ff_cntrl_32.v"           -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_ff_cntrl_32_shift16.v"   -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_ff_length.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_rx_stat_extract.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_timing_adapter32.v"         -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_timing_adapter8.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_timing_adapter_fifo32.v"    -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_timing_adapter_fifo8.v"     -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_1geth.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_fifoless_1geth.v"       -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_w_fifo.v"               -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_w_fifo_10_100_1000.v"   -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_wo_fifo.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_wo_fifo_10_100_1000.v"  -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_top_gen_host.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_ff.v"                    -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_min_ff.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_ff_cntrl.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_ff_cntrl_32.v"           -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_ff_cntrl_32_shift16.v"   -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_ff_length.v"             -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_ff_read_cntl.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_tx_stat_extract.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_false_path_marker.v"        -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_reset_synchronizer.v"       -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_clock_crosser.v"            -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_a_fifo_13.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_a_fifo_24.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_a_fifo_34.v"                -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_a_fifo_opt_1246.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_a_fifo_opt_14_44.v"         -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_a_fifo_opt_36_10.v"         -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_gray_cnt.v"                 -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_sdpm_altsyncram.v"          -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_altsyncram_dpm_fifo.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_bin_cnt.v"                  -work i_tse_mac
vlog -sv "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ph_calculator.sv"           -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_sdpm_gen.v"                 -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_dec_x10.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x10.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x10_wrapper.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_dec_x14.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x14.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x14_wrapper.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_dec_x2.v"               -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x2.v"               -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x2_wrapper.v"       -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_dec_x23.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x23.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x23_wrapper.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_dec_x36.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x36.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x36_wrapper.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_dec_x40.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x40.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x40_wrapper.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_dec_x30.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x30.v"              -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_enc_x30_wrapper.v"      -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/altera_eth_tse_mac/mentor/altera_tse_ecc_status_crosser.v"       -work i_tse_mac
vlog     "E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_sim/ethernet.v"                                                                     


vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/ethernet {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/ethernet/ethernet_tb.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/ethgen.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/ethgen2.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/ethgen32.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/ethmon.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/ethmon_32.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/ethmon2.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/loopback_adapter.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/loopback_adapter_fifo.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/mdio_reg.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/mdio_slave.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/nf_phyip_reset_model.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/top_ethgen8.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/top_ethgen32.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/top_ethmon32.v}
vlog -vlog01compat -work work +incdir+E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models {E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/models/top_mdio_slave.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L i_tse_mac -voptargs="+acc"  tb

do E:/GIT_Project/project/Altera_prj/ethernet_ip_test/ethernet_testbench/testbench_verilog/ethernet/ethernet_wave.do
