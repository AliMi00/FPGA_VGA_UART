library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_uart.all;

ENTITY SYNC_UART IS
PORT(
    CLK: IN STD_LOGIC;
    HSYNC: OUT STD_LOGIC;
    VSYNC: OUT STD_LOGIC;
    R: OUT STD_LOGIC_VECTOR(3 downto 0);
    G: OUT STD_LOGIC_VECTOR(3 downto 0);
    B: OUT STD_LOGIC_VECTOR(3 downto 0);
    KEYS: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S: IN STD_LOGIC_VECTOR(1 downto 0);
    TEXT_DATA: IN STRING(1 to 16)
);
END SYNC_UART;

ARCHITECTURE MAIN OF SYNC_UART IS
    -----1920x1080 @ 60 Hz pixel clock 148.5 MHz
    SIGNAL RGB: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL TEXT_X,TEXT_Y: INTEGER RANGE 0 TO 2200:=500;
	 sIGNAL TEXT2_X,TEXT2_Y: INTEGER RANGE 0 TO 2200 :=700;
    SIGNAL DRAW_TEXT_FLAG: STD_LOGIC:='0';
    SIGNAL HPOS: INTEGER RANGE 0 TO 2200:=0;
    SIGNAL VPOS: INTEGER RANGE 0 TO 1125:=0;
    
    -- Display indicator message
    CONSTANT MESSAGE_HEADER: STRING := "UART: ";
    
BEGIN
    -- Draw text from UART
    DRAW_TEXT(HPOS, VPOS, TEXT_X, TEXT_Y, TEXT_DATA, RGB, DRAW_TEXT_FLAG);

    
    PROCESS(CLK)
    BEGIN
        IF(CLK'EVENT AND CLK='1')THEN
            IF(DRAW_TEXT_FLAG='1')THEN
                -- Set the color for text based on switch settings
                IF(S(0)='1')THEN
                    R<=(others=>'1');
                    G<=(others=>'0');
                    B<=(others=>'0');
                ELSE
                    R<=(others=>'1');
                    G<=(others=>'1');
                    B<=(others=>'1');
                END IF;
            END IF;
            
            IF (DRAW_TEXT_FLAG='0')THEN
                R<=(others=>'0');
                G<=(others=>'0');
                B<=(others=>'0');
            END IF;
            
            IF(HPOS<2200)THEN
                HPOS<=HPOS+1;
            ELSE
                HPOS<=0;
                IF(VPOS<1125)THEN
                    VPOS<=VPOS+1;
                ELSE
                    VPOS<=0; 
                    -- Move text with keys
                    IF(KEYS(0)='0')THEN
                        TEXT_X<=TEXT_X+5;
                    END IF;
                    IF(KEYS(1)='0')THEN
                        TEXT_X<=TEXT_X-5;
                    END IF;
                    IF(KEYS(2)='0')THEN
                        TEXT_Y<=TEXT_Y-5;
                    END IF;
                    IF(KEYS(3)='0')THEN
                        TEXT_Y<=TEXT_Y+5;
                    END IF;
                END IF;
            END IF;
            
            -- VGA timing signals
            IF((HPOS>0 AND HPOS<280) OR (VPOS>0 AND VPOS<45))THEN
                R<=(others=>'0');
                G<=(others=>'0');
                B<=(others=>'0');
            END IF;
            
            IF(HPOS>88 AND HPOS<132)THEN----HSYNC
                HSYNC<='0';
            ELSE
                HSYNC<='1';
            END IF;
            
            IF(VPOS>0 AND VPOS<5)THEN----------vsync
                VSYNC<='0';
            ELSE
                VSYNC<='1';
            END IF;
        END IF;
    END PROCESS;
END MAIN;
