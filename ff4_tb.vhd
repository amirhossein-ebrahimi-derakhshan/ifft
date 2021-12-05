LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
 
ENTITY ff4_tb IS
END ff4_tb;
 
ARCHITECTURE behavior OF ff4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fft4
    PORT(
         Clk : IN  std_logic;
         in1 : IN  signed(7 downto 0);
         in2 : IN  signed(7 downto 0);
         in3 : IN  signed(7 downto 0);
         in4 : IN  signed(7 downto 0);
         out1 : OUT  signed(11 downto 0);
         out2 : OUT  signed(11 downto 0);
         out3 : OUT  signed(11 downto 0);
         out4 : OUT  signed(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal in1 : signed(7 downto 0) := (others => '0');
   signal in2 : signed(7 downto 0) := (others => '0');
   signal in3 : signed(7 downto 0) := (others => '0');
   signal in4 : signed(7 downto 0) := (others => '0');

 	--Outputs
   signal out1 : signed(11 downto 0);
   signal out2 : signed(11 downto 0);
   signal out3 : signed(11 downto 0);
   signal out4 : signed(11 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fft4 PORT MAP (
          Clk => Clk,
          in1 => in1,
          in2 => in2,
          in3 => in3,
          in4 => in4,
          out1 => out1,
          out2 => out2,
          out3 => out3,
          out4 => out4
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 
		in1 <= "11110001";
		in2 <= "11110001";
		in3 <= "11110001";
		in4 <= "11110001";
		wait for 100 ns;

		in1 <= "11111001";
		in2 <= "11111011";
		in3 <= "11111101";
		in4 <= "11111111";
		wait for 100 ns;
		
		in1 <= "00010001";
		in2 <= "00010011";
		in3 <= "00010101";
		in4 <= "00010111";
		wait for 100 ns;		
		
		in1 <= "01110111";
		in2 <= "01110111";
		in3 <= "01110111";
		in4 <= "01110111";
		wait for 100 ns;

		in1 <= "10001000";
		in2 <= "10001000";
		in3 <= "10001000";
		in4 <= "10001000";
		wait for 100 ns;			
   end process;

END;
