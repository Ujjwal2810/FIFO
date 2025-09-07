# 🚀 Simple FIFO in Verilog

A simple **FIFO (First-In First-Out) buffer** implementation in Verilog with a testbench and simulation waveforms.  
This project demonstrates how a circular buffer works in hardware, including **write/read operations, full/empty flags, and edge-case handling**.

---

## 📂 Project Structure
├── fifo.v # FIFO RTL implementation
├── tb_fifo.v # Testbench
├── README.md # Project documentation
├── screenshots/ # Simulation waveforms
│ ├── fifo_waveform.png
│ ├── write_read.png
│ ├── console_output.png


---

## ⚡ Features
- **Parameterized FIFO** (Depth = 8, Width = 8 by default)
- Implements a **circular buffer**
- Provides **full** and **empty** status flags
- Protects against **overflow and underflow**
- Testbench demonstrates:
  - Writing data into FIFO
  - Reading data back
  - FIFO full condition
  - FIFO empty condition
  - Ignored writes when full
  - Ignored reads when empty

---

## 🛠️ Tools Required
- [Icarus Verilog](http://iverilog.icarus.com/) → simulation  
- [GTKWave](http://gtkwave.sourceforge.net/) → waveform viewing  

Install on Ubuntu/Debian:
```bash
sudo apt-get install iverilog gtkwave

▶️ Running the Simulation

Clone the repository:

git clone https://github.com/Ujjwal2810/fifo-verilog.git
cd fifo-verilog


Compile the design and testbench:

iverilog -o fifo.vvp tb_fifo.v fifo.v


Run the simulation:

vvp fifo.vvp


Example console output:

=== Write 4 values ===
=== Read 4 values ===
Read value = 10
Read value = 20
Read value = 30
Read value = 40
=== Fill FIFO ===
FIFO full flag = 1
Tried extra write, full=1
=== Empty FIFO ===
Read value = ...
FIFO empty flag = 1
Tried extra read, empty=1
=== Test Complete ===


Open waveform in GTKWave:

gtkwave fifo.vcd

📌 Notes

Current Depth = 8, Width = 8 (changeable via parameters).

Excellent for learning RTL design and testbench writing.

Can be extended into more advanced FIFO variants (e.g., asynchronous FIFO, dual-clock FIFO).

👨‍💻 Author

Ujjwal2810
https://github.com/Ujjwal2810
