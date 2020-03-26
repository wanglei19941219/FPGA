library verilog;
use verilog.vl_types.all;
entity uart_rx is
    generic(
        BAND_END        : integer := 5207;
        HALF_BAND_END   : integer := 2603
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        data_in         : in     vl_logic;
        data_rx         : out    vl_logic_vector(7 downto 0);
        po_flag         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BAND_END : constant is 1;
    attribute mti_svvh_generic_type of HALF_BAND_END : constant is 1;
end uart_rx;
