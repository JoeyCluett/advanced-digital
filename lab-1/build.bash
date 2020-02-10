#!/bin/bash

ghdl -a d_ff.vhdl
ghdl -a freq_divider.vhdl
ghdl -a light_control.vhdl
ghdl -a timing_generator.vhdl

# frequency divider testbench
#ghdl -a testbench.vhdl
#ghdl -e testbench
#ghdl -r testbench --stop-time=2000ms --vcd=waveform.vcd

# D flipflop testbench
#ghdl -a testbenchdff.vhdl
#ghdl -e testbenchdff
#ghdl -r testbenchdff --stop-time=800ns --vcd=waveform.vcd

# light control testbench
#ghdl -a testbenchlight.vhdl
#ghdl -e testbenchlight
#ghdl -r testbenchlight --stop-time=800ns --vcd=waveform.vcd

# lab 1 testbench
ghdl -a testbenchlab1.vhdl
ghdl -e testbenchlab1
ghdl -r testbenchlab1 --stop-time=800ns --vcd=waveform.vcd
