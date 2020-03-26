library verilog;
use verilog.vl_types.all;
entity dac_data is
    generic(
        DELAY_TM        : integer := 499999
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        dac_data        : out    vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DELAY_TM : constant is 1;
end dac_data;
