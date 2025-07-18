library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY TX IS 
    PORT(
        CLK         : IN  std_logic;
        START       : IN  std_logic;
        BUSY        : OUT  std_logic;
        DATA        : IN  std_logic_vector(7 downto 0);
        TX_LINE     : OUT std_logic
    );
END TX;

ARCHITECTURE MAIN OF TX IS


    SIGNAL PRSCL    : INTEGER RANGE 0 TO 5208 := 0;
    SIGNAL INDEX    : INTEGER RANGE 0 TO 9 := 0;
    SIGNAL DATAFLL  : STD_LOGIC_VECTOR(9 downto 0);
    SIGNAL TX_FLG   : STD_LOGIC := '0';

BEGIN
    PROCESS(CLK)
    BEGIN
        IF (CLK'EVENT AND CLK = '1') THEN
            IF (TX_FLG='0' AND START='1') THEN
                TX_FLG <= '1';
                BUSY <= '1';
                DATAFLL(0) <= '0'; -- Start bit	
                DATAFLL(9) <= '1'; -- Stop bit	
                DATAFLL(8 DOWNTO 1) <= DATA;
            END IF;
            IF (TX_FLG='1') THEN
                IF (PRSCL < 5207) THEN
                    PRSCL <= PRSCL + 1;
                ELSE
                    PRSCL <= 0;
                END IF; 
                IF (PRSCL = 2607) THEN
                    TX_LINE <= DATAFLL(INDEX);
                    IF (INDEX < 9) THEN
                        INDEX <= INDEX + 1;
                    ELSE
                        TX_FLG <= '0';
                        BUSY <= '0';
                        INDEX <= 0;
                    END IF;
                END IF;                
            END IF;
        END IF;
    END PROCESS;
END MAIN;