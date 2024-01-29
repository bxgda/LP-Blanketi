library IEEE;
use IEEE.std_logic_1164.all;

entity fsm2_behavioral is
port(Clock, Reset : in std_logic; Din : in std_logic; Dout : out std_logic);
end entity;

architecture fsm2_behavioral1 of fsm2_behavioral is
	subtype stanje is std_logic_vector (3 downto 0);		--zato sto kaze one-hot za kdiranje stanja (one hot je 1,2,4,8,16,32...)
	constant s0 : stanje := "0001";
	constant s1 : stanje := "0010";
	constant s2 : stanje := "0100";
	constant s3 : stanje := "1000";
	signal trenutno, sledece : stanje;
begin
	memorija : process (Clock, Reset)				--proces za memoriju uvek isto
	begin
		if(Reset='0') then trenutno <= s0;
		elsif(rising_edge(clock)) then trenutno <= sledece;
		end if;
	end process;

	prelaz : process (trenutno, Din)
	begin
		case(trenutno) is
			when s0 => if(Din = '0') then sledece <= s0;
			else sledece <= s1;
			end if;
			when s1 => if(Din = '0') then sledece <= s2;
			else sledece <= s3;
			end if;
			when s3 => if(Din = '0') then sledece <= s3;
			else sledece <= s0;
			end if;
			when s2 => if(Din = '0') then sledece <= s0;
			else sledece <= s3;
			end if;
			when others => sledece <= s0;
		end case;
	end process;

	izlazi : process (trenutno, Din)
	begin
		case(trenutno) is
			when s0 => Dout <= Din;
			when s1 => if(Din = '0') then Dout <= '1';
			else Dout <='0';
			end if;
			--when s1 => Dout <= not Din
			when s2 => Dout <= Din;
			when s3 => Dout <= Din;
			when others => Dout <= '0';
		end case;
	end process;
end architecture;