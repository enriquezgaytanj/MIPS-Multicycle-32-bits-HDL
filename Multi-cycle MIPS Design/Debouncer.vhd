----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:50:41 02/19/2012 
-- Design Name: 
-- Module Name:    Debouncer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- Debounce Pushbutton: Filters out mechanical switch bounce for around 40ms.

entity Debouncer is
	Port(	reset					:	in		STD_LOGIC;
			pushbutton			:	in		STD_LOGIC;			
			clock_100Hz		 	:	in		STD_LOGIC;
			signal_debounced	:	out	STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is

signal shift_pushbutton	: STD_LOGIC_VECTOR(3 downto 0);

begin
	
-- Debounce clock should be approximately 10ms or 100Hz

debouncer_process : process (reset, pushbutton, clock_100Hz, shift_pushbutton)
begin
if (reset = '1') then
	signal_debounced <= '0';
	shift_pushbutton <= "0000";
	
else

	if rising_edge(clock_100Hz) then

		-- Use a shift register to filter switch contact bounce
		shift_pushbutton(2 downto 0) <= shift_pushbutton(3 downto 1);
		shift_pushbutton(3) <= pushbutton;
  		
		if shift_pushbutton = "0000" then
			signal_debounced <= '0';
  		else
			signal_debounced <= '1';
  		end if;
		
	end if;

end if;

end process;
end Behavioral;

