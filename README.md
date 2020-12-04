# MIPS_32bits_Multicycle
==============

This project implements a MIPS multicycle using the Nexys 4 DDR. The I/O peripherical used are switches, LEDs, and seven-segment displays, written in SystemVerilog.
The 12 User LEDs show the ALU out, and the remaining LEDs represented the FSM state. The seven-segment display the values of the Instruction/Data memory or Register memory. SW0 to SW14 select the address memory, and the SW15 read either Instruction/Data memory or Register memory.  
For more reference of the FPGA, see the Nexys 4 DDR's [Reference Manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-4-ddr/reference-manual) 


Requirements
--------------
* **Nexys 4 DDR **
* **Vivado 2020.2 Installation**
* **MicroUSB Cable**
