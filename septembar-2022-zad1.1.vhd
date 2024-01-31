--koder8x3 uslovna dodela

entity encoder_8to3_binary is
	port (A : in bit_vector (7 downto 0); F : out bit_vector (2 downto 0));
end entity;

architecture encoder_8to3_binary1 of encoder_8to3_binary is
begin
	
	F <= "000" when (A="00000001") else
	"001" when (A="00000010") else 
	"010" when (A="00000100") else
	"011" when (A="00001000") else
	"100" when (A="00010000") else
	"101" when (A="00100000") else
	"110" when (A="01000000") else
	"111";

end architecture;
