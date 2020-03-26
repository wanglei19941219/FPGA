library verilog;
use verilog.vl_types.all;
entity iic_ctrl is
    generic(
        H_CYC           : vl_logic_vector(0 to 6) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0);
        IDLE            : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        START           : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        WRITE           : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        READ            : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        CHK_ACK         : vl_logic_vector(0 to 6) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        GEN_STOP        : vl_logic_vector(0 to 6) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        GEN_ACK_NCK     : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        write_en        : in     vl_logic;
        read_en         : in     vl_logic;
        i_clk           : out    vl_logic;
        led             : out    vl_logic_vector(7 downto 0);
        sda             : inout  vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of H_CYC : constant is 1;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of START : constant is 1;
    attribute mti_svvh_generic_type of WRITE : constant is 1;
    attribute mti_svvh_generic_type of READ : constant is 1;
    attribute mti_svvh_generic_type of CHK_ACK : constant is 1;
    attribute mti_svvh_generic_type of GEN_STOP : constant is 1;
    attribute mti_svvh_generic_type of GEN_ACK_NCK : constant is 1;
end iic_ctrl;
