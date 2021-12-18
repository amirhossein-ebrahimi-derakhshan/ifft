library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fft16 is
    Port ( Clk   : in STD_LOGIC;
			  in1   : in   signed(7 downto 0);
           in2   : in   signed(7 downto 0);
           in3   : in   signed(7 downto 0);
           in4   : in   signed(7 downto 0);
           out1  : out  signed(11 downto 0);
           out2  : out  signed(11 downto 0);
           out3  : out  signed(11 downto 0);
           out4  : out  signed(11 downto 0));

end fft16;

architecture Behavioral of fft16 is

type my_type  is array (0 to 4) of  signed(11 downto 0);

signal s_in1 : my_type :=(others =>(others => '0'));
signal s_in2 : my_type :=(others =>(others => '0'));
signal s_in3 : my_type :=(others =>(others => '0'));
signal s_in4 : my_type :=(others =>(others => '0'));

signal s_out1 : my_type :=(others =>(others => '0'));
signal s_out2 : my_type :=(others =>(others => '0'));
signal s_out3 : my_type :=(others =>(others => '0'));
signal s_out4 : my_type :=(others =>(others => '0'));


signal intersig2 : signed (19 downto 0) := (others => '0');


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
	port map(in1 => s_in1(n), in2 => s_in2(n), in3 => s_in3(n),  in4 => s_in4(n) ,Clk => Clk, out1 => s_out1(n),  out2 => s_out2(n),  out3 => s_out3(n), out4 => s_out4(n));
	END GENERATE G1;

process(Clk)
		begin
			if (rising_edge(Clk)) then
					
					out1  <= int_sig1 + int_sig5 + int_sig9 + int_sig13;
					
					out5(5 downto 0)  <= int_sig1(5 downto 0)  - int_sig5(11 downto 6) - int_sig9(5 downto 0)  + int_sig13(11 downto 6);
					out5(11 downto 6) <= int_sig1(11 downto 6) + int_sig5(5 downto 0)  - int_sig9(11 downto 6) - int_sig13(5 downto 0);
					
					out9  <= int_sig1 - int_sig5 + int_sig9 - int_sig13;
					
					out13(5 downto 0)  <= int_sig1(5 downto 0)  + int_sig5(11 downto 6) - int_sig9(5 downto 0)  - int_sig13(11 downto 6);
					out13(11 downto 6) <= int_sig1(11 downto 6) - int_sig5(5 downto 0)  - int_sig9(11 downto 6) + int_sig13(5 downto 0);
										
					intersig2(9 downto 0)   <= (int_sig2(5 downto 0)&"0000")  + "1110" * int_sig6(5 downto 0)  + "1011" * int_sig10(5 downto 0)  + "0110" * int_sig14(5 downto 0) - "0110" * int_sig6(11 downto 6)  - "1011" * int_sig10(11 downto 6)  - "1110" * int_sig14(11 downto 6);
					intersig2(19 downto 10) <= (int_sig2(11 downto 6)&"0000") + "1110" * int_sig6(11 downto 6) + "1011" * int_sig10(11 downto 6) + "0110" * int_sig14(11 downto 6)+ "0110" * int_sig6(5 downto 0)   + "1011" * int_sig10(5 downto 0)   + "1110" * int_sig14(5 downto 0);
					
					intersig6(9 downto 0)   <= (int_sig2(5 downto 0)&"0000")  - "0110" * int_sig6(5 downto 0)  - "1011" * int_sig10(5 downto 0)  + "1110" * int_sig14(5 downto 0) - "1110" * int_sig6(11 downto 6)  + "1011" * int_sig10(11 downto 6)  + "0110" * int_sig14(11 downto 6);
					intersig6(19 downto 10) <= (int_sig2(11 downto 6)&"0000") - "0110" * int_sig6(11 downto 6) - "1011" * int_sig10(11 downto 6) + "1110" * int_sig14(11 downto 6)+ "1110" * int_sig6(5 downto 0)   - "1011" * int_sig10(5 downto 0)   - "0110" * int_sig14(5 downto 0);
					
					intersig10(9 downto 0)   <= (int_sig2(5 downto 0)&"0000")  - "1110" * int_sig6(5 downto 0)  + "1011" * int_sig10(5 downto 0)  - "0110" * int_sig14(5 downto 0) + "0110" * int_sig6(11 downto 6)  - "1011" * int_sig10(11 downto 6)  + "1110" * int_sig14(11 downto 6);
					intersig10(19 downto 10) <= (int_sig2(11 downto 6)&"0000") - "1110" * int_sig6(11 downto 6) + "1011" * int_sig10(11 downto 6) - "0110" * int_sig14(11 downto 6)- "0110" * int_sig6(5 downto 0)   + "1011" * int_sig10(5 downto 0)   - "1110" * int_sig14(5 downto 0);
					
					intersig14(9 downto 0)   <= (int_sig2(5 downto 0)&"0000")  + "0110" * int_sig6(5 downto 0)  - "1011" * int_sig10(5 downto 0)  - "1110" * int_sig14(5 downto 0) + "1110" * int_sig6(11 downto 6)  + "1011" * int_sig10(11 downto 6)  - "0110" * int_sig14(11 downto 6);
					intersig14(19 downto 10) <= (int_sig2(11 downto 6)&"0000") + "0110" * int_sig6(11 downto 6) - "1011" * int_sig10(11 downto 6) - "1110" * int_sig14(11 downto 6)- "1110" * int_sig6(5 downto 0)   - "1011" * int_sig10(5 downto 0)   + "0110" * int_sig14(5 downto 0);
										
					intersig3(9 downto 0)    <= (int_sig3(5 downto 0)&"0000")  + "1011" * int_sig7(5 downto 0)  - "1011" * int_sig15(5 downto 0) - "1011" * int_sig7(11 downto 6)  - int_sig11(11 downto 6)  - "1011" * int_sig15(11 downto 6);
					intersig3(19 downto 10)  <= (int_sig3(11 downto 6)&"0000") + "1011" * int_sig7(11 downto 6) - "1011" * int_sig15(11 downto 6)+ "1011" * int_sig7(5 downto 0)   + int_sig11(5 downto 0)   + "1011" * int_sig15(5 downto 0);
					
					intersig7(9 downto 0)    <= (int_sig3(5 downto 0)&"0000")  - "1011" * int_sig7(5 downto 0)  + "1011" * int_sig15(5 downto 0) - "1011" * int_sig7(11 downto 6)  + int_sig11(11 downto 6)  - "1011" * int_sig15(11 downto 6);
					intersig7(19 downto 10)  <= (int_sig3(11 downto 6)&"0000") - "1011" * int_sig7(11 downto 6) + "1011" * int_sig15(11 downto 6)+ "1011" * int_sig7(5 downto 0)   - int_sig11(5 downto 0)   + "1011" * int_sig15(5 downto 0);

					intersig11(9 downto 0)   <= (int_sig3(5 downto 0)&"0000")  - "1011" * int_sig7(5 downto 0)  + "1011" * int_sig15(5 downto 0) + "1011" * int_sig7(11 downto 6)  - int_sig11(11 downto 6)  + "1011" * int_sig15(11 downto 6);
					intersig11(19 downto 10) <= (int_sig3(11 downto 6)&"0000") - "1011" * int_sig7(11 downto 6) + "1011" * int_sig15(11 downto 6)- "1011" * int_sig7(5 downto 0)   + int_sig11(5 downto 0)   - "1011" * int_sig15(5 downto 0);

					intersig15(9 downto 0)   <= (int_sig3(5 downto 0)&"0000")  + "1011" * int_sig7(5 downto 0)  - "1011" * int_sig15(5 downto 0) + "1011" * int_sig7(11 downto 6)  + int_sig11(11 downto 6)  + "1011" * int_sig15(11 downto 6);
					intersig15(19 downto 10) <= (int_sig3(11 downto 6)&"0000") + "1011" * int_sig7(11 downto 6) - "1011" * int_sig15(11 downto 6)- "1011" * int_sig7(5 downto 0)   - int_sig11(5 downto 0)   - "1011" * int_sig15(5 downto 0);
					

					intersig4(9 downto 0)   <= (int_sig4(5 downto 0)&"0000")  + "0110" * int_sig8(5 downto 0)  - "1011" * int_sig12(5 downto 0)  - "1110" * int_sig16(5 downto 0) - "1110" * int_sig8(11 downto 6)  - "1011" * int_sig12(11 downto 6)  + "0110" * int_sig16(11 downto 6);
					intersig4(19 downto 10) <= (int_sig4(11 downto 6)&"0000") + "0110" * int_sig8(11 downto 6) - "1011" * int_sig12(11 downto 6) - "1110" * int_sig16(11 downto 6)+ "1110" * int_sig8(5 downto 0)   + "1011" * int_sig12(5 downto 0)   - "0110" * int_sig16(5 downto 0);

					intersig8(9 downto 0)   <= (int_sig4(5 downto 0)&"0000")  - "1110" * int_sig8(5 downto 0)  + "1011" * int_sig12(5 downto 0)  - "0110" * int_sig16(5 downto 0) - "0110" * int_sig8(11 downto 6)  + "1011" * int_sig12(11 downto 6)  - "1110" * int_sig16(11 downto 6);
					intersig8(19 downto 10) <= (int_sig4(11 downto 6)&"0000") - "1110" * int_sig8(11 downto 6) + "1011" * int_sig12(11 downto 6) - "0110" * int_sig16(11 downto 6)+ "0110" * int_sig8(5 downto 0)   - "1011" * int_sig12(5 downto 0)   + "1110" * int_sig16(5 downto 0);

					intersig12(9 downto 0)   <= (int_sig4(5 downto 0)&"0000")  - "0110" * int_sig8(5 downto 0)  - "1011" * int_sig12(5 downto 0)  + "1110" * int_sig16(5 downto 0) + "1110" * int_sig8(11 downto 6)  - "1011" * int_sig12(11 downto 6)  - "0110" * int_sig16(11 downto 6);
					intersig12(19 downto 10) <= (int_sig4(11 downto 6)&"0000") - "0110" * int_sig8(11 downto 6) - "1011" * int_sig12(11 downto 6) + "1110" * int_sig16(11 downto 6)- "1110" * int_sig8(5 downto 0)   + "1011" * int_sig12(5 downto 0)   + "0110" * int_sig16(5 downto 0);

					intersig16(9 downto 0)   <= (int_sig4(5 downto 0)&"0000")  + "1110" * int_sig8(5 downto 0)  + "1011" * int_sig12(5 downto 0)  + "0110" * int_sig16(5 downto 0) + "0110" * int_sig8(11 downto 6)  + "1011" * int_sig12(11 downto 6)  + "1110" * int_sig16(11 downto 6);
					intersig16(19 downto 10) <= (int_sig4(11 downto 6)&"0000") + "1110" * int_sig8(11 downto 6) + "1011" * int_sig12(11 downto 6) + "0110" * int_sig16(11 downto 6)- "0110" * int_sig8(5 downto 0)   - "1011" * int_sig12(5 downto 0)   - "1110" * int_sig16(5 downto 0);

					
			end if;
end process;
end Behavioral;

