
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;


 
ENTITY FIFO_TB IS
END FIFO_TB;
 
ARCHITECTURE behavior OF FIFO_TB IS 
 
      -- Inputs and the outputs declaration 
		signal clk ,reset,enr , enw , empty ,full : std_logic := '0' ;
		signal data_in , data_out : std_logic_vector(7 downto 0 ) := (others=> '0' ) ;
		--Temperoary signlas 
		signal i : integer := 0 ;
		--clock period definations 
		constant clk_period : time := 10ns;
		constant depth : integer := 16 ; -- Specify depth of fifo here 
		
		BEGIN 
		
		-- instantiate the UUT 
		uut : entity work.fifo generic map (depth=> depth) PORT MAP 
		(data_in , enw, enr,clk ,reset , full ,empty ,data_out  ) ;
		
		
		-- clock proces definations 
		clk_process : process 
		
		begin 
		clk <= '0' ;
		wait for clk_period / 2 ;
		clk<= '1';
		wait for clk_period /2 ;
		end process;
		
		
	--	stimulus process 
		stim_proc : process 
		begin 
		
		   reset <= '1' ;--apply reset for one clock cycle 
			wait for clk_period ;
			reset <='0' ;
			wait for clk_period *3 ; --wait for 3 clk periods
			enw <= '1' ; enr <= '0' ; -- write 10 values to fifo 
			for i in 1 to 16 loop 
			       data_in<= conv_std_logic_vector(i,8);
					 wait for clk_period ;
		   end loop;
			
			  enw <='0' ; enr <= '1' ; -- read 4 values from fifo 
			  wait for clk_period * 16 ;
			  --enw <= '0' ; enr <='0' ; --  wair for sme clk cycles 
			 -- wait for clk_period*10 ;
			--  enw <='1' ; enr <='0' ; --wite 10 values to fifo
			  
			 --- for i in 11 to 20 loop 
			   --   data_in <= conv_std_logic_vector(i,8) ;
				--	wait for clk_period;
				--	end loop ;
					--enw <='0' ; enr <= '0' ; 
				--	wait for clk_period * 10 ; -- wait 
             --  enw <='0' ; enr<= '1' ;  -- read 4 values 
				--	wait for clk_period * 4 ; -- wait 
             --  enw <='0' ; enr<= '0' ;
				--	wait for clk_period  ; 
              -- enw <='0' ; enr<= '1' ;  -- read 4 values 
					--wait for clk_period * 8  ; -- wait 
              -- enw <='0' ; enr<= '0' ;
					--wait for clk_period  ;  
              -- enw <='0' ; enr<= '1' ;  -- read 8 values 
					--wait for clk_period * 4 ;
              -- enw <='0' ; enr<= '0' ;	
              -- wait for clk_period ; 
              -- enw <='0' ; enr<= '1' ;	-- read 4 values 
             --  wait for clk_period * 4 ; 
              -- enw <='0' ; enr<= '0' ;						

 end process ;
 END ;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 