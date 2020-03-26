library verilog;
use verilog.vl_types.all;
entity dac_ctrl is
    generic(
        DIV_END         : integer := 3;
        DA_END          : integer := 11
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        data_in         : in     vl_logic_vector(9 downto 0);
        spi_clk         : out    vl_logic;
        mosi            : out    vl_logic;
        spi_cs_n        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DIV_END : constant is 1;
    attribute mti_svvh_generic_type of DA_END : constant is 1;
end dac_ctrl;
