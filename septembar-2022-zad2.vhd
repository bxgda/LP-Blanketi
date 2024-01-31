--asinhroni citaj upisi 4x4

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

entity citajPisi is
	port(adresa : in std_logic_vector(1 downto 0);
		ulaz : in std_logic_vector(3 downto 0);
		izlaz : out std_logic_vector(3 downto 0);
		WE : in std_logic);
end entity;

architecture citajPisi_a of citajPisi is
	
	type RW_type is array (0 to 3) of std_logic_vector(3 downto 0);
	signal RW : RW_type;
begin
	memorija : process (adresa, WE, ulaz)
	begin
		if(WE = '1') then
			RW(to_integer(unsigned(adresa))) <= ulaz;
		else
			izlaz <= RW(to_integer(unsigned(adresa)));
		end if;
	end process;
end architecture;

entity citajPisi_tb is
end entity;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

architecture citajPisi_pb_a of citajPisi_tb is
	component citajPisi is
	port(adresa : in std_logic_vector(1 downto 0);
		ulaz : in std_logic_vector(3 downto 0);
		izlaz : out std_logic_vector(3 downto 0);
		WE : in std_logic);
	end component;
	signal adresa_tb : std_logic_vector(1 downto 0);
	signal ulaz_tb : std_logic_vector(3 downto 0);
	signal izlaz_tb : std_logic_vector(3 downto 0);
	signal WE_tb : std_logic;
begin
	dut1 : citajPisi port map (adresa => adresa_tb,
					ulaz => ulaz_tb,
					WE => WE_tb,
					izlaz => izlaz_tb);
	STIMULUS : process
	begin
		WE_tb <= '0';
		for i in 0 to 3 loop
			adresa_tb <= std_logic_vector(to_unsigned(i,2));
			report "adresa=" & to_string(adresa_tb) & "izalaz=" & to_string(izlaz_tb);
		end loop;
		
		WE_tb <= '1';
		for i in 0 to 3 loop
			adresa_tb <= std_logic_vector(to_unsigned(i,2));
			ulaz_tb <= std_logic_vector(to_unsigned(i,4));
		end loop;
	
		WE_tb <= '0';
		for i in 0 to 3 loop
			adresa_tb <= std_logic_vector(to_unsigned(i,2));
			report "adresa=" & to_string(adresa_tb) & "izalaz=" & to_string(izlaz_tb);
		end loop;
	end process;
end architecture;

