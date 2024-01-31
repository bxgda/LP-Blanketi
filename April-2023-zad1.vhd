--dekoder8x3 selekciona dodela

entity encoder_8to3_binary is
	port (A : in bit_vector(7 downto 0) ; F : out bit_vector (2 downto 0));
end entity;

architecture encoder_8to3_binary_a of encoder_8to3_binary is
begin
	with A select 
	F <= "000" when "00000001",
		"001" when "00000010",
		"010" when "00000100",
		"011" when "00001000",
		"100" when "00010000",
		"101" when "00100000",
		"110" when "01000000",
		"111" when others;
end architecture;

entity encoder_8to3_binary_tb is
end entity;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

architecture encoder_8to3_tb of encoder_8to3_binary is

signal A_tb : bit_vector(7 downto 0);
signal F_tb : bit_vector(2 downto 0);

component encoder_8to3_binary is
	port (A : in bit_vector (7 downto 0); F : out bit_vector (2 downto 0));
end component;

begin

dut1 : encoder_8to3_binary port map (A => A_tb, F => F_tb);

radSaFajlovima : process

	file Fout: TEXT open WRITE_MODE is "output";
	file Fin: TEXT open READ_MODE is "input";
	variable ispis_linija : line;
	variable citanje_linija : line; 
	variable pomocnaA : bit_vector(7 downto 0);
	variable pomocnaF : bit_vector(2 downto 0);

begin
	while(not endfile(Fin)) loop
		readline(Fin, citanje_linija);
		read(citanje_linija, pomocnaA);
		A_tb <= pomocnaA;
		wait for 10ns;

		write(ispis_linija, string'("A="));
		write(ispis_linija, A_tb);
		write(ispis_linija, string'("F="));
		write(ispis_linija, F_tb);
		writeline(Fout, ispis_linija);
	end loop;
	wait;
end process;
end architecture;
	
