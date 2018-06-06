-- Library declaration
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity edgedetpos_tb is
end edgedetpos_tb;

-- Architecture declaration
architecture testbench of edgedetpos_tb is
-- Konstanten
	constant f    : integer := 1000;    	
	constant T    : time    := 1 sec / f;
-- TB interne Signale	
	signal clk_tb     : std_ulogic; -- Master sim clock 
	signal reset_tb    : std_ulogic; -- Reset signal sim 
	signal inp_tb     : std_ulogic;
	signal oup_tb     : std_ulogic;
	signal oup_exp_tb : std_ulogic;

-- Portdeklaration des DUT
	component edgedetpos
		port(clk  : in  std_ulogic;
			 reset : in  std_ulogic;
			 inp  : in  std_ulogic;
			 oup  : out std_ulogic);
	end component edgedetpos;
	-- for all: entity name use entity entity name (architecture name)
	for all: edgedetpos use entity work.edgedetpos(behavioral);
begin
	-- Device unter test port mapping
	dut : edgedetpos
		port map(clk  => clk_tb,
			     reset => reset_tb,
			     inp  => inp_tb,
			     oup  => oup_tb);
	-- Clock generator		
	stimuli_clk : process
	begin
		clk_tb <= '0';
		wait for T / 2;
		clk_tb <= '1';
		wait for T / 2;
	end process;
	-- Reset generator. 	
	stimuli_reset : reset_tb <= '1', '0' after 3 ms;
	-- Generator for stimuli (== inputs)
	stimuli_inp : process
	begin
		inp_tb <= '0';
		wait for 0.5 * T;
		inp_tb <= '1';
-- und so weiter
		wait;
	end process;
	-- Generator for expected response	 (== output)
	stimuli_oup_exp : process
	begin
		oup_exp_tb <= '0';
		wait for 5.5 * T;
		oup_exp_tb <= '1';
-- und so weiter
		wait;
	end process;
	-- Evaluation		
	evaluation : process
	begin
		wait until rising_edge(clk_tb);
		wait for eval * T;              -- evaluation short before next clock
		loop
			assert (oup_exp_tb = oup_tb) report "Error oup" severity error;
			wait for T;                 -- one sample per clock period
		end loop;
		wait;
	end process;
end architecture testbench;