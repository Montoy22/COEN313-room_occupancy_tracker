    library IEEE;
use IEEE.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity rot5 is
port( 
max_occupancy : in unsigned(5 downto 0) ;
reset : in std_logic;
clk: in std_logic;
X : in std_logic;--people coming in
Y : in std_logic;--people coming out
Z : out std_logic--output limit reached

);
end rot5;

architecture arch_ROT5 of rot5 is
signal current_occupancy: unsigned (5 downto 0):=(others=>'0');
begin
	process(clk,reset)--X, Y, max_occupancy,reset, 
	begin
			if(reset = '1') then
			current_occupancy <= (others=>'0');
			else
				if (X='1' and clk'event and clk ='1') then
					current_occupancy<= current_occupancy +1;
					end if;
				if (Y='1' and clk'event and clk ='1') then
					current_occupancy<= current_occupancy -1;
				    end if;
				if(clk'event and clk ='1') then
					Z<='0';
					end if;
				if(current_occupancy=max_occupancy and clk'event and clk ='1') then
					Z<='1';
				end if;
			end if;

	end process;
	
end arch_ROT5;

    
