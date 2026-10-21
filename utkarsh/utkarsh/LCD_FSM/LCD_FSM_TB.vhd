
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY LCD_FSM_TB IS
END LCD_FSM_TB;
 
ARCHITECTURE behavior OF LCD_FSM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LCD_FSM
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         lcd_data : OUT  std_logic_vector(7 downto 0);
         lcd_en : OUT  std_logic;
         lcd_rs : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal lcd_data : std_logic_vector(7 downto 0);
   signal lcd_en : std_logic;
   signal lcd_rs : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LCD_FSM PORT MAP (
          clk => clk,
          rst => rst,
          lcd_data => lcd_data,
          lcd_en => lcd_en,
          lcd_rs => lcd_rs
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst<='1';
		wait for 20 ns ;
		rst<='0' ;
		--insert stimulus here 

      wait;
   end process;

END;
