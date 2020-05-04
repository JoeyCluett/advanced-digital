#!/bin/bash

buildtestbench()
{
    ghdl -a $1.vhdl
    ghdl -e $1
    ghdl -r $1 --stop-time=3000ns --vcd=waveform.vcd
}

ghdl -a d_ff.vhdl           # D flip-flop
ghdl -a freq_divider.vhdl   # Frequency Divider (32-bit)
ghdl -a n_bit_register.vhdl # N-bit register (arbitrary width)
ghdl -a multiplexer.vhdl    # N-bit multiplexer
ghdl -a full_adder.vhdl     # 1-bit adder
ghdl -a n_bit_adder.vhdl    # N-bit adder
ghdl -a shift_register.vhdl # N-bit shift register

# components specific to this project
ghdl -a multiplicand_generator.vhdl 
ghdl -a booth_encoder.vhdl
ghdl -a toplevel_accumulator.vhdl
ghdl -a toplevel_datapath.vhdl # N-bit shift register

# =====================================
# build the various testbenches
# =====================================

#buildtestbench "testbench_nbitreg"
#buildtestbench "testbench_multiplexer"
#buildtestbench "testbench_nbitadder"
#buildtestbench "testbench_multiplicandgenerator"
#buildtestbench "testbench_shiftregister"
#buildtestbench "testbench_accumulator"
#buildtestbench "testbench_boothencoder"
buildtestbench "toplevel"
