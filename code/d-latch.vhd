library ieee;

entity d_latch is
	port(
		d : in bit;
		g : in bit;
		rst : in bit;
		q : out bit
	);
end d_latch;

architecture behavioral of d_latch is
begin
	process(rst, d, g)
	Begin             
		if (rst = '1') then -- Reset-Bedingung
			q <= '0';
		elsif (g = '1') then
			q <= d;
		end if;      -- else fehlt bewusst.
                 -- Wenn gate = '0' dann
	end process;   -- soll Speicherverhalten
end behavioral;  -- realisiert werden.
