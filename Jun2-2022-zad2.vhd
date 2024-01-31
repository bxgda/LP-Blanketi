library IEEE;
use IEEE.std_logic_1164.all;

entity fsm1_behavioral is
	port(clock, reset : in std_logic; ulaz : in std_logic; izlaz : out std_logic);
end entity;

architecture fsm1_behavioral_a of fsm1_behavioral is

	subtype stanje is std_logic_vector(1 downto 0);
	constant Start : stanje := "00";
	constant Midway : stanje := "01";
	constant Done : stanje := "10";
	signal trenutno, sledece : stanje;
begin
	memorija : process (clock, reset)
	begin 
		if(reset='0') then trenutno <= Start;
		elsif(rising_edge(clock)) then trenutno <= sledece;
		end if;
	end process;

	prelaz : process (trenutno, ulaz)
	begin
		case(trenutno) is
			when Start => if(ulaz = '1') then sledece <= Midway;
			else sledece <= Start;
			end if;
			when Midway => sledece <= Done;
			when Done => sledece <= Start;
			when others => sledece <= Start;
		end case;
	end process;

	izlazi : process (trenutno, ulaz)
	begin
		case (trenutno) is
			when Start => izlaz <= '0';
			when Midway => izlaz <= '0';
			when Done => izlaz <= ulaz;
			when others => izlaz <= '0';
		end case;
	end process;
end architecture;





