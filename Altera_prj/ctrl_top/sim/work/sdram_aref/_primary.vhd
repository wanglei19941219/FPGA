library verilog;
use verilog.vl_types.all;
entity sdram_aref is
    generic(
        PRECHAR         : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        NOP             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        AREF            : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        TIME_15US       : integer := 749
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        en_aref         : in     vl_logic;
        flag_init_end   : in     vl_logic;
        req_aref        : out    vl_logic;
        end_aref        : out    vl_logic;
        aref_cmd        : out    vl_logic_vector(3 downto 0);
        sdram_addr      : out    vl_logic_vector(11 downto 0);
        sdram_bank      : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PRECHAR : constant is 1;
    attribute mti_svvh_generic_type of NOP : constant is 1;
    attribute mti_svvh_generic_type of AREF : constant is 1;
    attribute mti_svvh_generic_type of TIME_15US : constant is 1;
end sdram_aref;
