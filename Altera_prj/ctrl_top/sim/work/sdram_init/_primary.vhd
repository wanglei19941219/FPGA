library verilog;
use verilog.vl_types.all;
entity sdram_init is
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        sdram_addr      : out    vl_logic_vector(11 downto 0);
        bank_addr       : out    vl_logic_vector(1 downto 0);
        cmd             : out    vl_logic_vector(3 downto 0);
        flag_init_end   : out    vl_logic
    );
end sdram_init;
