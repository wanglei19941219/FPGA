library verilog;
use verilog.vl_types.all;
entity key_ctrl is
    generic(
        DELAY_20MS      : integer := 9
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        key_in1         : in     vl_logic;
        key_in2         : in     vl_logic;
        write_en        : out    vl_logic;
        read_en         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DELAY_20MS : constant is 1;
end key_ctrl;
