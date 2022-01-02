library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fft16 is
    Port ( Clk      : in    STD_LOGIC;
			  infft    : in    signed(7 downto 0);
			  outfft   : out   signed(15 downto 0);
			  counter_num  : out   unsigned(3 downto 0));
			  
end fft16;

architecture Behavioral of fft16 is

type my_type1  is array (0 to 15) of  signed(7 downto 0);
type my_type2  is array (0 to 3) of  signed(11 downto 0);
type my_type3  is array (0 to 15) of  signed(15 downto 0);

signal s_in : my_type1 :=(others =>(others => '0'));

signal s_out : my_type3 :=(others =>(others => '0'));

signal s_out1 : my_type2 :=(others =>(others => '0'));
signal s_out2 : my_type2 :=(others =>(others => '0'));
signal s_out3 : my_type2 :=(others =>(others => '0'));
signal s_out4 : my_type2 :=(others =>(others => '0'));

signal counter4b : unsigned (3 downto 0) := (others => '0');

signal enable    : STD_LOGIC;

component fft4 is
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
	
	G1 : FOR n IN 3 DOWNTO 0 GENERATE
	U0: fft4 
	port map(in1 => s_in(n), in2 => s_in(n+4), in3 => s_in(n+8),  in4 => s_in(n+12) ,Clk => Clk, out1 => s_out1(n),  out2 => s_out2(n),  out3 => s_out3(n), out4 => s_out4(n));
	END GENERATE G1;

process(Clk)
variable address : integer;
		begin
			if (rising_edge(Clk)) then
					address    := to_integer(unsigned(counter4b));
					counter_num <= counter4b;
					s_in(address) <= infft;
					outfft <= s_out(address);
					counter4b <= counter4b+1;
					
					if (counter4b = "1111") then
						counter4b <= (others => '0');
						enable <= '1';
					else
						enable <= '0';
					end if;
				
					if (enable = '1') then
					
					s_out(0)(7 downto 0)	  <= resize(s_out1(0)(5 downto 0),8)  + s_out1(1)(5 downto 0)  + s_out1(2)(5 downto 0)  + s_out1(3)(5 downto 0);
					s_out(0)(15 downto 8)	  <= resize(s_out1(0)(11 downto 6),8) + s_out1(1)(11 downto 6) + s_out1(2)(11 downto 6) + s_out1(3)(11 downto 6);
					
					s_out(4)(7 downto 0)	  <= resize(s_out1(0)(5 downto 0),8)  - s_out1(1)(11 downto 6) - s_out1(2)(5 downto 0)  + s_out1(3)(11 downto 6);
					s_out(4)(15 downto 8)   <= resize(s_out1(0)(11 downto 6),8) + s_out1(1)(5 downto 0)  - s_out1(2)(11 downto 6) - s_out1(3)(5 downto 0);
					
					s_out(8)(7 downto 0)	  <= resize(s_out1(0)(5 downto 0),8)  - s_out1(1)(5 downto 0)  + s_out1(2)(5 downto 0)  - s_out1(3)(5 downto 0);
					s_out(8)(15 downto 8)   <= resize(s_out1(0)(11 downto 6),8) - s_out1(1)(11 downto 6) + s_out1(2)(11 downto 6) - s_out1(3)(11 downto 6);
					
					s_out(12)(7 downto 0)   <= resize(s_out1(0)(5 downto 0),8)  + s_out1(1)(11 downto 6) - s_out1(2)(5 downto 0)  - s_out1(3)(11 downto 6);
					s_out(12)(15 downto 8)  <= resize(s_out1(0)(11 downto 6),8) - s_out1(1)(5 downto 0)  - s_out1(2)(11 downto 6) + s_out1(3)(5 downto 0);
										
					s_out(1)(7 downto 0)    <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  + "1110" * s_out2(1)(5 downto 0)  + "1011" * s_out2(2)(5 downto 0)  + "0110" * s_out2(3)(5 downto 0) - "0110" * s_out2(1)(11 downto 6)  - "1011" * s_out2(2)(11 downto 6)  - "1110" * s_out2(3)(11 downto 6),8);
					s_out(1)(15 downto 8)   <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) + "1110" * s_out2(1)(11 downto 6) + "1011" * s_out2(2)(11 downto 6) + "0110" * s_out2(3)(11 downto 6)+ "0110" * s_out2(1)(5 downto 0)   + "1011" * s_out2(2)(5 downto 0)   + "1110" * s_out2(3)(5 downto 0),8);
					
					s_out(5)(7 downto 0)    <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  - "0110" * s_out2(1)(5 downto 0)  - "1011" * s_out2(2)(5 downto 0)  + "1110" * s_out2(3)(5 downto 0) - "1110" * s_out2(1)(11 downto 6)  + "1011" * s_out2(2)(11 downto 6)  + "0110" * s_out2(3)(11 downto 6),8);
					s_out(5)(15 downto 8)   <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) - "0110" * s_out2(1)(11 downto 6) - "1011" * s_out2(2)(11 downto 6) + "1110" * s_out2(3)(11 downto 6)+ "1110" * s_out2(1)(5 downto 0)   - "1011" * s_out2(2)(5 downto 0)   - "0110" * s_out2(3)(5 downto 0),8);
					
					s_out(9)(7 downto 0)   <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  - "1110" * s_out2(1)(5 downto 0)  + "1011" * s_out2(2)(5 downto 0)  - "0110" * s_out2(3)(5 downto 0) + "0110" * s_out2(1)(11 downto 6)  - "1011" * s_out2(2)(11 downto 6)  + "1110" * s_out2(3)(11 downto 6),8);
					s_out(9)(15 downto 8)  <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) - "1110" * s_out2(1)(11 downto 6) + "1011" * s_out2(2)(11 downto 6) - "0110" * s_out2(3)(11 downto 6)- "0110" * s_out2(1)(5 downto 0)   + "1011" * s_out2(2)(5 downto 0)   - "1110" * s_out2(3)(5 downto 0),8);
					
					s_out(13)(7 downto 0)   <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  + "0110" * s_out2(1)(5 downto 0)  - "1011" * s_out2(2)(5 downto 0)  - "1110" * s_out2(3)(5 downto 0) + "1110" * s_out2(1)(11 downto 6)  + "1011" * s_out2(2)(11 downto 6)  - "0110" * s_out2(3)(11 downto 6),8);
					s_out(13)(15 downto 8)  <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) + "0110" * s_out2(1)(11 downto 6) - "1011" * s_out2(2)(11 downto 6) - "1110" * s_out2(3)(11 downto 6)- "1110" * s_out2(1)(5 downto 0)   - "1011" * s_out2(2)(5 downto 0)   + "0110" * s_out2(3)(5 downto 0),8);
										
					s_out(2)(7 downto 0)    <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  + "1011" * s_out3(1)(5 downto 0)  - "1011" * s_out3(3)(5 downto 0) - "1011" * s_out3(1)(11 downto 6)  - s_out3(2)(11 downto 6)  - "1011" * s_out3(3)(11 downto 6),8);
					s_out(2)(15 downto 8)   <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) + "1011" * s_out3(1)(11 downto 6) - "1011" * s_out3(3)(11 downto 6)+ "1011" * s_out3(1)(5 downto 0)   + s_out3(2)(5 downto 0)   + "1011" * s_out3(3)(5 downto 0),8);
					
					s_out(6)(7 downto 0)    <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  - "1011" * s_out3(1)(5 downto 0)  + "1011" * s_out3(3)(5 downto 0) - "1011" * s_out3(1)(11 downto 6)  + s_out3(2)(11 downto 6)  - "1011" * s_out3(3)(11 downto 6),8);
					s_out(6)(15 downto 8)   <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) - "1011" * s_out3(1)(11 downto 6) + "1011" * s_out3(3)(11 downto 6)+ "1011" * s_out3(1)(5 downto 0)   - s_out3(2)(5 downto 0)   + "1011" * s_out3(3)(5 downto 0),8);

					s_out(10)(7 downto 0)   <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  - "1011" * s_out3(1)(5 downto 0)  + "1011" * s_out3(3)(5 downto 0) + "1011" * s_out3(1)(11 downto 6)  - s_out3(2)(11 downto 6)  + "1011" * s_out3(3)(11 downto 6),8);
					s_out(10)(15 downto 8)  <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) - "1011" * s_out3(1)(11 downto 6) + "1011" * s_out3(3)(11 downto 6)- "1011" * s_out3(1)(5 downto 0)   + s_out3(2)(5 downto 0)   - "1011" * s_out3(3)(5 downto 0),8);

					s_out(14)(7 downto 0)   <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  + "1011" * s_out3(1)(5 downto 0)  - "1011" * s_out3(3)(5 downto 0) + "1011" * s_out3(1)(11 downto 6)  + s_out3(2)(11 downto 6)  + "1011" * s_out3(3)(11 downto 6),8);
					s_out(14)(15 downto 8)  <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) + "1011" * s_out3(1)(11 downto 6) - "1011" * s_out3(3)(11 downto 6)- "1011" * s_out3(1)(5 downto 0)   - s_out3(2)(5 downto 0)   - "1011" * s_out3(3)(5 downto 0),8);
					
					s_out(3)(7 downto 0)    <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  + "0110" * s_out4(1)(5 downto 0)  - "1011" * s_out4(2)(5 downto 0)  - "1110" * s_out4(3)(5 downto 0) - "1110" * s_out4(1)(11 downto 6)  - "1011" * s_out4(2)(11 downto 6)  + "0110" * s_out4(3)(11 downto 6),8);
					s_out(3)(15 downto 8)   <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) + "0110" * s_out4(1)(11 downto 6) - "1011" * s_out4(2)(11 downto 6) - "1110" * s_out4(3)(11 downto 6)+ "1110" * s_out4(1)(5 downto 0)   + "1011" * s_out4(2)(5 downto 0)   - "0110" * s_out4(3)(5 downto 0),8);

					s_out(7)(7 downto 0)    <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  - "1110" * s_out4(1)(5 downto 0)  + "1011" * s_out4(2)(5 downto 0)  - "0110" * s_out4(3)(5 downto 0) - "0110" * s_out4(1)(11 downto 6)  + "1011" * s_out4(2)(11 downto 6)  - "1110" * s_out4(3)(11 downto 6),8);
					s_out(7)(15 downto 8)   <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) - "1110" * s_out4(1)(11 downto 6) + "1011" * s_out4(2)(11 downto 6) - "0110" * s_out4(3)(11 downto 6)+ "0110" * s_out4(1)(5 downto 0)   - "1011" * s_out4(2)(5 downto 0)   + "1110" * s_out4(3)(5 downto 0),8);

					s_out(11)(7 downto 0)   <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  - "0110" * s_out4(1)(5 downto 0)  - "1011" * s_out4(2)(5 downto 0)  + "1110" * s_out4(3)(5 downto 0) + "1110" * s_out4(1)(11 downto 6)  - "1011" * s_out4(2)(11 downto 6)  - "0110" * s_out4(3)(11 downto 6),8);
					s_out(11)(15 downto 8)  <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) - "0110" * s_out4(1)(11 downto 6) - "1011" * s_out4(2)(11 downto 6) + "1110" * s_out4(3)(11 downto 6)- "1110" * s_out4(1)(5 downto 0)   + "1011" * s_out4(2)(5 downto 0)   + "0110" * s_out4(3)(5 downto 0),8);

					s_out(15)(7 downto 0)   <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  + "1110" * s_out4(1)(5 downto 0)  + "1011" * s_out4(2)(5 downto 0)  + "0110" * s_out4(3)(5 downto 0) + "0110" * s_out4(1)(11 downto 6)  + "1011" * s_out4(2)(11 downto 6)  + "1110" * s_out4(3)(11 downto 6),8);
					s_out(15)(15 downto 8)  <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) + "1110" * s_out4(1)(11 downto 6) + "1011" * s_out4(2)(11 downto 6) + "0110" * s_out4(3)(11 downto 6)- "0110" * s_out4(1)(5 downto 0)   - "1011" * s_out4(2)(5 downto 0)   - "1110" * s_out4(3)(5 downto 0),8);

					end if;
			end if;
end process;
end Behavioral;

