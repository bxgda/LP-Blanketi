entity INV is
port (A : in bit; F : out bit);
end entity;
architecture INV_Arch of INV is
begin
F <= not A;
end architecture;

entity OR1 is
port (A, B, C, D : in bit; F : out bit);
end entity;
architecture OR_Arch of OR1 is
begin
F <= A or B or C or D;
end architecture;

entity AND1 is
port (A, B, C, D : in bit; F : out bit);
end entity;
architecture AND_Arch of AND1 is
begin
F <= A and B and C and D;
end architecture;

entity System1 is
port (A, B, C, D : in bit; F : out bit);
end entity;
architecture Sys_arch of System1 is

signal An, Bn, Cn, Dn : bit;
signal m1, m2, m3, m4 : bit;

component INV is 
port (A : in bit; F : out bit);
end component;

component OR1 is
port (A, B, C, D : in bit; F : out bit);
end component;

component AND1 is
port (A, B, C, D : in bit; F : out bit);
end component;

begin

U1 : INV port map (A=>A, F=>An);
U2 : INV port map (A=>B, F=>Bn);
U3 : INV port map (A=>C, F=>Cn);
U4 : INV port map (A=>A, F=>Dn);

U5 : AND1 port map (A=>An, B=>Bn, C=>Cn, D=>D, F=>m1);
U6 : AND1 port map (A=>An, B=>Bn, C=>C, D=>D, F=>m2);
U7 : AND1 port map (A=>A, B=>Bn, C=>Cn, D=>D, F=>m3);
U8 : AND1 port map (A=>A, B=>Bn, C=>C, D=>D, F=>m4);

U9 : OR1 port map (A=>m1, B=>m2, C=>m3, D=>m4, F=>F);

end architecture;










