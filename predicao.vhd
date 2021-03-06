-- Maquina de Moore. Saida depende apenas do estado atual

library ieee;
use ieee.std_logic_1164.all;

entity predicao is

	port(
		clk		 : in	std_logic;
		tomado	 : in	std_logic;
		reset	 : in	std_logic;
		saida	 : out	std_logic_vector(1 downto 0)
	);
	
end entity;

architecture arq_predicao of predicao is

	-- Enumera os estados da maquina de estados
	type state_type is (s0, s1, s2, s3);
	
	-- Registrador que armazena o estado atual
	signal state   : state_type;

begin
	-- Logica de proximo estado
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if tomado = '1' then
						state <= s0;
					else
						state <= s1;
					end if;
				when s1=>
					if tomado = '1' then
						state <= s0;
					else
						state <= s2;
					end if;
				when s2=>
					if tomado = '1' then
						state <= s4;
					else
						state <= s2;
					end if;
				when s3 =>
					if tomado = '1' then
						state <= s0;
					else
						state <= s2;
					end if;
			end case;
		end if;
	end process;
	
	-- Saida depende somente do estado atual
	process (state)
	begin
	
		case state is
			when s0 =>
				saida <= "00";
			when s1 =>
				saida <= "01";
			when s2 =>
				saida <= "10";
			when s3 =>
				saida <= "11";
		end case;
	end process;
	
end arq_predicao;
