library IEEE;
use IEEE.std_logic_1164.all;

entity automat is
	port(clock, reset : in std_logic; ulaz : in std_logic; izlaz : out std_logic);
end entity;

architecture automat_a of automat is

	subtype stanje is std_logic_vector(3 downto 0);
	constant s0 : stanje := "0001";
	constant s1 : stanje := "0010";
	constant s2 : stanje := "0100";
	constant s3 : stanje := "1000";
	signal trenutno, sledece : stanje;
begin
	memorija : process (clock, reset)
	begin
		if(reset = '0') then trenutno <= s0;
		elsif(rising_edge(clock)) then trenutno <= sledece;
		end if;
	end process;

	prelaz : process (trenutno, ulaz)
	begin
		case (trenutno) is
			when s0 => if(ulaz = '1') then sledece <= s1;
			else sledece <= s0;
			end if;
			when s1 => if(ulaz = '1') then sledece <= s2;
			else sledece <= s0;
			end if;
			when s2 => if(ulaz = '1') then sledece <= s3;
			else sledece <= s0;
			end if;
			when s3 => if(ulaz = '1') then sledece <= s3;
			else sledece <= s0;
			end if;
			when others => sledece <= s0;
		end case;
	end process;

	izlazi : process (trenutno, ulaz)
	begin
		case (trenutno) is
			when s0 => if(ulaz = '1') then izlaz <= '0';
			else izlaz <= '1';
			end if;
			--when s0 => izlaz <= not ulaz
			when s1 => izlaz <= ulaz;
			when s2 => izlaz <= '0';
			when s3 => izlaz <= '0';
			when others => izlaz <= '0';
		end case;
	end process;
end architecture;



	
