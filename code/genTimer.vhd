library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

entity genTimer is
	generic(
		maxcount : integer := 127);
	port(
		clk  : in  std_ulogic;
		rst  : in  std_ulogic;
		inp  : in  std_ulogic;
		oup  : out bit_vector(natural(ceil(log2(real(maxcount + 1)))) - 1 downto 0);
		tick : out std_ulogic
	);
end entity genTimer;

architecture RTL of genTimer is
	-- Zustandsvariablen mit log2(maxCount) breite
	signal preCount, nexCount : 
	std_ulogic_vector(natural(ceil(log2(real(maxcount + 1)))) - 1 downto 0);

begin
-- Output Logic ----------------------------------
output_logic : oup <=to_bitvector(preCount);

-- Next State Logic ------------------------------
next_state_logic : process(preCount, inp)
begin
	nexCount <= preCount;
	if ((preCount = std_ulogic_vector(to_unsigned(maxcount,preCount'length))) and (inp = '1')) then
		nexCount <= (others => '0');
		tick     <= '1';
	elsif (inp = '1') then
		nexCount <= std_ulogic_vector(Unsigned(preCount)+1);
		tick     <= '0';
	end if;
end process;

-- Register Logic --------------------------------
register_logic : process(rst,clk)
begin
	if (rst = '1') then
		nexCount <= (others => '0');
	elsif (clk'event and (clk = '1')) then
		preCount <= nexCount;
	end if;

end process;

end architecture RTL;
