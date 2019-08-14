Next_state_logic:process(INPUT,PRESENT_STATE)
  begin
  	-- Default Folgezustand
    NEXT_STATE <= RESET_STATE;  -- oder PRESENT_STATE
    case PRESENT_STATE is
      when S0 =>
        if (Bedingung als Fkt. der Eingaenge) then
          NEXT_STATE <= Sx0;
        else NEXT_STATE <= Sy0;
        end if;
      when S1 =>
      	....
      when others => null;
      -- oder  NEXT_STATE <= Reset_State;
    end case;
  end process;
