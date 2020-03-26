library verilog;
use verilog.vl_types.all;
entity sdram_top is
    generic(
        IDLE            : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi0, Hi1);
        ARB             : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi0);
        AREF            : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi0, Hi0);
        WR              : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi0);
        RD              : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi0);
        NOP             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1)
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        sdram_clk       : out    vl_logic;
        sdram_cke       : out    vl_logic;
        sdram_cs_n      : out    vl_logic;
        sdram_addr      : out    vl_logic_vector(11 downto 0);
        sdram_baddr     : out    vl_logic_vector(1 downto 0);
        sdram_ras_n     : out    vl_logic;
        sdram_cas_n     : out    vl_logic;
        sdram_we_n      : out    vl_logic;
        sdram_dqm       : out    vl_logic_vector(1 downto 0);
        sdram_data      : inout  vl_logic_vector(15 downto 0);
        wr_tring        : in     vl_logic;
        rd_tring        : in     vl_logic;
        wfifo_rd_data   : in     vl_logic_vector(7 downto 0);
        wfifo_rd_en     : out    vl_logic;
        rfifo_wr_data   : out    vl_logic_vector(7 downto 0);
        rfifo_wr_en     : out    vl_logic;
        wfifo_empty     : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of ARB : constant is 1;
    attribute mti_svvh_generic_type of AREF : constant is 1;
    attribute mti_svvh_generic_type of WR : constant is 1;
    attribute mti_svvh_generic_type of RD : constant is 1;
    attribute mti_svvh_generic_type of NOP : constant is 1;
end sdram_top;
