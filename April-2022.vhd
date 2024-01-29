entity mux_8to1 is
	port (A : in bit_vector (7 downto 0); Sel : in bit_vector (2 downto 0); F : out bit);
end entity;

architecture mux_8to11 of mux_8to1 is
signal m1,m2,m3,m4,m5,m6,m7,m8 : bit;
begin
m1<=(A(0) and not Sel(2) and not Sel(1) and not Sel(0));
m2<=(A(1) and not Sel(2) and not Sel(1) and Sel(0));
m3<=(A(2) and not Sel(2) and Sel(1) and not Sel(0));
m4<=(A(3) and not Sel(2) and Sel(1) and Sel(0));
m5<=(A(4) and Sel(2) and not Sel(1) and not Sel(0));
m6<=(A(5) and Sel(2) and not Sel(1) and Sel(0));
m7<=(A(6) and Sel(2) and Sel(1) and not Sel(0));
m8<=(A(7) and Sel(2) and Sel(1) and Sel(0));

F<= m1 or m2 or m3 or m4 or m5 or m6 or m7 or m8;
end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

entity test_bench is
end entity;

architecture test_bench1 of test_bench is
signal A_tb : bit_vector (7 downto 0); 
signal Sel_tb : bit_vector (2 downto 0);
signal F_tb : bit;

component mux_8to1 is
	port (A : in bit_vector (7 downto 0); Sel : in bit_vector (2 downto 0); F : out bit);
end component;

begin		--za arhitekuru

dut1 : mux_8to1 port map (A=>A_tb, Sel=>Sel_tb, F=>F_tb);

PROCCES: process

file Fout: TEXT open WRITE_MODE is "output";
file Fin: TEXT open READ_MODE is "input";
variable current_wline : line;
variable current_rline : line; 
variable pomocna : bit_vector(7 downto 0);
variable pomocna2 : bit_vector(2 downto 0);

begin		--za proces

while (not endfile(Fin)) loop
readline(Fin, current_rline);		--u tu liniju procita iz fajla samo jednu liniju
read(current_rline, pomocna);
read(current_rline, pomocna2);
A_tb<=pomocna;
Sel_tb<=pomocna2;
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
