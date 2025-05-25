# 19-bit Custom CPU

A custom-designed 19-bit CPU built using basic hardware modules including a Program Counter, Instruction Memory, Instruction Register, ALU, Control Unit, and Data Memory.

## 🧠 Overview

This project implements a custom CPU with a 19-bit wide architecture. The CPU is built from the ground up with modular components and is designed for instructional and experimental purposes. It supports basic instruction execution.
## 🗂️ Table of Contents
- [Overview](#-overview)
- [Architecture](#-architecture)
- [Modules](#-modules)
- [Instruction Format](#-instruction-format)
- [How to Run](#-how-to-run)
- [Future Improvements](#-future-improvements)
- [License](#license)

## 🏗️ Architecture

The CPU follows a basic fetch-execute-writebl-memory cycle. It is designed with a focus on modularity and ease of understanding. All modules interact via a central control unit that decodes opcodes and manages control signals.

## 🔧 Modules

### 📍 Program Counter (PC)
- Holds the address of the current instruction.
- Can increment sequentially or jump to a new address based on control signals.

### 📥 Instruction Memory
- Stores the program instructions.
- Provides the current instruction to the Instruction Register based on the PC.

### 📄 Instruction Register
- Latches the fetched instruction for decoding and execution.

### ⚙️ ALU (Arithmetic Logic Unit)
- Performs arithmetic and logical operations.
- Supports operations like ADD, SUB, AND, OR, NOT, etc.

### 🧭 Control Unit
- Decodes the opcode of the instruction.
- Generates control signals for each module.

### 💾 Data Memory
- Handles load and store operations for reading/writing data.

## 🧾 Instruction Format

The instruction is 19 bits wide and typically divided as: [4:O]opcode, [3:0] rs1, rs2, rd, [13:0] addr_imm (address for immediate field), [5:0] branch offset

