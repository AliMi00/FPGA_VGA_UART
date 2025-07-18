library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.char_rom_uart.all;

PACKAGE MY_UART IS
PROCEDURE SQ(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER;SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC);
PROCEDURE DRAW_TEXT(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER; CONSTANT text:IN STRING; SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC);
END MY_UART;

PACKAGE BODY MY_UART IS
PROCEDURE SQ(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER;SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC) IS
BEGIN
 IF(Xcur>Xpos AND Xcur<(Xpos+100) AND Ycur>Ypos AND Ycur<(Ypos+100))THEN
     RGB<="1111";
     DRAW<='1';
     ELSE
     DRAW<='0';
 END IF;
END SQ;

PROCEDURE DRAW_TEXT(SIGNAL Xcur,Ycur,Xpos,Ypos:IN INTEGER; CONSTANT text:IN STRING; SIGNAL RGB:OUT STD_LOGIC_VECTOR(3 downto 0);SIGNAL DRAW: OUT STD_LOGIC) IS
BEGIN
    -- Call the draw_string procedure from the char_rom_uart package
    draw_string(Xcur, Ycur, Xpos, Ypos, text, RGB, DRAW);
END DRAW_TEXT;

END MY_UART;
