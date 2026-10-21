
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity UNI_SHIFT_REGISTER is
    Port ( Pin : in  STD_LOGIC_VECTOR (3 downto 0);
           Mode : in  STD_LOGIC_VECTOR (1 downto 0);
           Sin : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Pout : out  STD_LOGIC_VECTOR (3 downto 0);
           Sout : out  STD_LOGIC);
end UNI_SHIFT_REGISTER;

architecture UNI_SHIFT_REGISTER_arch of UNI_SHIFT_REGISTER is
     SIGNAL temp:STD_LOGIC_VECTOR(3 DOWNTO 0 ) := "0000" ;
     SIGNAL flag:STD_LOGIC := '0' ;

begin 
PROCESS (rst,clk,Mode,Sin,Pin)
   BEGIN 
	
	    IF rst = '1' THEN 
		      Sout <= '0';
            Pout <= "0000";
				flag <= '0';
				
		ELSIF falling_edge(clk)
		THEN
		      CASE Mode IS 
				       WHEN "00" =>
						 temp( 3 DOWNTO 1 ) <= temp(2 DOWNTO 0 ) ;
						 temp(0) <= Sin ;
						 Sout <= temp(3) ;
						 Pout <= "0000" ;
						 
						 flag <= '0' ;
						  WHEN "01"  => 
								temp(3 DOWNTO 1 ) <= temp(2 DOWNTO 0 ) ;
								temp(0) <= Sin ;
								Pout <= temp ;
								Sout <= '0' ;
								flag <= '0' ; 
								
						  WHEN "10" =>
									  
									  IF flag = '0' THEN 
									   temp<= Pin ;
										Pout <= "0000" ;
										
										ELSE
										Sout <= temp(3) ;
                              Pout <= "0000"	;
										temp(3 DOWNTO 1 ) <= temp(2 DOWNTO 0);
										END IF ;
										
										flag <= '1'  ;
										
         			   WHEN OTHERS =>
													temp <= Pin ;
													Pout <= temp ;
													Sout <= '0' ;
													flag <= '0' ;
													END CASE ;
													END IF ;
	END PROCESS ;
													
													
													
	end UNI_SHIFT_REGISTER_arch;
													
													
										
										
										 
						 


