MIPS_32bits_Multicycle
==============

Description
--------------
This project implements a MIPS multicycle using the Nexys 4 DDR. The I/O peripherical used are switches, LEDs, and seven-segment displays, written in SystemVerilog.
The 12 User LEDs show the ALU out, and the remaining LEDs represented the FSM state. The seven-segment display the values of the Instruction/Data memory or Register memory. SW0 to SW14 select the address memory, and the SW15 read either Instruction/Data memory or Register memory.  
For more reference of the FPGA, see the Nexys 4 DDR's [Reference Manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-4-ddr/reference-manual) 


Requirements
--------------
* **Nexys 4 DDR**
* **Vivado 2020.2 Installation**
* **MicroUSB Cable**

Setup
--------------
1. Download and extract the archive from this repository's
2. Open the project in Vivado 2020.2 by double clicking on the included XPR file found at "\<archive extracted location\>/vivado_proj/Nexys-4-MIPS.xpr".
3. In the Flow Navigator panel on the left side of the Vivado window, click **Open Hardware Manager**.
4. Plug the Nexys 4 DDR into the computer using a MicroUSB cable.
5. In the green bar at the top of the window, click **Open target**. Select "Auto connect" from the drop down menu.
6. In the green bar at the top of the window, click **Program device**.
7. In the Program Device Wizard, enter "\<archive extracted location\>vivado_proj/Nexys-4-DDR-MIPSruns/impl_1/MIPS.bit" into the "Bitstream file" field. Then click **Program**.

For a description of how this MIPS works, read the files in the folder Documents.

Additional Notes
--------------
In the following link, you could find a descriptive video of MIPS's physical implementation in the FPGA. [Drive google](https://drive.google.com/file/d/1vcZT1HaSXbffHm1zhjFSgZLJB_kZuDvz/view?usp=sharing)
