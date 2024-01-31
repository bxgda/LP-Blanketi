--demux 1x8 konkurentna dodela i TB sa upism iz fajla i ispisom u fajl

entity demux_1to8 is
port (A : in bit; Sel : in bit_vector (2 downto 0); F : out bit_vector (7 downto 0));
end entity;

architecture demux_1to88 of demux_1to8 is
begin
	F(0) <= (A and not Sel(2) and not Sel(1) and not Sel(0));
	F(1) <= (A and not Sel(2) and not Sel(1) and Sel(0));
	F(2) <= (A and not Sel(2) and Sel(1) and not Sel(0));
	F(3) <= (A and not Sel(2) and Sel(1) and Sel(0));
	F(4) <= (A and Sel(2) and not Sel(1) and not Sel(0));
	F(5) <= (A and Sel(2) and not Sel(1) and Sel(0));
	F(6) <= (A and Sel(2) and Sel(1) and not Sel(0));
	F(7) <= (A and Sel(2) and Sel(1) and Sel(0));
end architecture;

entity demux_1to8_tb is 
end entity;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

architecture demux_1to8_tb_1 of demux_1to8_tb is

signal A_tb : bit;
signal F_tb : bit_vector (7 downto 0);
signal Sel_tb : bit_vector (2 downto 0);

component demux_1to8 is
port (A : in bit; Sel : in bit_vector (2 downto 0); F : out bit_vector (7 downto 0));
end component;

begin

dut1 : demux_1to8 port map (A=>A_tb, Sel=>Sel_tb, F=>F_tb);

procces : process

	file Fout: TEXT open WRITE_MODE is "output";
	file Fin: TEXT open READ_MODE is "input";
	variable current_wline : line;
	variable current_rline : line; 
	variable pomocnaA : bit;
	variable pomocnaSel : bit_vector (2 downto 0);

begin

	while(not endfile(Fin)) loop
		readline(Fin, current_rline);
		read(current_rline, pomocnaA);
		read(current_rline, pomocnaSel);
		A_tb <= pomocnaA;
		Sel_tb <= pomocnaSel;
		wait for 10 ns;

		write(current_wline, string'("A="));
		write(current_wline, A_tb);
		write(current_wline, string'("Sel="));
		write(current_wline, Sel_tb);
		write(current_wline, string'("F="));
		write(current_wline, F_tb);
		writeline(Fout, current_wline);
	end loop;
	wait;
end process;
end architecture;
	
