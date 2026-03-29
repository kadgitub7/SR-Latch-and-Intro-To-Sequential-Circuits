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
