# Quartus FPGA Project: text1one

This repository contains the Quartus project files for the `text1one` FPGA design, targeting the DE10-Lite development board. The project includes UART communication, VGA output, and supporting modules for embedded systems experimentation.

## Project Structure

- **DE10_LITE_Golden_Top.v**: Top-level Verilog module for the DE10-Lite board.
- **UART_VGA.vhd**: Main VHDL module for UART to VGA interfacing.
- **UART_VGA_tb.vhd**: Testbench for UART_VGA module.
- **char_rom_uart.vhd**: Character ROM and UART logic.
- **SYNC_UART.vhd**: Synchronous UART module.
- **RX.vhd / TX.vhd**: UART receiver and transmitter modules.
- **PLL/**: Phase-Locked Loop (PLL) IP core and related files.
- **simulation/**: ModelSim simulation scripts and outputs.
- **output_files/**: Quartus-generated output files (bitstreams, reports, etc.).
- **db/**, **incremental_db/**: Quartus build and incremental compilation databases.
- **report/**: Project reports and documentation.

## Getting Started

### Prerequisites
- [Intel Quartus Prime](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html) (Lite or Standard Edition)
- [ModelSim](https://www.intel.com/content/www/us/en/software/programmable/modelsim/overview.html) (for simulation)
- DE10-Lite FPGA development board

### Building the Project
1. Clone this repository:
   ```sh
git clone https://github.com/yourusername/text1one.git
cd text1one
```
2. Open `text1one.qpf` in Quartus Prime.
3. Compile the project (Processing > Start Compilation).
4. Program the DE10-Lite board with the generated `.sof` file from the `output_files/` directory.

### Simulation
- Use the ModelSim scripts in `simulation/modelsim/` to run VHDL simulations.

## File Descriptions
- `.qpf`, `.qsf`, `.qws`, `.qdf`: Quartus project, settings, and assignment files.
- `.vhd`, `.v`: VHDL and Verilog source files.
- `.sof`, `.pof`: FPGA programming files (output).
- `.rpt`, `.summary`: Compilation and analysis reports.

## License
Specify your license here (e.g., MIT, GPL, etc.).

## Author
- Your Name (your.email@example.com)

---
*This README was auto-generated for GitHub documentation purposes.* 