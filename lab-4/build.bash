#!/bin/bash

buildtestbench()
{
    ghdl -a $1.vhdl
    ghdl -e $1
    ghdl -r $1 --stop-time=3000ns --vcd=waveform.vcd
}

entities=(
    d_ff
    shift_register
    selector
    zero_extender
    reg
    full_adder_rc
    adder
    incrementer
    negate
    q_register
    datapath
)

for fname in "${entities[@]}"; do
    ghdl -a $fname.vhdl
done


# =====================================
# build any relevant testbenches
# =====================================
#buildtestbench "testbench_qregister"
buildtestbench "testbench_datapath"
