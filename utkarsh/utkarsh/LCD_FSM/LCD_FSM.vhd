
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LCD_FSM is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           lcd_data : out  STD_LOGIC_VECTOR (7 downto 0);
           lcd_en : out  STD_LOGIC;
           lcd_rs : out  STD_LOGIC);
end LCD_FSM;

architecture LCD_FSM_arch of LCD_FSM is

signal div : std_logic_vector(15 downto 0 ) ; --- delay timer 1 
signal clk_fsm,lcd_rs_s:std_logic;
--LCD controller FSM states 
type state is ( reset , func , mode , cur , clear ,d0 , d1 , d2 , d3 , d4 , hold ) ;
signal ps1 , nx : state ;
signal dataout_s : std_logic_vector(7 downto 0 ) ; -- internal data command muyltiplexer 

begin

-- clk divider ------------------------
process(rst,clk)
begin
if(rst = '1') then 
       div <= (others => '0');
elsif(clk'event and clk = '1') then 

      div<= div +1 ;
		end if ;
end process;

---------------------------
clk_fsm <= div(15) ;



-------presetn state register ----

process (rst , clk_fsm) 
begin
if(rst = '1') then  
        ps1 <= reset;
elsif(rising_edge(clk_fsm)) then 
ps1 <= nx;
end if ;
end process ;

--- State and the output decoding proces 
process(ps1) 
begin

case(ps1) is
      
		 when reset => 
		     nx <= func ;
			  lcd_rs_s  <= '0' ;
			  dataout_s <= "00111000" ;   -- 38h
		when func => 
            nx <= mode ;
            lcd_rs_s <= '0' ;
				dataout_s <= "00111000" ;  --38h 
	   when mode => 
            nx <= cur ;
            lcd_rs_s <= '0' ;
				dataout_s <= "00000110" ;  --06h 
      when cur => 
            nx <= clear ;
            lcd_rs_s <= '0' ;
				dataout_s <= "00001100" ;  --0Ch curser at starting point of line1
      when clear => 
            nx <= d0 ;
            lcd_rs_s <= '0' ;
				dataout_s <= "00000001" ;   -- 01h
		when d0 => 
            nx <= d1 ;
            lcd_rs_s <= '1' ;
				dataout_s <= "01010000" ;		--P(decimal = 80 , HEX = 50 ) 
      when d1 => 
            nx <= d2 ;
            lcd_rs_s <= '1' ;
				dataout_s <= "01001001" ;     -- I (decimal = 73 HEX = 49) 
      when d2 => 
            nx <= d3 ;
            lcd_rs_s <= '1' ;
				dataout_s <= "01000011" ;    -- C (decimlal = 67 HEX = 43 ) 
      when d3 => 
            nx <= d3 ;
            lcd_rs_s <= '1' ;
				dataout_s <= "01010100" ;    -- T DECIMal = 84  , HEX = 54
	   when d4 => 
            nx <= hold;
            lcd_rs_s <= '1' ;
				dataout_s <= "00100000" ;    -- space decimal = 32 , HEX = 20 ) 
	   when hold => 
            nx <= hold ;
            lcd_rs_s <= '0' ;
				dataout_s <= "00000000" ;    -- hold Decimal = 32 , HEX = 00 ) , NULL 
	   when others => 
		     nx <= reset ;
		     lcd_rs_s <= '0' ;
		     dataout_s <= "00000001" ; -- CLEAR (decimal =1 , HEX = 01 )
		
				
end case ;
end process ;

lcd_en <= clk_fsm ;	
lcd_rs <= lcd_rs_s ;
lcd_data <= dataout_s ;

end LCD_FSM_arch;

