library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reaction_Timer is
    Port ( clk       : in  STD_LOGIC;
           reset     : in  STD_LOGIC;
           start     : in  STD_LOGIC;
           finish    : out STD_LOGIC;
           reaction  : out STD_LOGIC_VECTOR(15 downto 0));
end Reaction_Timer;

architecture Behavioral of Reaction_Timer is
    signal timer : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    signal running : boolean := false;
    signal random_delay : STD_LOGIC_VECTOR(15 downto 0) := "0101010101010101"; -- Replace with a random delay generator

begin
    process(clk, reset)
    begin
        if reset = '1' then
            running <= false;
            timer <= "0000000000000000";
            finish <= '0';
        elsif rising_edge(clk) then
            if start = '1' then
                running <= true;
                timer <= random_delay;
            end if;
            
            if running = true then
                timer <= timer - "0000000000000001";
                if timer = "0000000000000000" then
                    running <= false;
                    finish <= '1';
                    reaction <= timer;
                end if;
            end if;
        end if;
    end process;

end Behavioral;