library verilog;
use verilog.vl_types.all;
entity adc_ctrl is
    generic(
        DIV_END         : integer := 124;
        DA_END          : integer := 7;
        STA_END         : integer := 99;
        CON_END         : integer := 849;
        IDLE            : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi0, Hi1);
        STA             : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi0);
        READ            : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi0, Hi0);
        STO             : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi0);
        CON             : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        s_clk           : in     vl_logic;
        s_rst_n         : in     vl_logic;
        adc_en          : in     vl_logic;
        adc_out         : in     vl_logic;
        adc_clk         : out    vl_logic;
        adc_cs_n        : out    vl_logic;
        dout            : out    vl_logic_vector(7 downto 0);
        con_ok          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DIV_END : constant is 1;
    attribute mti_svvh_generic_type of DA_END : constant is 1;
    attribute mti_svvh_generic_type of STA_END : constant is 1;
    attribute mti_svvh_generic_type of CON_END : constant is 1;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of STA : constant is 1;
    attribute mti_svvh_generic_type of READ : constant is 1;
    attribute mti_svvh_generic_type of STO : constant is 1;
    attribute mti_svvh_generic_type of CON : constant is 1;
end adc_ctrl;
