library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

entity timegen is
  port
  (
    clk : in std_ulogic;
    reset : in std_ulogic;
    trigger : out std_ulogic;
    time_val : out bit_vector(7 downto 0)
  );
end timegen;

architecture structural of timegen is 
	constant maxcount1 : integer := 1000;
	constant maxcount2 : integer := 256;
	constant maxcount3 : integer := 16;
	
	signal intClock: std_ulogic;

	component genTimer
	generic(
		maxcount : integer := 127);
	port(
		clk  : in  std_ulogic;
		rst  : in  std_ulogic;
		inp  : in  std_ulogic;
		oup  : out std_ulogic_vector(natural(ceil(log2(real(maxcount2 + 1)))) - 1 downto 0);
		tick : out std_ulogic
	);
	end component genTimer;
	
begin
sekZahler : component genTimer
	generic map(
		maxcount => maxcount1
	)
	port map(
		clk  => clk,
		rst  => reset,
		inp  => clk,
		oup  => open,
		tick => intClock
	);
	
TrigGen: component genTimer
	generic map(
		maxcount => maxcount3
	)
	port map(
		clk  => clk,
		rst  => reset,
		inp  => intClock,
		oup  => open,
		tick => trigger
	);

TimeCount: component genTimer
	generic map(
		maxcount => maxcount2
	)
	port map(
		clk  => clk,
		rst  => reset,
		inp  => intClock,
		oup  => time_val,
		tick => open
	);

end architecture structural;