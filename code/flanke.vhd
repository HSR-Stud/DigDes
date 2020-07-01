--Erfassen einer positiven Flanke 
if CLK'event and CLK = '1' then ...
if rising_edge(clk) then ... --std_logic/std_ulogic

--Erfassen einer negativen Flanke 
if CLK'event and CLK = '0' then ...
if falling_edge(clk) then ... --std_logic/std_ulogic
