library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity fft4_1 is
    Port ( Clk   : in STD_LOGIC;
			  in1   : in   signed(7 downto 0);
           in2   : in   signed(7 downto 0);
           in3   : in   signed(7 downto 0);
           in4   : in   signed(7 downto 0);
           out1  : out  signed(11 downto 0);
           out2  : out  signed(11 downto 0);
           out3  : out  signed(11 downto 0);
           out4  : out  signed(11 downto 0));
end fft4_1;

architecture Behavioral of fft4_1 is

signal int_sig1_r  : signed (5 downto 0) := (others => '0');
signal int_sig1_i  : signed (5 downto 0) := (others => '0');
signal int_sig2_r  : signed (5 downto 0) := (others => '0');
signal int_sig2_i  : signed (5 downto 0) := (others => '0');
signal int_sig3_r  : signed (5 downto 0) := (others => '0');
signal int_sig3_i  : signed (5 downto 0) := (others => '0');
signal int_sig4_r  : signed (5 downto 0) := (others => '0');
signal int_sig4_i  : signed (5 downto 0) := (others => '0');

begin

		process(clk)
		begin
				if(rising_edge(clk))then
						int_sig1_i  <= resize(in1(3 downto 0),6) + signed(in3(3 downto 0));
						int_sig1_r  <= resize(in1(7 downto 4),6) + signed(in3(7 downto 4));
						int_sig2_i  <= resize(in1(3 downto 0),6) - signed(in3(3 downto 0));
						int_sig2_r  <= resize(in1(7 downto 4),6) - signed(in3(7 downto 4));
						int_sig3_i  <= resize(in2(3 downto 0),6) + signed(in4(3 downto 0));
						int_sig3_r  <= resize(in2(7 downto 4),6) + signed(in4(7 downto 4));
						int_sig4_i  <= resize(in2(3 downto 0),6) - signed(in4(3 downto 0));
						int_sig4_r  <= resize(in2(7 downto 4),6) - signed(in4(7 downto 4));
						
						
						
						out1(5 downto 0) <= int_sig1_i + int_sig3_i;
						out1(11 downto 6) <= int_sig1_r + int_sig3_r;
						
						out3(5 downto 0) <= int_sig1_i - int_sig3_i;
						out3(11 downto 6) <= int_sig1_r - int_sig3_r;
						
						out2(5 downto 0) <= int_sig2_i - int_sig4_r;
						out2(11 downto 6) <= int_sig2_r + int_sig4_i;
						
						out4(5 downto 0) <= int_sig2_i + int_sig4_r;						
						out4(11 downto 6) <= int_sig2_r - int_sig4_i;

				end if;
		end process;				
end Behavioral;

