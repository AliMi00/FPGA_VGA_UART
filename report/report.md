For the final assignment I chose to do a custom assignment so I could add it to my resume and get higher grade. 
My final assignment is a VGA with UART to show text that is received from UART on the screen using generated VGA signal and the text could be moved on the screen. 

I chose VGA since it is an analog signal and UART since it is digital in order to cover Analog and Digital.  I avoid using NIOS II since I wanted to implement it in FPGA and VHDL. 

First, I started studying the VGA signal and how they work after I had good understanding of VGA; I started with implementation of higher level of VGA component.

I decided to do each part separately first and as separate module and by keeping in mind that I have to combine them together later. In this way I was able to test each part separately and also reuse this if I needed them in my hobby projects.

## Development of VGA module
I started with VGA. My first goal was to drawing box on screen then implemented a movement on screen with push buttons. 

### Clock generation
First, I needed to calculate the clock and a way to generate that from 50MHz signal of the my FPGA.  After searching on the internet and some calculations The standard 1080p@60Hz requires a pixel clock of 148.5 MHz. To convert the max10 50MHz signal to 148.5MHz; I created a custom IP using Intel's PLL in platform designer.

### VGA controller
After setting up the clock I implemented the VGA sync signals generator. For 1080p resolution I needed specific timing parameters:
- Horizontal: 1920 pixels + blanking intervals
- Vertical: 1080 lines + blanking intervals  
- Total horizontal period: 2200 pixels
- Total vertical period: 1125 lines

The SYNC_UART.vhd component generates the HSYNC and VSYNC signals by counting pixel positions. HSYNC goes low from pixel 88 to 132, and VSYNC goes low from line 0 to 5. This creates the proper timing for 1080p display.

### Character ROM and text rendering
One of the most challenging parts was implementing text display. I created a character ROM (char_rom_uart.vhd) that stores 8x8 pixel bitmap patterns for ASCII characters. Each character is represented as an array of 8 bytes, where each bit represents a pixel.

The character ROM includes:
- Numbers 0-9
- Letters A-Z (both uppercase and lowercase)  
- Special character space
- Each character is 8x8 pixels for simplicity

For text rendering I implemented a DRAW_TEXT procedure that:
1. Takes the current pixel position and text position
2. Calculates which character to display
3. Looks up the character pattern in ROM
4. Sets the RGB output based on the pixel pattern

## UART Implementation
After getting VGA working I moved to UART communication. I needed both transmitter and receiver modules.

### UART Transmitter (TX.vhd)
The TX module sends 8-bit data over serial line with standard UART format:
- Start bit (0)
- 8 data bits
- Stop bit (1)
- Baud rate of 9600 (calculated from 50MHz clock with prescaler)

The prescaler divides 50MHz down to 9600 baud: 50,000,000 / 9600 = 5208 clock cycles per bit.

### UART Receiver (RX.vhd)  
The RX module receives data and detects:
- Start bit falling edge to begin reception
- Samples data bits at middle of bit period
- Validates stop bit
- Outputs received byte and busy flag

### Text buffer management
I implemented a 16-character text buffer to store received UART data. When new characters arrive they get added to the buffer and displayed on screen. The buffer can be reset with KEY[1].

## Integration and final system
The top-level UART_VGA.vhd connects everything together:
- PLL generates 148.5MHz VGA clock from 50MHz
- UART TX/RX connected to GPIO pins for external communication
- VGA controller displays the text buffer contents
- Push buttons control text movement on screen
- Switches control text color (red or white)

### Control interface
- KEY[0]: Send data via UART TX (data from SW[7:0])
- KEY[1]: Reset text buffer  
- KEY[2]: Move text up
- KEY[3]: Move text down
- SW[0]: Change text color (red/white)
- SW[7:0]: Data to transmit when KEY[0] pressed

## Testing and verification
I created a testbench (UART_VGA_tb.vhd) to verify the functionality. Testing included:
- VGA timing signal verification
- UART transmission and reception
- Text buffer operations
- Character ROM lookup

The system works as expected - text received via UART appears on the VGA display and can be moved around using the push buttons.

## Challenges and solutions
1. **Clock domain crossing**: VGA runs at 148.5MHz while UART at 50MHz. Solved by proper clock domain isolation.

2. **Character encoding**: Converting received ASCII bytes to displayable characters. Used VHDL character'val() function.

3. **VGA timing**: Getting exact timing for 1080p was critical. Used online calculators and datasheets to verify parameters.

4. **Text positioning**: Calculating pixel positions for character placement required careful coordinate math.

## Results and conclusion
The final system successfully displays UART-received text on a VGA monitor at 1080p resolution. Text can be moved around the screen with push buttons and color can be changed with switches. This project gave me deep understanding of both analog VGA signaling and digital UART communication, all implemented in pure VHDL without using soft processors.

The modular design makes components reusable for future projects. I'm satisfied with the result and learned a lot about FPGA development and signal timing.




