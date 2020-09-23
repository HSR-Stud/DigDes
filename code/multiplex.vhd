entity mux4x1 is
	port(s : in bit_vector(1 downto 0); -- select
		 e : in bit_vector(3 downto 0); -- Eingaenge
		 y : out bit); -- Ausgang
end mux4x1;

architecture process_if of mux4x1 is
begin
	process(e, s)
	begin
		if (s = "00") then
			y <= e(0);
		elsif (s = "01") then
			y <= e(1);
		elsif (s = "10") then
			y <= e(2);
		else
			y <= e(3);
		end if;
	end process;
end architecture process_if;

architecture selective of mux4x1 is
begin
	with s select y <=
		e(0) when "00",
		e(1) when "01",
		e(2) when "10",
		e(3) when others;
end selective;

architecture conditional of mux4x1 is
begin
	y <= e(0) when s = "00" else
       e(1) when s = "01" else
       e(2) when s = "10" else
       e(3) when s = "11";
end conditional;
