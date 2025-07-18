-- UART_VGA_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_VGA_tb is
end UART_VGA_tb;

architecture tb of UART_VGA_tb is
    -- Component declaration for UUT (Unit Under Test)
    component UART_VGA is
        port (
            MAX10_CLK1_50    : IN  std_logic;
            SW          		: IN  std_logic_vector(9 downto 0);
            KEY         		: IN  std_logic_vector(3 downto 0);
            LEDR        		: OUT std_logic_vector(9 downto 0);
            VGA_HS,VGA_VS    : OUT std_logic;
            VGA_R,VGA_G,VGA_B: OUT std_logic_vector(3 downto 0);
            Arduino_IO       : INOUT std_logic_vector(15 downto 0)
        );
    end component;
    
    -- Test signals
    signal clk : std_logic := '0';
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal key : std_logic_vector(3 downto 0) := (others => '1');
    signal ledr : std_logic_vector(9 downto 0);
    signal vga_hs, vga_vs : std_logic;
    signal vga_r, vga_g, vga_b : std_logic_vector(3 downto 0);
    signal arduino_io : std_logic_vector(15 downto 0) := (others => 'Z');
    
    -- UART transmit procedure for simulation
    procedure uart_transmit(
        constant data : in std_logic_vector(7 downto 0);
        signal tx_line : out std_logic;
        constant baud_period : in time := 8680 ns  -- For 115200 baud rate
    ) is
    begin
        -- Start bit
        tx_line <= '0';
        wait for baud_period;
        
        -- Data bits (LSB first)
        for i in 0 to 7 loop
            tx_line <= data(i);
            wait for baud_period;
        end loop;
        
        -- Stop bit
        tx_line <= '1';
        wait for baud_period;
    end procedure;
    
begin
    -- Clock generation (50 MHz)
    process
    begin
        wait for 10 ns;
        clk <= not clk;
    end process;
    
    -- Instantiate UUT
    UUT: UART_VGA port map (
        MAX10_CLK1_50 => clk,
        SW => sw,
        KEY => key,
        LEDR => ledr,
        VGA_HS => vga_hs,
        VGA_VS => vga_vs,
        VGA_R => vga_r,
        VGA_G => vga_g,
        VGA_B => vga_b,
        Arduino_IO => arduino_io
    );
    
    -- Test sequence
    process
    begin
        -- Initialize
        wait for 100 ns;
        
        -- Reset text buffer
        key(1) <= '0';
        wait for 100 ns;
        key(1) <= '1';
        wait for 100 ns;
        
        -- Send "HELLO WORLD" via UART
        -- 'H'
        uart_transmit(x"48", arduino_io(1));
        wait for 50 us;
        
        -- 'E'
        uart_transmit(x"45", arduino_io(1));
        wait for 50 us;
        
        -- 'L'
        uart_transmit(x"4C", arduino_io(1));
        wait for 50 us;
        
        -- 'L'
        uart_transmit(x"4C", arduino_io(1));
        wait for 50 us;
        
        -- 'O'
        uart_transmit(x"4F", arduino_io(1));
        wait for 50 us;
        
        -- ' ' (space)
        uart_transmit(x"20", arduino_io(1));
        wait for 50 us;
        
        -- 'W'
        uart_transmit(x"57", arduino_io(1));
        wait for 50 us;
        
        -- 'O'
        uart_transmit(x"4F", arduino_io(1));
        wait for 50 us;
        
        -- 'R'
        uart_transmit(x"52", arduino_io(1));
        wait for 50 us;
        
        -- 'L'
        uart_transmit(x"4C", arduino_io(1));
        wait for 50 us;
        
        -- 'D'
        uart_transmit(x"44", arduino_io(1));
        wait for 50 us;
        
        -- End simulation
        wait for 1000 us;
        assert false report "Simulation completed" severity failure;
    end process;
end tb;
