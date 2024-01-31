entity demux_1to8 is
port (A : in bit; Sel : in bit_vector(2 downto 0); F : out bit_vector(7 downto 0));
end entity;

architecture demux_1to8_a of demux_1to8 is
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

architecture demux_1to8_tb_a of demux_1to8_tb is

	component demux_1to8 is
		port (A : in bit; Sel : in bit_vector (2 downto 0); F : out bit_vector (7 downto 0));
	end component;

	signal A_tb : bit;
	signal Sel_tb : bit_vector(2 downto 0);
	signal F_tb : bit_vector(7 downto 0);
begin
	dut1 : demux_1to8 port map (A => A_tb, Sel => Sel_tb, F => F_tb);

	STIMULUS : process
	begin
		A_tb <= '1'; 
		Sel_tb <= "101";
		wait for 100 ps;
		A_tb <= '1'; 
		Sel_tb <= "001";
		wait for 100 ps;
	end process;
end architecture;
		 
