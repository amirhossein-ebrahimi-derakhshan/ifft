library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fft16 is
    Port ( Clk   : in STD_LOGIC;
			  infft   : in   signed(7 downto 0);
			  outfft1   : out   signed(16 downto 0);
			  outfft2   : out   signed(16 downto 0);
			  outfft3   : out   signed(16 downto 0);
			  outfft4   : out   signed(16 downto 0);
			  outfft5   : out   signed(16 downto 0);
			  outfft6   : out   signed(16 downto 0);
			  outfft7   : out   signed(16 downto 0);
			  outfft8   : out   signed(16 downto 0);
			  outfft9   : out   signed(16 downto 0);
			  outfft10  : out   signed(16 downto 0);
			  outfft11  : out   signed(16 downto 0);
			  outfft12  : out   signed(16 downto 0);
			  outfft13  : out   signed(16 downto 0);
			  outfft14  : out   signed(16 downto 0);
			  outfft15  : out   signed(16 downto 0);
			  outfft16  : out   signed(16 downto 0));
end fft16;

architecture Behavioral of fft16 is

type my_type1  is array (0 to 15) of  signed(7 downto 0);
type my_type2  is array (0 to 3) of  signed(11 downto 0);


signal s_in : my_type1 :=(others =>(others => '0'));

signal s_out1 : my_type2 :=(others =>(others => '0'));
signal s_out2 : my_type2 :=(others =>(others => '0'));
signal s_out3 : my_type2 :=(others =>(others => '0'));
signal s_out4 : my_type2 :=(others =>(others => '0'));

signal intersig1  : signed (23 downto 0) := (others => '0');
signal intersig2  : signed (23 downto 0) := (others => '0');
signal intersig3  : signed (23 downto 0) := (others => '0');
signal intersig4  : signed (23 downto 0) := (others => '0');
signal intersig5  : signed (23 downto 0) := (others => '0');
signal intersig6  : signed (23 downto 0) := (others => '0');
signal intersig7  : signed (23 downto 0) := (others => '0');
signal intersig8  : signed (23 downto 0) := (others => '0');
signal intersig9  : signed (23 downto 0) := (others => '0');
signal intersig10 : signed (23 downto 0) := (others => '0');
signal intersig11 : signed (23 downto 0) := (others => '0');
signal intersig12 : signed (23 downto 0) := (others => '0');
signal intersig13 : signed (23 downto 0) := (others => '0');
signal intersig14 : signed (23 downto 0) := (others => '0');
signal intersig15 : signed (23 downto 0) := (others => '0');
signal intersig16 : signed (23 downto 0) := (others => '0');

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
					s_in(address) <= infft;
					counter4b <= counter4b+1;
					
					if (counter4b = "1111") then
						counter4b <= (others => '0');
						enable <= '1';
					else
						enable <= '0';
					end if;
				
			end if;
		
		
			if (rising_edge(Clk)) then
					if (enable = '1') then
					
					outfft1(7 downto 0)	  <= resize(s_out1(0)(5 downto 0),8)  + s_out1(1)(5 downto 0)  + s_out1(2)(5 downto 0)  + s_out1(3)(5 downto 0);
					outfft1(15 downto 8)	  <= resize(s_out1(0)(11 downto 6),8) + s_out1(1)(11 downto 6) + s_out1(2)(11 downto 6) + s_out1(3)(11 downto 6);
					
					outfft5(7 downto 0)	  <= resize(s_out1(0)(5 downto 0),8)  - s_out1(1)(11 downto 6) - s_out1(2)(5 downto 0)  + s_out1(3)(11 downto 6);
					outfft5(15 downto 8)   <= resize(s_out1(0)(11 downto 6),8) + s_out1(1)(5 downto 0)  - s_out1(2)(11 downto 6) - s_out1(3)(5 downto 0);
					
					outfft9(7 downto 0)	  <= resize(s_out1(0)(5 downto 0),8)  - s_out1(1)(5 downto 0)  + s_out1(2)(5 downto 0)  - s_out1(3)(5 downto 0);
					outfft9(15 downto 8)   <= resize(s_out1(0)(11 downto 6),8) - s_out1(1)(11 downto 6) + s_out1(2)(11 downto 6) - s_out1(3)(11 downto 6);
					
					outfft13(7 downto 0)   <= resize(s_out1(0)(5 downto 0),8)  + s_out1(1)(11 downto 6) - s_out1(2)(5 downto 0)  - s_out1(3)(11 downto 6);
					outfft13(15 downto 8)  <= resize(s_out1(0)(11 downto 6),8) - s_out1(1)(5 downto 0)  - s_out1(2)(11 downto 6) + s_out1(3)(5 downto 0);
										
					outfft2(7 downto 0)    <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  + "1110" * s_out2(1)(5 downto 0)  + "1011" * s_out2(2)(5 downto 0)  + "0110" * s_out2(3)(5 downto 0) - "0110" * s_out2(1)(11 downto 6)  - "1011" * s_out2(2)(11 downto 6)  - "1110" * s_out2(3)(11 downto 6),8);
					outfft2(15 downto 8)   <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) + "1110" * s_out2(1)(11 downto 6) + "1011" * s_out2(2)(11 downto 6) + "0110" * s_out2(3)(11 downto 6)+ "0110" * s_out2(1)(5 downto 0)   + "1011" * s_out2(2)(5 downto 0)   + "1110" * s_out2(3)(5 downto 0),8);
					
					outfft6(7 downto 0)    <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  - "0110" * s_out2(1)(5 downto 0)  - "1011" * s_out2(2)(5 downto 0)  + "1110" * s_out2(3)(5 downto 0) - "1110" * s_out2(1)(11 downto 6)  + "1011" * s_out2(2)(11 downto 6)  + "0110" * s_out2(3)(11 downto 6),8);
					outfft6(15 downto 8)   <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) - "0110" * s_out2(1)(11 downto 6) - "1011" * s_out2(2)(11 downto 6) + "1110" * s_out2(3)(11 downto 6)+ "1110" * s_out2(1)(5 downto 0)   - "1011" * s_out2(2)(5 downto 0)   - "0110" * s_out2(3)(5 downto 0),8);
					
					outfft10(7 downto 0)   <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  - "1110" * s_out2(1)(5 downto 0)  + "1011" * s_out2(2)(5 downto 0)  - "0110" * s_out2(3)(5 downto 0) + "0110" * s_out2(1)(11 downto 6)  - "1011" * s_out2(2)(11 downto 6)  + "1110" * s_out2(3)(11 downto 6),8);
					outfft10(15 downto 8)  <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) - "1110" * s_out2(1)(11 downto 6) + "1011" * s_out2(2)(11 downto 6) - "0110" * s_out2(3)(11 downto 6)- "0110" * s_out2(1)(5 downto 0)   + "1011" * s_out2(2)(5 downto 0)   - "1110" * s_out2(3)(5 downto 0),8);
					
					outfft14(7 downto 0)   <= resize(resize((s_out2(0)(5 downto 0)&"0000"),12)  + "0110" * s_out2(1)(5 downto 0)  - "1011" * s_out2(2)(5 downto 0)  - "1110" * s_out2(3)(5 downto 0) + "1110" * s_out2(1)(11 downto 6)  + "1011" * s_out2(2)(11 downto 6)  - "0110" * s_out2(3)(11 downto 6),8);
					outfft14(15 downto 8)  <= resize(resize((s_out2(0)(11 downto 6)&"0000"),12) + "0110" * s_out2(1)(11 downto 6) - "1011" * s_out2(2)(11 downto 6) - "1110" * s_out2(3)(11 downto 6)- "1110" * s_out2(1)(5 downto 0)   - "1011" * s_out2(2)(5 downto 0)   + "0110" * s_out2(3)(5 downto 0),8);
										
					outfft3(7 downto 0)    <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  + "1011" * s_out3(1)(5 downto 0)  - "1011" * s_out3(3)(5 downto 0) - "1011" * s_out3(1)(11 downto 6)  - s_out3(2)(11 downto 6)  - "1011" * s_out3(3)(11 downto 6),8);
					outfft3(15 downto 8)   <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) + "1011" * s_out3(1)(11 downto 6) - "1011" * s_out3(3)(11 downto 6)+ "1011" * s_out3(1)(5 downto 0)   + s_out3(2)(5 downto 0)   + "1011" * s_out3(3)(5 downto 0),8);
					
					outfft7(7 downto 0)    <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  - "1011" * s_out3(1)(5 downto 0)  + "1011" * s_out3(3)(5 downto 0) - "1011" * s_out3(1)(11 downto 6)  + s_out3(2)(11 downto 6)  - "1011" * s_out3(3)(11 downto 6),8);
					outfft7(15 downto 8)   <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) - "1011" * s_out3(1)(11 downto 6) + "1011" * s_out3(3)(11 downto 6)+ "1011" * s_out3(1)(5 downto 0)   - s_out3(2)(5 downto 0)   + "1011" * s_out3(3)(5 downto 0),8);

					outfft11(7 downto 0)   <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  - "1011" * s_out3(1)(5 downto 0)  + "1011" * s_out3(3)(5 downto 0) + "1011" * s_out3(1)(11 downto 6)  - s_out3(2)(11 downto 6)  + "1011" * s_out3(3)(11 downto 6),8);
					outfft11(15 downto 8)  <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) - "1011" * s_out3(1)(11 downto 6) + "1011" * s_out3(3)(11 downto 6)- "1011" * s_out3(1)(5 downto 0)   + s_out3(2)(5 downto 0)   - "1011" * s_out3(3)(5 downto 0),8);

					outfft15(7 downto 0)   <= resize(resize((s_out3(0)(5 downto 0)&"0000"),12)  + "1011" * s_out3(1)(5 downto 0)  - "1011" * s_out3(3)(5 downto 0) + "1011" * s_out3(1)(11 downto 6)  + s_out3(2)(11 downto 6)  + "1011" * s_out3(3)(11 downto 6),8);
					outfft15(15 downto 8)  <= resize(resize((s_out3(0)(11 downto 6)&"0000"),12) + "1011" * s_out3(1)(11 downto 6) - "1011" * s_out3(3)(11 downto 6)- "1011" * s_out3(1)(5 downto 0)   - s_out3(2)(5 downto 0)   - "1011" * s_out3(3)(5 downto 0),8);
					
					outfft4(7 downto 0)    <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  + "0110" * s_out4(1)(5 downto 0)  - "1011" * s_out4(2)(5 downto 0)  - "1110" * s_out4(3)(5 downto 0) - "1110" * s_out4(1)(11 downto 6)  - "1011" * s_out4(2)(11 downto 6)  + "0110" * s_out4(3)(11 downto 6),8);
					outfft4(15 downto 8)   <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) + "0110" * s_out4(1)(11 downto 6) - "1011" * s_out4(2)(11 downto 6) - "1110" * s_out4(3)(11 downto 6)+ "1110" * s_out4(1)(5 downto 0)   + "1011" * s_out4(2)(5 downto 0)   - "0110" * s_out4(3)(5 downto 0),8);

					outfft8(7 downto 0)    <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  - "1110" * s_out4(1)(5 downto 0)  + "1011" * s_out4(2)(5 downto 0)  - "0110" * s_out4(3)(5 downto 0) - "0110" * s_out4(1)(11 downto 6)  + "1011" * s_out4(2)(11 downto 6)  - "1110" * s_out4(3)(11 downto 6),8);
					outfft8(15 downto 8)   <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) - "1110" * s_out4(1)(11 downto 6) + "1011" * s_out4(2)(11 downto 6) - "0110" * s_out4(3)(11 downto 6)+ "0110" * s_out4(1)(5 downto 0)   - "1011" * s_out4(2)(5 downto 0)   + "1110" * s_out4(3)(5 downto 0),8);

					outfft12(7 downto 0)   <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  - "0110" * s_out4(1)(5 downto 0)  - "1011" * s_out4(2)(5 downto 0)  + "1110" * s_out4(3)(5 downto 0) + "1110" * s_out4(1)(11 downto 6)  - "1011" * s_out4(2)(11 downto 6)  - "0110" * s_out4(3)(11 downto 6),8);
					outfft12(15 downto 8)  <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) - "0110" * s_out4(1)(11 downto 6) - "1011" * s_out4(2)(11 downto 6) + "1110" * s_out4(3)(11 downto 6)- "1110" * s_out4(1)(5 downto 0)   + "1011" * s_out4(2)(5 downto 0)   + "0110" * s_out4(3)(5 downto 0),8);

					outfft16(7 downto 0)   <= resize(resize((s_out4(0)(5 downto 0)&"0000"),12)  + "1110" * s_out4(1)(5 downto 0)  + "1011" * s_out4(2)(5 downto 0)  + "0110" * s_out4(3)(5 downto 0) + "0110" * s_out4(1)(11 downto 6)  + "1011" * s_out4(2)(11 downto 6)  + "1110" * s_out4(3)(11 downto 6),8);
					outfft16(15 downto 8)  <= resize(resize((s_out4(0)(11 downto 6)&"0000"),12) + "1110" * s_out4(1)(11 downto 6) + "1011" * s_out4(2)(11 downto 6) + "0110" * s_out4(3)(11 downto 6)- "0110" * s_out4(1)(5 downto 0)   - "1011" * s_out4(2)(5 downto 0)   - "1110" * s_out4(3)(5 downto 0),8);

					end if;
			end if;
end process;
end Behavioral;

