library verilog;
use verilog.vl_types.all;
entity iic_top is
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        key_in1         : in     vl_logic;
        key_in2         : in     vl_logic;
        i_clk           : out    vl_logic;
        led             : out    vl_logic_vector(7 downto 0);
        sda             : inout  vl_logic
    );
end iic_top;
