--asinhroni rom2x4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;

entity rom2x4 is
	port (adresa : in std_logic_vector(1 downto 0); izlaz : out std_logic_vector(3 downto 0));
end entity;

architecture rom2x4_a of rom2x4 is

	type rom_type is array (0 to 3) of std_logic_vector(3 downto 0);
	constant rom : rom_type := (0 => "1110",
					1 => "0010",
					2 => "1111",
					3 => "0100");
begin
	izlaz <= rom(to_integer(unsigned(adresa)));
end architecture;

entity rom2x4_tb is
end entity;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

architecture rom2x4_tb_a of rom2x4_tb is

	component rom2x4 is
		port (adresa : in std_logic_vector(1 downto 0); izlaz : out std_logic_vector(3 downto 0));
	end component;
	
	signal adresa_tb : std_logic_vector(1 downto 0);
	signal izlaz_tb : std_logic_vector(3 downto 0);
begin
	dut1 : rom2x4 port map (adresa => adresa_tb, izlaz => izlaz_tb);
	
	STIMULUS : process
	begin
		for i in 0 to 3 loop
			adresa_tb <= std_logic_vector(to_unsigned(i,2));
			report "adresa=" & to_string(adresa_tb) & "izlaz=" & to_string(izlaz_tb);
		end loop;
	end process;
end architecture;



