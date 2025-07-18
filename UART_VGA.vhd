library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY UART_VGA IS
    PORT (
        MAX10_CLK1_50    : IN  std_logic;
        SW          		: IN  std_logic_vector(9 downto 0);
        KEY         		: IN  std_logic_vector(3 downto 0);
        LEDR        		: OUT std_logic_vector(9 downto 0);
        VGA_HS,VGA_VS    : OUT std_logic;
        VGA_R,VGA_G,VGA_B: OUT std_logic_vector(3 downto 0);
        GPIO       : INOUT std_logic_vector(15 downto 0)
    );
END UART_VGA;

ARCHITECTURE MAIN OF UART_VGA IS
-- UART signals
SIGNAL TX_DATA : std_logic_vector(7 downto 0);
SIGNAL TX_START : std_logic := '0';
SIGNAL TX_BUSY : std_logic := '0';
SIGNAL RX_DATA : std_logic_vector(7 downto 0);
SIGNAL RX_BUSY : std_logic;
CONSTANT GPIO_TXD : integer := 0;  -- Using GPIO[0] for TX
CONSTANT GPIO_RXD : integer := 1;  -- Using GPIO[1] for RX

-- VGA signals
SIGNAL VGACLK, RESET : std_logic := '0';
SIGNAL VGACLK_VECTOR : std_logic_vector(1 downto 0) := "00";

-- Text buffer for UART received data (up to 16 characters)
SIGNAL TEXT_BUFFER : string(1 to 16) := "1234567812345678";
SIGNAL BUFFER_INDEX : integer range 0 to 16 := 0;
SIGNAL NEW_CHAR_RECEIVED : std_logic := '0';

---------------------------------
-- UART components
COMPONENT TX IS
    PORT(
        CLK         : IN  std_logic;
        START       : IN  std_logic;
        BUSY        : OUT  std_logic;
        DATA        : IN  std_logic_vector(7 downto 0);
        TX_LINE     : OUT std_logic
    );
END COMPONENT TX;

COMPONENT RX IS
    PORT(
        CLK         : IN  std_logic;
        RX_LINE     : IN  std_logic;
        DATA        : OUT std_logic_vector(7 downto 0);
        BUSY        : OUT std_logic
    );
END COMPONENT RX;

-- VGA components
COMPONENT PLL IS
    PORT (
        clk_in_clk  : in  std_logic := 'X'; -- clk
        clk_out_clk : out std_logic;        -- clk
        reset_reset : in  std_logic := 'X'  -- reset
    );
END COMPONENT PLL;
	 
COMPONENT SYNC_UART IS
    PORT(
        CLK         : IN STD_LOGIC;
        HSYNC       : OUT STD_LOGIC;
        VSYNC       : OUT STD_LOGIC;
        R           : OUT STD_LOGIC_VECTOR(3 downto 0);
        G           : OUT STD_LOGIC_VECTOR(3 downto 0);
        B           : OUT STD_LOGIC_VECTOR(3 downto 0);
        KEYS        : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        S           : IN STD_LOGIC_VECTOR(1 downto 0);
        TEXT_DATA   : IN STRING(1 to 16)
    );
END COMPONENT SYNC_UART;

BEGIN 
    -- UART connections
    C1: TX PORT MAP (MAX10_CLK1_50, TX_START, TX_BUSY, TX_DATA, GPIO(GPIO_TXD));
    C2: RX PORT MAP (MAX10_CLK1_50, GPIO(GPIO_RXD), RX_DATA, RX_BUSY);
    
    -- VGA connections
    VGACLK_VECTOR(0) <= MAX10_CLK1_50;
    C3: PLL PORT MAP (MAX10_CLK1_50, VGACLK, RESET);
    C4: SYNC_UART PORT MAP (VGACLK, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, KEY, SW(1 downto 0), TEXT_BUFFER);

    -- Process to handle UART TX based on switches and key press
    PROCESS(MAX10_CLK1_50)
    BEGIN
        IF(MAX10_CLK1_50'EVENT AND MAX10_CLK1_50 = '1') THEN
            IF(KEY(0) = '0' AND TX_BUSY = '0') THEN
               TX_DATA <= SW(7 downto 0);
               TX_START <= '1';
            ELSE
                TX_START <= '0';
            END IF;
        END IF;
    END PROCESS;
    
    -- Process to handle receiving data and storing in buffer
    PROCESS(RX_BUSY, KEY(1))
    BEGIN
        -- Reset buffer when KEY(1) is pressed
        IF(KEY(1) = '0') THEN
            BUFFER_INDEX <= 0;
            TEXT_BUFFER <= "1234567812345678";
            NEW_CHAR_RECEIVED <= '0';
        -- Store received data in buffer
        ELSIF(RX_BUSY'EVENT AND RX_BUSY = '0') THEN
            -- Display current data on LEDs
            LEDR(7 downto 0) <= RX_DATA;
            
            -- Add to text buffer if there's space
            IF(BUFFER_INDEX < 16) THEN
                BUFFER_INDEX <= BUFFER_INDEX + 1;
                -- Convert ASCII value to character and add to buffer
                -- This works assuming ASCII character data is being sent
                TEXT_BUFFER(BUFFER_INDEX+1) <= character'val(to_integer(unsigned(RX_DATA)));
                NEW_CHAR_RECEIVED <= '1';
            END IF;
        END IF;
    END PROCESS;
END MAIN;
