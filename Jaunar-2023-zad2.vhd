--sinhroni citaj pisi 8x2

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;


entity rw_8x2_sync is
	port(adresa : in std_logic_vector(2 downto 0);
		ulaz : in std_logic_vector(1 downto 0);
		WE : in std_logic;
		clock : in std_logic;
		izlaz : out std_logic_vector(1 downto 0));
end entity;

architecture rw_8x2_sync_a of rw_8x2_sync is
	type RW_type is array (0 to 7) of std_logic_vector(1 downto 0);
	signal RW : RW_type;
begin
	memorija : process(clock)
	begin
		if(rising_edge(clock)) then
			if(WE = '1') then
				RW(to_integer(unsigned(adresa))) <= ulaz;
			else
				izlaz <= RW(to_integer(unsigned(adresa)));
			end if;
		end if;
	end process;
end architecture;

entity rw_8x2_sync_tb is 
end entity;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

architecture rw_8x2_sync_tb_a of rw_8x2_sync_tb is
	component rw_8x2_sync 
		port(adresa : in std_logic_vector(2 downto 0);
			ulaz : in std_logic_vector(1 downto 0);
			WE : in std_logic;
			clock : in std_logic;
			izlaz : out std_logic_vector(1 downto 0));
	end component;
	signal adresa_tb : std_logic_vector(2 downto 0);
	signal ulaz_tb : std_logic_vector(1 downto 0);
	signal WE_tb : std_logic;
	signal clock_tb : std_logic;
	signal izlaz_tb : std_logic_vector(1 downto 0);
begin
	DUT1 : rw_8x2_sync port map (adresa => adresa_tb,
					ulaz => ulaz_tb,
					WE => WE_tb,
					clock => clock_tb,
					izlaz => izlaz_tb);
	clock_proces : process
	begin
		clock_tb <= '0'; wait for 4ns;
		clock_tb <= '1'; wait for 4ns;
	end process;

	STIMULUS : process
	begin
		WE_tb <= '0';
		for i in 0 to 7 loop
			wait until rising_edge(clock_tb);
			adresa_TB <= std_logic_vector(to_unsigned(i,3));
			wait until rising_edge(clock_TB);
			report "adress= " & to_string(adresa_tb) & 
			 " data_out= " & to_string(izlaz_tb);
		end loop;
		wait for 32ns;    --4ns puta 8 prolaza kroz petlju
		
		WE_tb <= '1';
		for i in 0 to 7 loop
			wait until rising_edge(clock_tb);
			adresa_tb <= std_logic_vector(to_unsigned(i,3));
			wait until rising_edge(clock_tb);
			ulaz_tb <= "00";
		end loop;
		wait for 32ns;

		WE_tb <= '0';
		for i in 0 to 7 loop
			wait until rising_edge(clock_tb);
			adresa_TB <= std_logic_vector(to_unsigned(i,3));
			wait until rising_edge(clock_TB);
			report "adress= " & to_string(adresa_tb) & 
			 " data_out= " & to_string(izlaz_tb);
		end loop;
		wait for 32ns;
	end process;
end architecture;

	
