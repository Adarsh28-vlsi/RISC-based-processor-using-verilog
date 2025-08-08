#!/bin/bash

# RISC Processor Simulation Script
# Compiles and runs the Verilog testbench

echo "=== RISC Processor Simulation ==="
echo "Compiling Verilog files..."

# Create simulation directory
mkdir -p ../simulation

# Compile all Verilog files
iverilog -o ../simulation/cpu_sim \
    ../src/register_file.v \
    ../src/alu.v \
    ../src/control_unit.v \
    ../src/memory_interface.v \
    ../src/instruction_fetch.v \
    ../src/cpu_top.v \
    ../testbench/cpu_testbench.v

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful!"
    echo "Running simulation..."
    
    # Change to simulation directory and run
    cd ../simulation
    ./cpu_sim
    
    echo ""
    echo "Simulation complete!"
    echo "VCD file generated: cpu_simulation.vcd"
    echo "View with: gtkwave cpu_simulation.vcd"
else
    echo "Compilation failed!"
    exit 1
fi