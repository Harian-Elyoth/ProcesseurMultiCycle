library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vic_tb is
end entity vic_tb;

architecture bench of vic_tb is
  
  signal clk, rst : std_logic;
  signal serv_irq, irq0, irq1 : std_logic;
  signal irq : std_logic;
  signal vicpc : std_logic_vector(31 downto 0);
  
begin
  
  process
    
    begin
      
      clk <= '1';
      
      wait for 10 ns;
      
      clk <= '0';
      
      wait for 10 ns;
      
    end process;
    
    process
      
      begin
        
        rst <= '1';
        
        wait for 20 ns;
        
        irq0 <= '1';
        
        wait for 20 ns;
        
        irq0 <= '0';
                
        wait for 200 ns;
        
        serv_irq <= '1';
        
        wait for 20 ns;
        
        serv_irq <= '0';
        
        irq1 <= '1';
        
        wait for 20 ns;
        
        irq1 <= '0';
        
        wait for 200 ns;
        
        irq0 <= '1';
        
        wait for 20 ns;
        
        irq0 <= '1';
        
        wait for 200 ns;
        
        serv_irq <= '1';
        
        wait;
        
      end process;
      
vic_1: entity work.VIC port map(clk => clk, reset => rst, serv_irq => serv_irq, IRQ0 => IRQ0, IRQ1 => IRQ1, IRQ => IRQ, VICPC => VICPC);
  
end architecture;   