library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fft16 is
    Port ( Clk   : in STD_LOGIC;
			  in1   : in   signed(7 downto 0);
           in2   : in   signed(7 downto 0);
           in3   : in   signed(7 downto 0);
           in4   : in   signed(7 downto 0);
			  in5   : in   signed(7 downto 0);
           in6   : in   signed(7 downto 0);
           in7   : in   signed(7 downto 0);
           in8   : in   signed(7 downto 0);
			  in9   : in   signed(7 downto 0);
           in10  : in   signed(7 downto 0);
           in11  : in   signed(7 downto 0);
           in12  : in   signed(7 downto 0);
			  in13  : in   signed(7 downto 0);
           in14  : in   signed(7 downto 0);
           in15  : in   signed(7 downto 0);
           in16  : in   signed(7 downto 0);
           out1  : out  signed(11 downto 0);
           out2  : out  signed(11 downto 0);
           out3  : out  signed(11 downto 0);
           out4  : out  signed(11 downto 0);
			  out5  : out  signed(11 downto 0);
           out6  : out  signed(11 downto 0);
           out7  : out  signed(11 downto 0);
           out8  : out  signed(11 downto 0);
			  out9  : out  signed(11 downto 0);
           out10 : out  signed(11 downto 0);
           out11 : out  signed(11 downto 0);
           out12 : out  signed(11 downto 0);
			  out13 : out  signed(11 downto 0);
           out14 : out  signed(11 downto 0);
           out15 : out  signed(11 downto 0);
           out16 : out  signed(11 downto 0));
end fft16;

architecture Behavioral of fft16 is

signal int_sig1  : signed (11 downto 0) := (others => '0');
signal int_sig2  : signed (11 downto 0) := (others => '0');
signal int_sig3  : signed (11 downto 0) := (others => '0');
signal int_sig4  : signed (11 downto 0) := (others => '0');
signal int_sig5  : signed (11 downto 0) := (others => '0');
signal int_sig6  : signed (11 downto 0) := (others => '0');
signal int_sig7  : signed (11 downto 0) := (others => '0');
signal int_sig8  : signed (11 downto 0) := (others => '0');
signal int_sig9  : signed (11 downto 0) := (others => '0');
signal int_sig10 : signed (11 downto 0) := (others => '0');
signal int_sig11 : signed (11 downto 0) := (others => '0');
signal int_sig12 : signed (11 downto 0) := (others => '0');
signal int_sig13 : signed (11 downto 0) := (others => '0');
signal int_sig14 : signed (11 downto 0) := (others => '0');
signal int_sig15 : signed (11 downto 0) := (others => '0');
signal int_sig16 : signed (11 downto 0) := (others => '0');

component fft4_1 is
    Port ( Clk   : in STD_LOGIC;
			  in1   : in   signed(7 downto 0);
           in2   : in   signed(7 downto 0);
           in3   : in   signed(7 downto 0);
           in4   : in   signed(7 downto 0);
           out1  : out  signed(11 downto 0);
           out2  : out  signed(11 downto 0);
           out3  : out  signed(11 downto 0);
           out4  : out  signed(11 downto 0));
end component;

component fft4_2 is
    Port ( Clk   : in STD_LOGIC;
			  in1   : in   signed(7 downto 0);
           in2   : in   signed(7 downto 0);
           in3   : in   signed(7 downto 0);
           in4   : in   signed(7 downto 0);
           out1  : out  signed(11 downto 0);
           out2  : out  signed(11 downto 0);
           out3  : out  signed(11 downto 0);
           out4  : out  signed(11 downto 0));
end component;

component fft4_3 is
    Port ( Clk   : in STD_LOGIC;
			  in1   : in   signed(7 downto 0);
           in2   : in   signed(7 downto 0);
           in3   : in   signed(7 downto 0);
           in4   : in   signed(7 downto 0);
           out1  : out  signed(11 downto 0);
           out2  : out  signed(11 downto 0);
           out3  : out  signed(11 downto 0);
           out4  : out  signed(11 downto 0));
end component;

component fft4_4 is
    Port ( Clk   : in STD_LOGIC;
			  in1   : in   signed(7 downto 0);
           in2   : in   signed(7 downto 0);
           in3   : in   signed(7 downto 0);
           in4   : in   signed(7 downto 0);
           out1  : out  signed(11 downto 0);
           out2  : out  signed(11 downto 0);
           out3  : out  signed(11 downto 0);
           out4  : out  signed(11 downto 0));
end component;

begin
	m_1: fft4_1 port map(in1 => in1, in2 => in5, in3 => in9, in4 => in13 ,Clk => Clk, out1 => int_sig1,  out2 => int_sig2,  out3 => int_sig3, out4 => int_sig4);
	m_2: fft4_2 port map(in1 => in1, in2 => in5, in3 => in9, in4 => in13 ,Clk => Clk, out1 => int_sig5,  out2 => int_sig6,  out3 => int_sig7, out4 => int_sig8);
	m_3: fft4_3 port map(in1 => in1, in2 => in5, in3 => in9, in4 => in13 ,Clk => Clk, out1 => int_sig9,  out2 => int_sig10, out3 => int_sig11, out4 => int_sig12);
	m_4: fft4_4 port map(in1 => in1, in2 => in5, in3 => in9, in4 => in13 ,Clk => Clk, out1 => int_sig13, out2 => int_sig14, out3 => int_sig15, out4 => int_sig16);

process(Clk)
		begin
			if (rising_edge(Clk)) then
					
					
					
			end if;
end process;
end Behavioral;

