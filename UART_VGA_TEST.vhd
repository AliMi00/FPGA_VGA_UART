library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY UART_VGA_TEST IS
    PORT (
        MAX10_CLK1_50    : IN  std_logic;
        SW          		: IN  std_logic_vector(9 downto 0);
        KEY         		: IN  std_logic_vector(3 downto 0);
        LEDR        		: OUT std_logic_vector(9 downto 0);
        VGA_HS,VGA_VS    : OUT std_logic;
        VGA_R,VGA_G,VGA_B: OUT std_logic_vector(3 downto 0);
        Arduino_IO       : INOUT std_logic_vector(15 downto 0)
    );
END UART_VGA_TEST;

ARCHITECTURE MAIN OF UART_VGA_TEST IS
    -- Component declaration for UART_VGA
    COMPONENT UART_VGA IS
        PORT (
            MAX10_CLK1_50    : IN  std_logic;
            SW          		: IN  std_logic_vector(9 downto 0);
            KEY         		: IN  std_logic_vector(3 downto 0);
            LEDR        		: OUT std_logic_vector(9 downto 0);
            VGA_HS,VGA_VS    : OUT std_logic;
            VGA_R,VGA_G,VGA_B: OUT std_logic_vector(3 downto 0);
            Arduino_IO       : INOUT std_logic_vector(15 downto 0)
        );
    END COMPONENT;
BEGIN
    -- Instantiate UART_VGA
    UVG: UART_VGA PORT MAP(
        MAX10_CLK1_50 => MAX10_CLK1_50,
        SW => SW,
        KEY => KEY,
        LEDR => LEDR,
        VGA_HS => VGA_HS,
        VGA_VS => VGA_VS,
        VGA_R => VGA_R,
        VGA_G => VGA_G,
        VGA_B => VGA_B,
        Arduino_IO => Arduino_IO
    );
END MAIN;
