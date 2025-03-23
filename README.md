# Hash Function in MIPS Assembly

![MIPS](https://img.shields.io/badge/Assembly-MIPS-green) ![License](https://img.shields.io/badge/License-MIT-blue)

This repository contains a MIPS assembly implementation of a custom hash function. The program processes an input word and computes a hash value using a series of arithmetic and logical operations. The result is stored in memory and returned to the caller.

---

## Table of Contents
1. [Overview](#overview)
2. [Code Structure](#code-structure)
3. [Registers Used](#registers-used)
4. [Key Steps in the Hash Function](#key-steps-in-the-hash-function)
5. [Memory Usage](#memory-usage)
6. [How to Run the Code](#how-to-run-the-code)
7. [Example Input and Output](#example-input-and-output)

---

## Overview
This MIPS assembly program implements a custom hash function. The function processes an input word and computes a hash value based on a series of arithmetic and logical operations. The result is stored in memory and returned to the caller.

---

## Code Structure

### **Main Function**
- The program starts at the `main` label.
- It reads an input word from memory, processes it, and calls the `hash_fn` function to compute the hash.
- After computing the hash, the program terminates.

### **Hash Function (`hash_fn`)**
- The hash function performs the following steps:
  1. Masks the input word to extract specific bits.
  2. Computes a series of arithmetic operations (addition, subtraction, and XOR) to generate intermediate values.
  3. Combines these values to produce the final hash result.
  4. Stores the result in memory and returns it to the caller.

---

## Registers Used
- **Input Registers:**
  - `$a0`, `$a1`: Arguments passed to the program.
  - `$s2`: Contains the input word.
- **Temporary Registers:**
  - `$t0` to `$t7`: Used for intermediate calculations.
- **Counter Registers:**
  - `$s0`, `$s1`: Used for loop counters.
- **Result Registers:**
  - `$t1`, `$t4`, `$t5`, `$t6`: Store intermediate and final results.
  - `$s0`, `$v0`: Store the final hash result.

---

## Key Steps in the Hash Function
1. **Masking:**
   - The input word is masked to extract specific bits using a predefined mask (`$t0`).
2. **XOR Operation:**
   - The masked value is XORed with an initial value (`$t1`).
3. **Arithmetic Operations:**
   - A series of additions, subtractions, and multiplications are performed to compute intermediate values.
4. **Looping:**
   - Several loops are used to iterate over the input and compute the final hash.
5. **Final Result:**
   - The final hash value is masked to 8 bits and stored in memory.

---

## Memory Usage
- The final hash result is stored at memory address `0x10010000`.

---

## How to Run the Code
1. **Assemble the Code:**
   - Use a MIPS assembler (e.g., `SPIM` or `MARS`) to assemble the code.
   - Example:
     ```bash
     java -jar mars.jar hash_function.asm
     ```

2. **Provide Input:**
   - Ensure the input word is stored in memory at the address specified in `$a1`.

3. **Run the Program:**
   - Execute the program in the simulator.
   - The final hash result will be stored at memory address `0x10010000`.

---

## Example Input and Output
- **Input:**
  - Assume the input word is `1234` (stored in memory).
- **Output:**
  - The computed hash value will be stored at `0x10010000`.

---
