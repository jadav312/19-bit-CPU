# 19-bit Custom CPU

A custom-designed 19-bit CPU built using basic hardware modules including a Program Counter, Instruction Memory, Instruction Register, ALU, Control Unit, Register File, Data Memory, and a top-level integration module.

## Overview

This project implements a custom CPU with a 19-bit wide architecture. The CPU is built from the ground up with modular components and is designed for instructional and experimental purposes. It supports basic instruction execution including arithmetic and memory operations. The design now includes a top-level module, testbench, and simulation results.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Modules](#modules)
- [Instruction Format](#instruction-format)
- [Top Module Integration](#top-module-integration)
- [Simulation Results](#simulation-results)

## Architecture

The CPU follows a basic fetch-decode-execute-writeback-memory cycle. It is designed with a focus on modularity and ease of understanding. All modules interact via a central control unit that decodes opcodes and manages control signals.

## Modules

### Program Counter (PC)
- Holds the address of the current instruction.
- Can increment sequentially or jump to a new address based on control signals.

### Instruction Memory
- Stores the program instructions.
- Provides the current instruction to the Instruction Register based on the PC.

### Instruction Register
- Latches the fetched instruction for decoding and execution.

### ALU (Arithmetic Logic Unit)
- Performs arithmetic and logical operations.
- Supports operations like ADD, SUB, AND, OR, NOT, etc.

### Control Unit
- Decodes the opcode of the instruction.
- Generates control signals for each module.

### Register File
- Contains a set of general-purpose registers.
- Supports read and write operations to/from registers.

### Data Memory
- Handles load and store operations for reading/writing data.

## Instruction Format

The instruction is 19 bits wide and typically divided as:
[18:15] Opcode | [14:11] rs1 | [10:7] rs2 | [6:3] rd | [2:0] immediate/branch offset (varies by instruction)

## Top Module Integration

A top-level module integrates all the submodules and controls the data flow and timing. It connects:

- Program Counter to Instruction Memory
- Instruction Register to Control Unit
- ALU, Register File, and Data Memory via multiplexers
- Control Unit to all modules through control signals

## Simulation Results

A testbench (`top_tb.v`) was created to verify the CPU’s functionality.

### Instructions Simulated:
- **ADD**: Adds values from two registers and stores in a destination register.
- **SUB**: Subtracts the value of one register from another.
- **LOAD**: Loads data from memory into a register.
- **STORE**: Stores data from a register into memory.

### Observations:
- All instructions execute correctly in simulation.
- Waveform output confirms correct timing and control behavior.
- Registers and memory reflect expected values post-execution.
