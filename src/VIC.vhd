library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity VIC is
	port(
		CLK : in std_logic;
		RESET : in std_logic;
		serv_irq : in std_logic;
		IRQ0, IRQ1 : in std_logic;
		IRQ : out std_logic;
		VICPC : out std_logic_vector(31 downto 0)
	);
end VIC;

architecture RTL of VIC is
Signal IRQ0_n, IRQ0_n_1, IRQ0_memo : std_logic;
Signal IRQ1_n, IRQ1_n_1,  IRQ1_memo : std_logic;

begin
	IRQ <= IRQ1_memo or IRQ0_memo;

	echantillon: process(CLK, RESET)
		begin

			if RESET = '1' then
				IRQ0_n <= '0';
				IRQ0_n_1 <= '0';

				IRQ1_n <= '0';
				IRQ1_n_1 <= '0';

			elsif rising_edge(clk) then

				IRQ0_n_1 <= IRQ0_n;
				IRQ0_n <= IRQ0;

				IRQ1_n_1 <= IRQ1_n;
				IRQ1_n <= IRQ1;

			end if;
		end process echantillon;

		transition: process(IRQ0_n, IRQ0_n_1, IRQ1_n, IRQ1_n_1, serv_irq, RESET)
			begin
			  if(RESET = '1') then
			    IRQ0_memo <= '0';
					IRQ1_memo <= '0';
				elsif(serv_irq = '1') then
					IRQ0_memo <= '0';
					IRQ1_memo <= '0';
				end if;
				
				if(IRQ0_n = '1' and IRQ0_n_1 = '0') then
					IRQ0_memo <= '1';
				end if;

				if(IRQ1_n = '1' and IRQ1_n_1 = '0') then
					IRQ1_memo <= '1';
				end if;
			end process transition;

		requetes: process(IRQ0_memo, IRQ1_memo, reset)
			begin
				if(RESET = '1') then
					VICPC <= (others => '0');
				elsif(IRQ0_memo = '1') then
					VICPC <= std_logic_vector(to_unsigned(9, 32));
				elsif(IRQ1_memo = '1') then
					VICPC <= std_logic_vector(to_unsigned(21, 32));
				else
					VICPC <= std_logic_vector(to_unsigned(0, 32));
				end if;
			end process;

end RTL;