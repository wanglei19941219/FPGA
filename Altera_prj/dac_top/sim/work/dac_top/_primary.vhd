library verilog;
use verilog.vl_types.all;
entity dac_top is
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        spi_clk         : out    vl_logic;
        spi_cs_n        : out    vl_logic;
        mosi            : out    vl_logic
    );
end dac_top;
