library verilog;
use verilog.vl_types.all;
entity uart_tx is
    generic(
        BAND_TIME       : integer := 5207
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        rfifo_rd_data   : in     vl_logic_vector(7 downto 0);
        rfifo_empty     : in     vl_logic;
        data_tx         : out    vl_logic;
        rfifo_rd_en     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BAND_TIME : constant is 1;
end uart_tx;
