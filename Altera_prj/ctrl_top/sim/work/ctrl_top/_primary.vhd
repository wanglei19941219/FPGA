library verilog;
use verilog.vl_types.all;
entity ctrl_top is
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        data_in         : in     vl_logic;
        data_out        : out    vl_logic;
        sdram_clk       : out    vl_logic;
        sdram_cke       : out    vl_logic;
        sdram_cs_n      : out    vl_logic;
        sdram_addr      : out    vl_logic_vector(11 downto 0);
        sdram_baddr     : out    vl_logic_vector(1 downto 0);
        sdram_ras_n     : out    vl_logic;
        sdram_cas_n     : out    vl_logic;
        sdram_we_n      : out    vl_logic;
        sdram_dqm       : out    vl_logic_vector(1 downto 0);
        sdram_data      : inout  vl_logic_vector(15 downto 0)
    );
end ctrl_top;
