# Introduction to Sequential Circuits

> **Important:** Sequential circuits are different from combinational circuits in that their present output is dependent on **current inputs and past outputs**, which is different from combinational circuits where the present output is only dependent on present input.

---

## Overview

Sequential circuits take input and store the output in **memory**. This memory is then fed back into the circuit as an additional input in the next cycle.

This process is called **feedback** — past outputs are retrieved from memory and passed as input into the next cycle. As a result, values are accumulated or changed over time.

The only component that distinguishes sequential circuits from combinational circuits is the **memory and feedback element**. The solution to implementing this is the use of **flip-flops**.

---

## How Feedback Works

```
        ┌─────────────────────┐
        │                     │
Input ──►   Combinational   ──►── Output
        │      Logic          │
        │                     │
        │          ▲          │
        └──────────┼──────────┘
                   │
               Memory
             (Flip-Flop)
```
![Sequential Circuit](/SequentialCircuitDiagram.png)
1. The circuit receives an **input**.
2. The output is computed and sent forward.
3. The output is also **stored in memory** (a flip-flop).
4. On the next clock cycle, the stored value is fed back in as an **additional input**.
5. This repeats, allowing the circuit to "remember" past states.

---

## Types of Sequential Circuits

- **Flip-Flops** — The fundamental memory element; stores a single bit.
- **Latches** — Level-sensitive storage elements; similar to flip-flops but not clock-driven.
- **Counters** — Circuits that cycle through a sequence of states, built from flip-flops.

---

## Storing a Single Bit: The First Idea

To store a single bit value, the earliest idea was to connect **two NOT gates in series**:

```
     ┌──[NOT]──[NOT]──┐
     │                │
     └────────────────┘
```

The bit is stored as it is inputted into this feedback loop — the two inversions cancel out, holding the value stable. This concept laid the groundwork for the development of latches and flip-flops.

---

## Key Terminology

| Term | Definition |
|---|---|
| **Sequential Circuit** | A circuit whose output depends on current inputs *and* past outputs (stored state). |
| **Combinational Circuit** | A circuit whose output depends only on current inputs. |
| **Feedback** | The process of routing a circuit's output back as an input in the next cycle. |
| **Flip-Flop** | A bistable memory element used to store one bit of data. |
| **Latch** | A level-sensitive storage element, a precursor to the flip-flop. |
| **Counter** | A sequential circuit that progresses through a defined sequence of states. |

---

## Summary

Sequential circuits extend combinational logic by introducing **memory and feedback**. This allows circuits to track state over time, which is essential for building complex digital systems like registers, processors, and state machines. The key building block enabling this is the **flip-flop**, which evolved from the simple idea of using two NOT gates in series to hold a bit in place.

# SR Latch Using NOR Gates | Verilog

![Language](https://img.shields.io/badge/Language-Verilog-blue)
![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red)
![Type](https://img.shields.io/badge/Type-Sequential%20Logic-green)
![Status](https://img.shields.io/badge/Simulation-Passing-brightgreen)

A Verilog implementation of an **SR Latch using NOR Gates**, designed and simulated in **Xilinx Vivado**.

This document explains:
- What a latch is and why it is the fundamental storage element
- The two types of latches and how NOR-based SR latches work
- Truth table derivation, case analysis, and implementation details
- Simulation results verifying correct set, reset, and memory behavior

The project includes the RTL design, testbench, and console-style output verifying correct behavior.

---

## Table of Contents

1. [What Is a Latch?](#what-is-a-latch)
2. [Types of Latches](#types-of-latches)
3. [NOR Gate Truth Table](#nor-gate-truth-table)
4. [How the SR Latch Works](#how-the-sr-latch-works)
5. [SR Latch Truth Table](#sr-latch-truth-table)
6. [Case Analysis](#case-analysis)
7. [Verilog Implementation](#verilog-implementation)
8. [Testbench](#testbench)
9. [Testbench Output](#testbench-output)
10. [Waveform Diagram](#waveform-diagram)
11. [Running the Project in Vivado](#running-the-project-in-vivado)
12. [Project Files](#project-files)

---

## What Is a Latch?

A **latch** is the most fundamental storage element in digital logic. It **latches** — or stores — a single binary value: `0` or `1`.

Unlike combinational circuits whose outputs depend solely on current inputs, a latch is a **sequential circuit**: its output depends on both the current input and the previously stored state. This feedback loop is what gives the latch its memory.

> **Key idea:** To control *when* a latch stores a value (rather than just reacting to signals), a clock signal can be added. Without clocking, the latch responds directly to input changes.

In this circuit:
- **R = Reset** → forces output `Q = 0`
- **S = Set** → forces output `Q = 1`
- **Q'** (Qcom) is the complement of Q

---

## Types of Latches

There are two common types of SR latches, distinguished by the gate used:

1. **NOR Latch** — built from NOR gates; active-high inputs (S=1 sets, R=1 resets)
2. **NAND Latch** — built from NAND gates; active-low inputs (S=0 sets, R=0 resets)

Both types store a bit using cross-coupled feedback, but their forbidden states and active logic levels differ.

---

## NOR Gate Truth Table

| A | B | Y |
|:-:|:-:|:-:|
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 0 |

> **NOR behavior:** The output is `1` only when **both** inputs are `0`. If either input is `1`, the output is forced to `0`. This property is the foundation of the SR latch's reset behavior.

---

## How the SR Latch Works

The NOR SR latch uses two cross-coupled NOR gates:

- The output of the first NOR gate (`Q`) feeds back into the second NOR gate
- The output of the second NOR gate (`Q'`) feeds back into the first NOR gate

This feedback creates a stable state that persists even after the inputs return to `0`, implementing memory.

**Key rule:** If `R = 1`, regardless of the feedback from `Q'`, the output of the top NOR gate is forced to `0`. This is because any input of `1` to a NOR gate drives its output low.

---

## SR Latch Truth Table

| R | S | Q  | Q'     |
|:-:|:-:|:--:|:------:|
| 0 | 0 | Memory | Memory |
| 1 | 0 | 0  | 1      |
| 0 | 1 | 1  | 0      |
| 1 | 1 | 0  | 0      |

> **Note:** The `R=1, S=1` state is **forbidden**. It forces both `Q` and `Q'` to `0` simultaneously, violating the complementary relationship between the outputs. The resulting state when inputs return to `0,0` is also unpredictable.

---

## Case Analysis

The following cases illustrate sequential operation of the latch. In each case, the inputs are applied one after another.

### Case 1 — Reset, then Memory

```
R = 1, S = 0  →  Q = 0, Q' = 1   (Reset: latch is cleared)
R = 0, S = 0  →  Q = 0, Q' = 1   (Memory: output is retained)
```

After removing the reset signal (`R` returns to `0`), both inputs are `0` — this is the **memory condition**. The stored value (`Q = 0`) persists unchanged due to the feedback loop.

### Case 2 — Set, then Memory

```
R = 0, S = 1  →  Q = 1, Q' = 0   (Set: latch is loaded)
R = 0, S = 0  →  Q = 1, Q' = 0   (Memory: output is retained)
```

After setting the latch, returning to `R=0, S=0` again enters the memory condition. The stored value (`Q = 1`) is retained.

### Case 3 — Forbidden State ⚠️

```
R = 1, S = 1  →  Q = 0, Q' = 0   (INVALID)
```

Both outputs are driven to `0` simultaneously, breaking the complementary invariant (`Q ≠ Q'`). If the inputs then transition to `R=0, S=0`, the final state is **indeterminate** — it depends on the propagation delays of the individual gates. This configuration must be avoided in practice.

---

## Verilog Implementation

```verilog
`timescale 1ns / 1ps

module SRLatch(
    input  R,
    input  S,
    output Q,
    output Qcom
    );

    assign Q    = ~(R | Qcom);
    assign Qcom = ~(S | Q);

endmodule
```

The two `assign` statements model the cross-coupled NOR gates directly. Each output is the NOR of an external input and the other output, creating the feedback loop that gives the latch its memory.

---

## Testbench

```verilog
`timescale 1ns / 1ps

module SRLatch_tb();

    reg  R, S;
    wire Q, Qcom;

    reg prev_Q;

    SRLatch uut(R, S, Q, Qcom);

    initial begin
        $monitor("Time=%0t | R=%b S=%b | Q=%b Qcom=%b", $time, R, S, Q, Qcom);

        R = 0; S = 0;
        #10;

        S = 1; R = 0;
        #10;

        prev_Q = Q;

        S = 0; R = 0;
        #10;

        if (Q === prev_Q)
            $display("PASS: Memory retained. Q stayed at %b", Q);
        else
            $display("FAIL: Memory lost. Q changed to %b", Q);

        R = 1; S = 0;
        #10;

        prev_Q = Q;

        R = 0; S = 0;
        #10;

        if (Q === prev_Q)
            $display("PASS: Memory retained after reset. Q=%b", Q);
        else
            $display("FAIL: Memory lost after reset. Q=%b", Q);

        $finish;
    end
endmodule
```

The testbench verifies three behaviors in sequence:
1. **Set** — drives `S=1` and confirms `Q` goes high
2. **Memory after set** — returns to `R=0, S=0` and checks that `Q` stays high
3. **Reset and memory** — drives `R=1` to clear the latch, then confirms `Q` stays low after returning to `R=0, S=0`

---

## Testbench Output

Console output confirming correct SR latch behavior:

```
Time=0     | R=0 S=0 | Q=x Qcom=x
Time=10000 | R=0 S=1 | Q=1 Qcom=0
Time=20000 | R=0 S=0 | Q=1 Qcom=0
PASS: Memory retained. Q stayed at 1
Time=30000 | R=1 S=0 | Q=0 Qcom=1
Time=40000 | R=0 S=0 | Q=0 Qcom=1
PASS: Memory retained after reset. Q=0
```

**Verification summary:**
- At `Time=0`, `Q` is unknown (`x`) — no inputs have been applied yet
- At `Time=10000`, setting `S=1` drives `Q=1` and `Qcom=0`
- At `Time=20000`, returning to `R=0, S=0` retains `Q=1` — memory confirmed
- At `Time=30000`, `R=1` resets the latch to `Q=0`
- At `Time=40000`, returning to `R=0, S=0` retains `Q=0` — memory after reset confirmed

---

## Waveform Diagram

Below is the waveform diagram captured when running the simulation using the files in this project:

![SR Latch Waveform](/imageAssets/SRLatchWaveform.png)

---

## Running the Project in Vivado

### 1. Launch Vivado

Open **Xilinx Vivado**.

### 2. Create a New RTL Project

1. Click **Create Project**
2. Select **RTL Project**
3. Optionally enable *Do not specify sources at this time*, or add source files directly

### 3. Add Source Files

| Role              | File              |
|-------------------|-------------------|
| Design Source     | `SRLatch.v`       |
| Simulation Source | `SRLatch_tb.v`    |

> Set `SRLatch_tb.v` as the **simulation top module**.

### 4. Run Behavioral Simulation

Navigate to:

```
Flow → Run Simulation → Run Behavioral Simulation
```

Observe the signals in the waveform viewer:

```
Inputs : R, S
Outputs: Q, Qcom
```

Verify that the waveform output matches the truth table and the console output listed above.

---

## Project Files

| File           | Description                                                                          |
|----------------|--------------------------------------------------------------------------------------|
| `SRLatch.v`    | Cross-coupled NOR gate SR latch RTL module                                           |
| `SRLatch_tb.v` | Testbench — verifies set, reset, and memory retention with pass/fail display output  |

---

## Author

**Kadhir Ponnambalam**

---

*Designed and simulated using Xilinx Vivado.*
