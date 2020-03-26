library verilog;
use verilog.vl_types.all;
entity sdram_decode is
    generic(
        CNT_DATA_END    : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0)
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        flag_uart       : in     vl_logic;
        uart_data       : in     vl_logic_vector(7 downto 0);
        wfifo_wr_en     : out    vl_logic;
        rd_tring        : out    vl_logic;
        wr_tring        : out    vl_logic;
        wfifo_wr_data   : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CNT_DATA_END : constant is 1;
end sdram_decode;
