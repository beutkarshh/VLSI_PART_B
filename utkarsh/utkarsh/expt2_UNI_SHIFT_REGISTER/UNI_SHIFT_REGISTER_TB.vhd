
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_UNSIGNED.ALL;
ENTITY UNI_SHIFT_REGISTER_TB IS
END UNI_SHIFT_REGISTER_TB;
 
ARCHITECTURE behavior OF UNI_SHIFT_REGISTER_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UNI_SHIFT_REGISTER
    PORT(
         Pin : IN  std_logic_vector(3 downto 0);
         Mode : IN  std_logic_vector(1 downto 0);
         Sin : IN  std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic;
         Pout : OUT  std_logic_vector(3 downto 0);
         Sout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Pin : std_logic_vector(3 downto 0) := "1101";
   signal Mode : std_logic_vector(1 downto 0) :=(others => '0');
   signal Sin : std_logic := '0';
   signal rst : std_logic := '0';
   signal clk : std_logic := '1';

 	--Outputs
   signal Pout : std_logic_vector(3 downto 0);
   signal Sout : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UNI_SHIFT_REGISTER PORT MAP (
          Pin => Pin,
          Mode => Mode,
          Sin => Sin,
          rst => rst,
          clk => clk,
          Pout => Pout,
          Sout => Sout
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
   stim_proc_Mode: process
   begin		
           Mode<="00";
			  wait for 80ns;
			  Mode<="01";
			  wait for 50ns;
			  Mode<="10";
			  wait for 50ns;
			  Mode<="11";
			  wait for 20ns;
			 
   end process;
	stim_proc_Sin: process
   begin		
           Sin<='1';
			  wait for 10ns;
			  Sin<='0';
			  wait for 10ns;
			  Sin<='1';
			  wait for 10ns;
			  Sin<='0';
			  wait for 10ns;
			 --Sin process for 0-40
			 Sin<= '0' ;
			 wait for 40 ns ;
			 
			 -- Sin process for 40-80
			 
			 Sin <= '1' ;
			 wait for 10 ns ;
			 Sin <= '0' ;
			 wait for 10 ns ;
			 Sin <= '1' ;
			 wait for 10 ns ;
			 Sin <= '0' ;
			 wait for 10 ns ;
			 
			 
			 --Sin process for 80-120 
			 
			 
			 
			 
			 
			 end process ;
			 
   
	stim_proc_rst : process
   begin		
          wait for 122.5 ns ;
			 rst <=  '1' ;
			 wait for 5 ns ;
			 rst <= '0' ;
			 wait ;
			 
   end process;

END;
