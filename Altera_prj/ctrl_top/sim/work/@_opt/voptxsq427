library verilog;
use verilog.vl_types.all;
entity sdram_write is
    generic(
        WR_IDLE         : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi0, Hi1);
        WR_REQ          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi0);
        WR_ACT          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi0, Hi0);
        WRITE           : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi0);
        WR_PRE          : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi0);
        ACT             : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        NOP             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        PRECHAR         : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        WR              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0)
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        en_wr           : in     vl_logic;
        req_wr          : out    vl_logic;
        wr_end          : out    vl_logic;
        req_aref        : in     vl_logic;
        wr_tring        : in     vl_logic;
        wr_cmd          : out    vl_logic_vector(3 downto 0);
        wr_addr         : out    vl_logic_vector(11 downto 0);
        wr_bank         : out    vl_logic_vector(1 downto 0);
        wr_data         : out    vl_logic_vector(15 downto 0);
        wfifo_rd_data   : in     vl_logic_vector(7 downto 0);
        wfifo_rd_en     : out    vl_logic;
        wfifo_empty     : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WR_IDLE : constant is 1;
    attribute mti_svvh_generic_type of WR_REQ : constant is 1;
    attribute mti_svvh_generic_type of WR_ACT : constant is 1;
    attribute mti_svvh_generic_type of WRITE : constant is 1;
    attribute mti_svvh_generic_type of WR_PRE : constant is 1;
    attribute mti_svvh_generic_type of ACT : constant is 1;
    attribute mti_svvh_generic_type of NOP : constant is 1;
    attribute mti_svvh_generic_type of PRECHAR : constant is 1;
    attribute mti_svvh_generic_type of WR : constant is 1;
end sdram_write;
