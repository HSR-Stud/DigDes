-- Implizite form:
[identifier]: component_name
	port map(signal1, signal2, signal3);
-- Zuweisung entspr. Reihenfolge von Auflistung
-- in Entity der Komponente

--Explizite form:
[identifier]: component_name
	port map(
		in2 => signal2,
		out => signal3,
		in1 => signal1);
-- Allg: <SigComponent> => <SigArchitecture>
