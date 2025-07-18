library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package char_rom_uart is
    -- Character dimensions
    constant CHAR_WIDTH : integer := 8;
    constant CHAR_HEIGHT : integer := 8;
    
    -- Character ROM type definition
    type char_rom_type is array(0 to 127, 0 to 7) of std_logic_vector(7 downto 0);

    -- Character ROM content (basic ASCII characters)
    constant ROM_DATA : char_rom_type := (
        -- Space character (ASCII 32)
        32 => (
            "00000000",
            "00000000",
            "00000000",
            "00000000",
            "00000000",
            "00000000",
            "00000000",
            "00000000"
        ),
        -- Number characters (ASCII 48-57)
        48 => ( -- '0'
            "00111100",
            "01000110",
            "01001010",
            "01010010",
            "01100010",
            "01000010",
            "00111100",
            "00000000"
        ),
        49 => ( -- '1'
            "00011000",
            "00111000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "01111110",
            "00000000"
        ),
        50 => ( -- '2'
            "00111100",
            "01000010",
            "00000010",
            "00001100",
            "00110000",
            "01000000",
            "01111110",
            "00000000"
        ),
        51 => ( -- '3'
            "00111100",
            "01000010",
            "00000010",
            "00011100",
            "00000010",
            "01000010",
            "00111100",
            "00000000"
        ),
        52 => ( -- '4'
            "00001100",
            "00010100",
            "00100100",
            "01000100",
            "01111110",
            "00000100",
            "00000100",
            "00000000"
        ),
        53 => ( -- '5'
            "01111110",
            "01000000",
            "01111100",
            "00000010",
            "00000010",
            "01000010",
            "00111100",
            "00000000"
        ),
        54 => ( -- '6'
            "00111100",
            "01000010",
            "01000000",
            "01111100",
            "01000010",
            "01000010",
            "00111100",
            "00000000"
        ),
        55 => ( -- '7'
            "01111110",
            "00000010",
            "00000100",
            "00001000",
            "00010000",
            "00100000",
            "01000000",
            "00000000"
        ),
        56 => ( -- '8'
            "00111100",
            "01000010",
            "01000010",
            "00111100",
            "01000010",
            "01000010",
            "00111100",
            "00000000"
        ),
        57 => ( -- '9'
            "00111100",
            "01000010",
            "01000010",
            "00111110",
            "00000010",
            "01000010",
            "00111100",
            "00000000"
        ),
        -- Uppercase letters (ASCII 65-90)
        65 => ( -- 'A'
            "00111100",
            "01100110",
            "01100110",
            "01111110",
            "01111110",
            "01100110",
            "01100110",
            "00000000"
        ),
        66 => ( -- 'B'
            "01111100",
            "01100110",
            "01100110",
            "01111100",
            "01111100",
            "01100110",
            "01111100",
            "00000000"
        ),
        67 => ( -- 'C'
            "00111100",
            "01100110",
            "01100000",
            "01100000",
            "01100000",
            "01100110",
            "00111100",
            "00000000"
        ),
        68 => ( -- 'D'
            "01111100",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "01111100",
            "00000000"
        ),
        69 => ( -- 'E'
            "01111110",
            "01100000",
            "01100000",
            "01111100",
            "01100000",
            "01100000",
            "01111110",
            "00000000"
        ),
        70 => ( -- 'F'
            "01111110",
            "01100000",
            "01100000",
            "01111100",
            "01100000",
            "01100000",
            "01100000",
            "00000000"
        ),
        71 => ( -- 'G'
            "00111100",
            "01100110",
            "01100000",
            "01101110",
            "01100110",
            "01100110",
            "00111100",
            "00000000"
        ),
        72 => ( -- 'H'
            "01100110",
            "01100110",
            "01100110",
            "01111110",
            "01100110",
            "01100110",
            "01100110",
            "00000000"
        ),
        73 => ( -- 'I'
            "00111100",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00111100",
            "00000000"
        ),
        74 => ( -- 'J'
            "00001110",
            "00000110",
            "00000110",
            "00000110",
            "01100110",
            "01100110",
            "00111100",
            "00000000"
        ),
        75 => ( -- 'K'
            "01100110",
            "01101100",
            "01111000",
            "01110000",
            "01111000",
            "01101100",
            "01100110",
            "00000000"
        ),
        76 => ( -- 'L'
            "01100000",
            "01100000",
            "01100000",
            "01100000",
            "01100000",
            "01100000",
            "01111110",
            "00000000"
        ),
        77 => ( -- 'M'
            "01100011",
            "01110111",
            "01111111",
            "01101011",
            "01100011",
            "01100011",
            "01100011",
            "00000000"
        ),
        78 => ( -- 'N'
            "01100110",
            "01110110",
            "01111110",
            "01111110",
            "01101110",
            "01100110",
            "01100110",
            "00000000"
        ),
        79 => ( -- 'O'
            "00111100",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "00111100",
            "00000000"
        ),
        80 => ( -- 'P'
            "01111100",
            "01100110",
            "01100110",
            "01111100",
            "01100000",
            "01100000",
            "01100000",
            "00000000"
        ),
        81 => ( -- 'Q'
            "00111100",
            "01100110",
            "01100110",
            "01100110",
            "01101110",
            "01100110",
            "00111110",
            "00000000"
        ),
        82 => ( -- 'R'
            "01111100",
            "01100110",
            "01100110",
            "01111100",
            "01111000",
            "01101100",
            "01100110",
            "00000000"
        ),
        83 => ( -- 'S'
            "00111100",
            "01100110",
            "01100000",
            "00111100",
            "00000110",
            "01100110",
            "00111100",
            "00000000"
        ),
        84 => ( -- 'T'
            "01111110",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00000000"
        ),
        85 => ( -- 'U'
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "00111100",
            "00000000"
        ),
        86 => ( -- 'V'
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "00111100",
            "00011000",
            "00000000"
        ),
        87 => ( -- 'W'
            "01100011",
            "01100011",
            "01100011",
            "01101011",
            "01111111",
            "01110111",
            "01100011",
            "00000000"
        ),
        88 => ( -- 'X'
            "01100110",
            "01100110",
            "00111100",
            "00011000",
            "00111100",
            "01100110",
            "01100110",
            "00000000"
        ),
        89 => ( -- 'Y'
            "01100110",
            "01100110",
            "01100110",
            "00111100",
            "00011000",
            "00011000",
            "00011000",
            "00000000"
        ),
        90 => ( -- 'Z'
            "01111110",
            "00000110",
            "00001100",
            "00011000",
            "00110000",
            "01100000",
            "01111110",
            "00000000"
        ),
        -- Lowercase letters (ASCII 97-122)
        97 => ( -- 'a'
            "00000000",
            "00000000",
            "00111100",
            "00000110",
            "00111110",
            "01100110",
            "00111110",
            "00000000"
        ),
        98 => ( -- 'b'
            "01100000",
            "01100000",
            "01111100",
            "01100110",
            "01100110",
            "01100110",
            "01111100",
            "00000000"
        ),
        99 => ( -- 'c'
            "00000000",
            "00000000",
            "00111100",
            "01100000",
            "01100000",
            "01100000",
            "00111100",
            "00000000"
        ),
        100 => ( -- 'd'
            "00000110",
            "00000110",
            "00111110",
            "01100110",
            "01100110",
            "01100110",
            "00111110",
            "00000000"
        ),
        101 => ( -- 'e'
            "00000000",
            "00000000",
            "00111100",
            "01100110",
            "01111110",
            "01100000",
            "00111100",
            "00000000"
        ),
        102 => ( -- 'f'
            "00011100",
            "00110000",
            "00110000",
            "01111100",
            "00110000",
            "00110000",
            "00110000",
            "00000000"
        ),
        103 => ( -- 'g'
            "00000000",
            "00111110",
            "01100110",
            "01100110",
            "00111110",
            "00000110",
            "00111100",
            "00000000"
        ),
        104 => ( -- 'h'
            "01100000",
            "01100000",
            "01111100",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "00000000"
        ),
        105 => ( -- 'i'
            "00011000",
            "00000000",
            "00111000",
            "00011000",
            "00011000",
            "00011000",
            "00111100",
            "00000000"
        ),
        106 => ( -- 'j'
            "00000110",
            "00000000",
            "00000110",
            "00000110",
            "00000110",
            "01100110",
            "00111100",
            "00000000"
        ),
        107 => ( -- 'k'
            "01100000",
            "01100000",
            "01100110",
            "01101100",
            "01111000",
            "01101100",
            "01100110",
            "00000000"
        ),
        108 => ( -- 'l'
            "00111000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00111100",
            "00000000"
        ),
        109 => ( -- 'm'
            "00000000",
            "00000000",
            "01100110",
            "01111111",
            "01111111",
            "01101011",
            "01100011",
            "00000000"
        ),
        110 => ( -- 'n'
            "00000000",
            "00000000",
            "01111100",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "00000000"
        ),
        111 => ( -- 'o'
            "00000000",
            "00000000",
            "00111100",
            "01100110",
            "01100110",
            "01100110",
            "00111100",
            "00000000"
        ),
        112 => ( -- 'p'
            "00000000",
            "01111100",
            "01100110",
            "01100110",
            "01111100",
            "01100000",
            "01100000",
            "00000000"
        ),
        113 => ( -- 'q'
            "00000000",
            "00111110",
            "01100110",
            "01100110",
            "00111110",
            "00000110",
            "00000110",
            "00000000"
        ),
        114 => ( -- 'r'
            "00000000",
            "00000000",
            "01111100",
            "01100110",
            "01100000",
            "01100000",
            "01100000",
            "00000000"
        ),
        115 => ( -- 's'
            "00000000",
            "00000000",
            "00111110",
            "01100000",
            "00111100",
            "00000110",
            "01111100",
            "00000000"
        ),
        116 => ( -- 't'
            "00011000",
            "00011000",
            "00111100",
            "00011000",
            "00011000",
            "00011000",
            "00001100",
            "00000000"
        ),
        117 => ( -- 'u'
            "00000000",
            "00000000",
            "01100110",
            "01100110",
            "01100110",
            "01100110",
            "00111110",
            "00000000"
        ),
        118 => ( -- 'v'
            "00000000",
            "00000000",
            "01100110",
            "01100110",
            "01100110",
            "00111100",
            "00011000",
            "00000000"
        ),
        119 => ( -- 'w'
            "00000000",
            "00000000",
            "01100011",
            "01101011",
            "01111111",
            "01110111",
            "01100011",
            "00000000"
        ),
        120 => ( -- 'x'
            "00000000",
            "00000000",
            "01100110",
            "00111100",
            "00011000",
            "00111100",
            "01100110",
            "00000000"
        ),
        121 => ( -- 'y'
            "00000000",
            "00000000",
            "01100110",
            "01100110",
            "00111110",
            "00000110",
            "00111100",
            "00000000"
        ),
        122 => ( -- 'z'
            "00000000",
            "00000000",
            "01111110",
            "00001100",
            "00011000",
            "00110000",
            "01111110",
            "00000000"
        ),
        
        -- Default for other characters
        others => (others => (others => '0'))
    );
    



    -- Function to determine if current pixel is part of a character
    function is_pixel_on(
        char_code : in integer;
        x_offset : in integer;
        y_offset : in integer
    ) return std_logic;
    
    -- Procedure to draw a single character
    procedure draw_char(
        signal x_cur, y_cur : in integer;
        signal x_pos, y_pos : in integer;
        constant char_code : in integer;
        signal rgb : out std_logic_vector(3 downto 0);
        signal draw : out std_logic
    );
    
    -- Procedure to draw a string of text
    procedure draw_string(
        signal x_cur, y_cur : in integer;
        signal x_pos, y_pos : in integer;
        constant text : in string;
        signal rgb : out std_logic_vector(3 downto 0);
        signal draw : out std_logic
    );
    
end package char_rom_uart;

package body char_rom_uart is
    -- Function to determine if a pixel should be on for a given character
    function is_pixel_on(
        char_code : in integer;
        x_offset : in integer;
        y_offset : in integer
    ) return std_logic is
    begin
        -- Check if char_code is in valid range
        if char_code >= 0 and char_code <= 127 and
           x_offset >= 0 and x_offset < 8 and
           y_offset >= 0 and y_offset < 8 then
            -- Check if bit is set in the ROM data
            if ROM_DATA(char_code, y_offset)(7 - x_offset) = '1' then
                return '1';
            else
                return '0';
            end if;
        else
            return '0';
        end if;
    end function;
    
    -- Procedure to draw a single character
    procedure draw_char(
        signal x_cur, y_cur : in integer;
        signal x_pos, y_pos : in integer;
        constant char_code : in integer;
        signal rgb : out std_logic_vector(3 downto 0);
        signal draw : out std_logic
    ) is
        variable x_off : integer;
        variable y_off : integer;
    begin
        -- Check if current pixel position is within character boundaries
        if (x_cur >= x_pos and x_cur < x_pos + CHAR_WIDTH and
            y_cur >= y_pos and y_cur < y_pos + CHAR_HEIGHT) then
            
            x_off := x_cur - x_pos;
            y_off := y_cur - y_pos;
            
            -- Check if this pixel should be on
            if is_pixel_on(char_code, x_off, y_off) = '1' then
                rgb <= "1111"; -- White text
                draw <= '1';
            else
                draw <= '0';
            end if;
        else
            draw <= '0';
        end if;
    end procedure;
    
    -- Procedure to draw a string of text
    procedure draw_string(
        signal x_cur, y_cur : in integer;
        signal x_pos, y_pos : in integer;
        constant text : in string;
        signal rgb : out std_logic_vector(3 downto 0);
        signal draw : out std_logic
    ) is
        variable char_pos_x : integer;
        variable char_code : integer;
        variable x_off : integer;
        variable y_off : integer;
        variable pixel_on : std_logic := '0';
    begin
        draw <= '0';
        
        -- Check each character in the string
        for i in text'range loop
            char_pos_x := x_pos + (i-text'left) * CHAR_WIDTH;
            
            -- Skip if it's a space and not the last character
            if text(i) = ' ' and i /= text'right then
                next;
            end if;
            
            -- Check if current pixel is within this character's bounds
            if (x_cur >= char_pos_x and x_cur < char_pos_x + CHAR_WIDTH and
                y_cur >= y_pos and y_cur < y_pos + CHAR_HEIGHT) then
                
                x_off := x_cur - char_pos_x;
                y_off := y_cur - y_pos;
                char_code := character'pos(text(i));
                
                -- Check if this pixel should be on
                if is_pixel_on(char_code, x_off, y_off) = '1' then
                    rgb <= "1111"; -- White text
                    draw <= '1';
                    exit; -- Found a pixel to draw, no need to check other characters
                end if;
            end if;
        end loop;
    end procedure;
end package body;
