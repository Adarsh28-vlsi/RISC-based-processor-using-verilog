# RISC Processor Architecture

## Overview
This is a 16-bit RISC processor implementation with the following characteristics:
- 16-bit data width
- 8 general-purpose registers (R0-R7)
- Simple instruction set with basic operations
- Harvard architecture (separate instruction and data memory)
- Single-cycle execution for most instructions

## Instruction Set Architecture (ISA)

### Register Set
- 8 general-purpose registers: R0, R1, R2, R3, R4, R5, R6, R7
- R0 is hardwired to zero (read-only)
- Program Counter (PC): 16-bit
- Status Register: flags for zero, carry, overflow

### Instruction Format
16-bit instruction word with the following formats:

#### R-Type (Register operations)
```
[15:12] [11:8] [7:4] [3:0]
 OPCODE  RS1   RS2   RD
```

#### I-Type (Immediate operations)
```
[15:12] [11:8] [7:0]
 OPCODE  RS1   IMM8
```

#### J-Type (Jump operations)
```
[15:12] [11:0]
 OPCODE  ADDR12
```

### Instruction Set

| Opcode | Mnemonic | Type | Description |
|--------|----------|------|-------------|
| 0000   | ADD      | R    | RD = RS1 + RS2 |
| 0001   | SUB      | R    | RD = RS1 - RS2 |
| 0010   | AND      | R    | RD = RS1 & RS2 |
| 0011   | OR       | R    | RD = RS1 \| RS2 |
| 0100   | XOR      | R    | RD = RS1 ^ RS2 |
| 0101   | SLL      | R    | RD = RS1 << RS2[3:0] |
| 0110   | SRL      | R    | RD = RS1 >> RS2[3:0] |
| 0111   | SLT      | R    | RD = (RS1 < RS2) ? 1 : 0 |
| 1000   | ADDI     | I    | RS1 = RS1 + IMM8 |
| 1001   | ANDI     | I    | RS1 = RS1 & {8'b0, IMM8} |
| 1010   | ORI      | I    | RS1 = RS1 \| {8'b0, IMM8} |
| 1011   | LW       | I    | RS1 = MEM[RS1 + IMM8] |
| 1100   | SW       | I    | MEM[RS1 + IMM8] = RS2 |
| 1101   | BEQ      | I    | if (RS1 == 0) PC = PC + IMM8 |
| 1110   | JMP      | J    | PC = ADDR12 |
| 1111   | NOP      | -    | No operation |

## Module Hierarchy

1. **cpu_top** - Top-level CPU module
2. **register_file** - 8x16-bit register bank
3. **alu** - Arithmetic Logic Unit
4. **control_unit** - Instruction decoder and control signals
5. **memory_interface** - Data memory interface
6. **instruction_fetch** - Instruction fetch and PC management

## Memory Map
- Instruction Memory: 0x0000 - 0x0FFF (4KB)
- Data Memory: 0x1000 - 0x1FFF (4KB)