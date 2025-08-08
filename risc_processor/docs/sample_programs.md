# Sample Programs for RISC Processor

This document contains example programs that can be run on the RISC processor.

## Program 1: Basic Arithmetic

```assembly
; Add two numbers and store result
ADDI R1, R1, 16    ; Load 16 into R1
ADDI R2, R2, 32    ; Load 32 into R2  
ADD  R3, R1, R2    ; R3 = R1 + R2 (48)
SW   R3, 0(R0)     ; Store result to memory address 0x1000
NOP                ; No operation
```

**Machine Code:**
```
0x8110  ; ADDI R1, R1, 16
0x8220  ; ADDI R2, R2, 32
0x0123  ; ADD R3, R1, R2
0xC300  ; SW R3, 0(R0)
0xFFFF  ; NOP
```

## Program 2: Logical Operations

```assembly
; Perform logical operations
ADDI R1, R1, 0xFF  ; Load 255 into R1
ADDI R2, R2, 0x0F  ; Load 15 into R2
AND  R3, R1, R2    ; R3 = R1 & R2 (15)
OR   R4, R1, R2    ; R4 = R1 | R2 (255)
XOR  R5, R1, R2    ; R5 = R1 ^ R2 (240)
NOP
```

**Machine Code:**
```
0x81FF  ; ADDI R1, R1, 255
0x820F  ; ADDI R2, R2, 15
0x2123  ; AND R3, R1, R2
0x3124  ; OR R4, R1, R2
0x4125  ; XOR R5, R1, R2
0xFFFF  ; NOP
```

## Program 3: Memory Operations

```assembly
; Store and load from memory
ADDI R1, R1, 100   ; Load 100 into R1
SW   R1, 0(R0)     ; Store R1 to memory[0x1000]
SW   R1, 1(R0)     ; Store R1 to memory[0x1001]
LW   R2, 0(R0)     ; Load from memory[0x1000] to R2
LW   R3, 1(R0)     ; Load from memory[0x1001] to R3
NOP
```

**Machine Code:**
```
0x8164  ; ADDI R1, R1, 100
0xC100  ; SW R1, 0(R0)
0xC101  ; SW R1, 1(R0)
0xB200  ; LW R2, 0(R0)
0xB301  ; LW R3, 1(R0)
0xFFFF  ; NOP
```

## Program 4: Control Flow

```assembly
; Jump and branch example
ADDI R1, R1, 5     ; Load 5 into R1
JMP  10            ; Jump to address 10
ADDI R2, R2, 99    ; This should be skipped
NOP
; Address 10:
ADDI R3, R3, 42    ; Load 42 into R3
SUB  R4, R1, R1    ; R4 = R1 - R1 (0)
BEQ  R4, 2         ; Branch if R4 == 0 (branch by 2)
ADDI R5, R5, 1     ; This should be skipped
; Branch target:
ADDI R6, R6, 77    ; Load 77 into R6
NOP
```

**Machine Code:**
```
0x8105  ; ADDI R1, R1, 5      (Address 0)
0xE00A  ; JMP 10              (Address 1)
0x8263  ; ADDI R2, R2, 99     (Address 2) - Skipped
0xFFFF  ; NOP                 (Address 3)
0xFFFF  ; NOP                 (Address 4)
0xFFFF  ; NOP                 (Address 5)
0xFFFF  ; NOP                 (Address 6)
0xFFFF  ; NOP                 (Address 7)
0xFFFF  ; NOP                 (Address 8)
0xFFFF  ; NOP                 (Address 9)
0x832A  ; ADDI R3, R3, 42     (Address 10)
0x1114  ; SUB R4, R1, R1      (Address 11)
0xD402  ; BEQ R4, 2           (Address 12)
0x8501  ; ADDI R5, R5, 1      (Address 13) - Skipped
0x864D  ; ADDI R6, R6, 77     (Address 14) - Branch target
0xFFFF  ; NOP                 (Address 15)
```

## Program 5: Fibonacci Sequence (First 5 numbers)

```assembly
; Calculate first 5 Fibonacci numbers
ADDI R1, R1, 0     ; F(0) = 0
ADDI R2, R2, 1     ; F(1) = 1
SW   R1, 0(R0)     ; Store F(0)
SW   R2, 1(R0)     ; Store F(1)

ADD  R3, R1, R2    ; F(2) = F(0) + F(1) = 1
SW   R3, 2(R0)     ; Store F(2)

ADD  R4, R2, R3    ; F(3) = F(1) + F(2) = 2
SW   R4, 3(R0)     ; Store F(3)

ADD  R5, R3, R4    ; F(4) = F(2) + F(3) = 3
SW   R5, 4(R0)     ; Store F(4)

NOP
```

**Machine Code:**
```
0x8100  ; ADDI R1, R1, 0
0x8201  ; ADDI R2, R2, 1
0xC100  ; SW R1, 0(R0)
0xC201  ; SW R2, 1(R0)
0x0123  ; ADD R3, R1, R2
0xC302  ; SW R3, 2(R0)
0x0234  ; ADD R4, R2, R3
0xC403  ; SW R4, 3(R0)
0x0345  ; ADD R5, R3, R4
0xC504  ; SW R5, 4(R0)
0xFFFF  ; NOP
```

## Instruction Format Reference

### R-Type Instructions (Register-Register)
```
[15:12] [11:9] [8:6] [5:3] [2:0]
OPCODE   RS1   RS2   RD   000
```

### I-Type Instructions (Immediate)
```
[15:12] [11:9] [8:0]
OPCODE   RS1   IMM8
```

### J-Type Instructions (Jump)
```
[15:12] [11:0]
OPCODE  ADDR12
```

## Memory Map
- **Instruction Memory**: 0x0000 - 0x0FFF
- **Data Memory**: 0x1000 - 0x1FFF
- **Register File**: R0 (always 0), R1-R7 (general purpose)