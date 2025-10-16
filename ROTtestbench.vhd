library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom4 is
port( 
max_occupancy : in unsigned(5 downto 0);
reset : in std_logic;
clk: in std_logic;
X : in std_logic;--people coming in
Y : in std_logic;--people coming out
Z : out std_logic--output limit reached
);
end rom4;

architecture arch_ROT4 of rom4 is
signal current_occupancy: unsigned (5 downto 0):=(others=>'0');
begin
	process(clk,reset)
	begin
			if(reset = '1') then
			current_occupancy <= (others=>'0');
			else
				if (X='1' and clk'event and clk ='1') then
					current_occupancy<= current_occupancy +1;
				elsif (Y='1' and clk'event and clk ='1') then
					current_occupancy<= current_occupancy -1;
				else
					null;
					--current_occupancy<= current _occupancy;
				end if;

				if(current_occupancy=max_occupancy and clk'event and clk ='1') then
					Z<='1';
				else
					Z<='0';
				end if;
			end if;

	end process;
	
end arch_ROT4;
---------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity rot_TB is
end entity;

architecture data of rot_TB is

signal max_occupancy1: unsigned(5 downto 0):="000011";--"111111"
signal X1, Y1, Z1, clk1, reset1: std_logic;

constant clock_period :time := 10 ns;
begin
--instantiating test unit
A: entity work.rom4 port map(x=>x1, y=>y1, reset=>reset1, clk=>clk1, z=>z1, max_occupancy=>max_occupancy1);	

--clock process
clock :process
begin
clk1<='0';
wait for clock_period/2;
clk1<='1';
wait for clock_period/2;
end process;

--testing
cases :process
begin
reset1<='0';
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='0';
Y1<='1';
wait for 10 ns;
assert ((z1='0'));
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
reset1<='1';
wait for 10 ns;
assert ((z1='0'));
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='0';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='0';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
X1<='1';
Y1<='0';
wait for 10 ns;
assert ((z1='0'));
reset1<='0';
wait for 10 ns;
assert ((z1='0'));
end process;

end data;
