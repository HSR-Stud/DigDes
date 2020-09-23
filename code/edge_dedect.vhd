library ieee;
use ieee.std_logic_1164.all;

entity edgedetpos is
	port(
		clk   : in  std_ulogic;
		reset : in  std_ulogic;
		inp   : in  std_ulogic;
		oup   : out std_ulogic
	);
end;

architecture behavioral of edgedetpos is
	type state_typ is (resetstate, wait_for_1, pulse, wait_for_0);

	signal present_state : state_typ;
	signal next_state    : state_typ;

begin
	output_logic : oup <= '1' when present_state = pulse else '0';

	next_state_logic : process(inp, present_state)
	begin
		next_state <= wait_for_0; -- default state
		case present_state is
			when wait_for_1 =>
				if (inp = '1') then
					next_state <= pulse;
				else
					next_state <= wait_for_1;
				end if;
			when pulse =>
				if (inp = '0') then
					next_state <= wait_for_1;
				end if;
			when wait_for_0 =>
				if (inp = '0') then
					next_state <= wait_for_1;
				end if;
			when others => -- resetstate
				if (inp = '0') then
					next_state <= wait_for_1;
				end if;
		end case;
	end process;

	registers : process(reset, clk)
	begin
		if (reset = '1') then -- asynchron
			present_state <= resetstate;
		elsif rising_edge(clk) then
			present_state <= next_state;
		end if;
	end process;

end behavioral;
