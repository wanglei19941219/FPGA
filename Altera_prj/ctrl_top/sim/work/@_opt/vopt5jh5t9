library verilog;
use verilog.vl_types.all;
entity sdram_rd is
    generic(
        RD_IDLE         : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi0, Hi1);
        RD_REQ          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi0);
        RD_ACT          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi0, Hi0);
        READ            : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi0);
        RD_PRE          : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi0);
        ACT             : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        NOP             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        PRECHAR         : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        RD              : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1)
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        rd_tring        : in     vl_logic;
        req_aref        : in     vl_logic;
        en_rd           : in     vl_logic;
        sdram_data      : in     vl_logic_vector(15 downto 0);
        req_rd          : out    vl_logic;
        rd_end          : out    vl_logic;
        rd_cmd          : out    vl_logic_vector(3 downto 0);
        rd_addr         : out    vl_logic_vector(11 downto 0);
        rd_bank         : out    vl_logic_vector(1 downto 0);
        rfifo_wr_data   : out    vl_logic_vector(7 downto 0);
        rfifo_wr_en     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RD_IDLE : constant is 1;
    attribute mti_svvh_generic_type of RD_REQ : constant is 1;
    attribute mti_svvh_generic_type of RD_ACT : constant is 1;
    attribute mti_svvh_generic_type of READ : constant is 1;
    attribute mti_svvh_generic_type of RD_PRE : constant is 1;
    attribute mti_svvh_generic_type of ACT : constant is 1;
    attribute mti_svvh_generic_type of NOP : constant is 1;
    attribute mti_svvh_generic_type of PRECHAR : constant is 1;
    attribute mti_svvh_generic_type of RD : constant is 1;
end sdram_rd;
