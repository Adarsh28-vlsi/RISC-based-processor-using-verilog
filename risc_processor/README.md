# RISC Processor in Verilog

A complete 16-bit RISC (Reduced Instruction Set Computer) processor implementation in Verilog HDL.

## Current Status

✅ **COMPLETED**: Full RISC processor implementation with working simulation
- All major components implemented and integrated
- Comprehensive testbench with automated verification  
- Complete instruction set architecture
- Successful compilation and simulation
- Sample programs and documentation

## Overview

This project implements a simple yet functional 16-bit RISC processor with the following features:

- **16-bit data width** with 8 general-purpose registers
- **Harvard architecture** (separate instruction and data memory)
- **Single-cycle execution** for most instructions
- **Complete instruction set** including arithmetic, logical, memory, and control flow operations
- **Comprehensive testbench** with automated verification
- **Sample programs** demonstrating processor capabilities

## Architecture

### Key Components

1. **CPU Top Level** (`cpu_top.v`) - Main processor integration
2. **Register File** (`register_file.v`) - 8×16-bit register bank
3. **ALU** (`alu.v`) - Arithmetic and Logic Unit
4. **Control Unit** (`control_unit.v`) - Instruction decoder
5. **Memory Interface** (`memory_interface.v`) - Data memory controller
6. **Instruction Fetch** (`instruction_fetch.v`) - Program counter and instruction memory

### Register Set

- **R0**: Hardwired to zero (read-only)
- **R1-R7**: General-purpose registers
- **PC**: 16-bit Program Counter
- **Status Flags**: Zero, Carry, Overflow

### Memory Map

- **Instruction Memory**: 0x0000 - 0x0FFF (4KB)
- **Data Memory**: 0x1000 - 0x1FFF (4KB)

## Instruction Set

The processor supports 16 different instruction types:

### Arithmetic Instructions
- `ADD` - Add two registers
- `SUB` - Subtract two registers
- `ADDI` - Add immediate to register

### Logical Instructions
- `AND` - Bitwise AND
- `OR` - Bitwise OR
- `XOR` - Bitwise XOR
- `ANDI` - AND with immediate
- `ORI` - OR with immediate

### Shift Instructions
- `SLL` - Shift left logical
- `SRL` - Shift right logical

### Comparison
- `SLT` - Set if less than

### Memory Instructions
- `LW` - Load word from memory
- `SW` - Store word to memory

### Control Flow
- `BEQ` - Branch if equal to zero
- `JMP` - Unconditional jump
- `NOP` - No operation

## Project Structure

```
risc_processor/
├── src/                    # Verilog source files
│   ├── cpu_top.v          # Top-level CPU module
│   ├── register_file.v    # Register file implementation
│   ├── alu.v              # Arithmetic Logic Unit
│   ├── control_unit.v     # Instruction decoder
│   ├── memory_interface.v # Memory controller
│   └── instruction_fetch.v # Instruction fetch unit
├── testbench/             # Test files
│   └── cpu_testbench.v    # Comprehensive testbench
├── scripts/               # Simulation scripts
│   └── run_simulation.sh  # Automated simulation script
└── docs/                  # Documentation
    ├── architecture.md    # Detailed architecture
    └── sample_programs.md # Example programs
```

## Getting Started

### Prerequisites

- **Icarus Verilog** (`iverilog`) - For compilation and simulation
- **GTKWave** (optional) - For waveform viewing
- **Bash** - For running simulation scripts

### Installation on Ubuntu/Debian

```bash
sudo apt-get update
sudo apt-get install iverilog gtkwave
```

### Running the Simulation

1. Navigate to the scripts directory:
```bash
cd risc_processor/scripts
```

2. Run the simulation script:
```bash
./run_simulation.sh
```

3. View results:
- Console output shows test results
- VCD file generated for waveform analysis: `simulation/cpu_simulation.vcd`

### Viewing Waveforms

```bash
cd simulation
gtkwave cpu_simulation.vcd
```

## Sample Programs

The project includes several sample programs demonstrating different processor features:

1. **Basic Arithmetic** - Addition and basic operations
2. **Logical Operations** - AND, OR, XOR operations
3. **Memory Operations** - Load and store instructions
4. **Control Flow** - Jumps and branches
5. **Fibonacci Sequence** - More complex algorithm

See `docs/sample_programs.md` for complete program listings and machine code.

## Testing

The testbench (`cpu_testbench.v`) provides comprehensive testing including:

- **Instruction Verification** - Tests each instruction type
- **Register Operations** - Validates register file functionality
- **Memory Testing** - Verifies load/store operations
- **Control Flow** - Tests jumps and branches
- **Flag Generation** - Checks ALU flag outputs

### Test Results

The simulation automatically verifies:
- ✅ Register file read/write operations
- ✅ ALU arithmetic and logical operations
- ✅ Memory load/store functionality
- ✅ Control flow (jumps and branches)
- ✅ Instruction decoding and execution

## Customization

### Adding New Instructions

1. Update the opcode definitions in `control_unit.v`
2. Add ALU operations in `alu.v` if needed
3. Modify the control logic in `control_unit.v`
4. Update documentation and tests

### Expanding Memory

- Modify memory array sizes in `memory_interface.v` and `instruction_fetch.v`
- Update address decoding logic
- Adjust memory map documentation

### Register Set Changes

- Modify register array size in `register_file.v`
- Update address bit widths throughout the design
- Adjust instruction formats if needed

## Known Limitations

- Single-cycle execution (no pipelining)
- Limited to 16-bit data width
- Simple memory model (no cache)
- No interrupt handling
- No floating-point operations

## Future Enhancements

- Pipeline implementation for better performance
- Cache memory subsystem
- Interrupt and exception handling
- Floating-point unit
- More sophisticated branch prediction
- UART communication interface

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is open source and available under the MIT License.

## References

- Computer Organization and Design by Patterson & Hennessy
- Digital Design and Computer Architecture by Harris & Harris
- Verilog HDL: A Guide to Digital Design and Synthesis by Palnitkar