#!/bin/bash

buildtestbench()
{
    ghdl -a $1.vhdl
    ghdl -e $1
    ghdl -r $1 --stop-time=3000ns --vcd=waveform.vcd
}

entities=(
    reg
    full_adder_rc
    adder
    full_adder_cs
    carry_save_adder
    selector
    toplevel
)

for fname in "${entities[@]}"; do
    ghdl -a $fname.vhdl
done


# =====================================
# build any relevant testbenches
# =====================================
buildtestbench "testbench"

