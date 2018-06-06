architecture tristateout of buscontrol is
begin
	WRITE: process(sel, data_out)
	begin
		if sel = '1' then
			-- Schreibprozess
			my_bus <= std_logic_vector(data_out);
		else
			my_bus <= (others => 'Z');
		end if;
	end process;
	
	-- Leseprozess
	READ: data_in <= std_logic_vector(my_bus);
	
end architecture tristateout;