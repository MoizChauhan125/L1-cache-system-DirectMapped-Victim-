####################################################################
# Top Module – Timing Constraints
####################################################################

####################################################################
# Clock definition
####################################################################

# Single system clock
# 10.0 ns period = 100 MHz 
create_clock -name clk -period 20.0 -waveform {0 10} [get_pins clk_pad/XC]

# Clock uncertainty (setup + hold margin for CTS)
set_clock_uncertainty -setup 0.2 [get_clocks clk]
set_clock_uncertainty -hold 0.05 [get_clocks clk]

# Clock transition (reasonable slew)
set_clock_transition 0.2 [get_clocks clk]

####################################################################
# Reset constraints
####################################################################

# Asynchronous active-low reset
set_false_path -from [get_ports rst_n]

####################################################################
# Input constraints - CPU Interface
####################################################################

set_input_delay -max 3.0 -clock clk [get_pins {cpu_req_valid_pad/C}]
set_input_delay -max 3.0 -clock clk [get_pins {cpu_req_rw_pad/C}]
set_input_delay -max 3.0 -clock clk [get_pins {cpu_addr_pad*/C}]
set_input_delay -max 3.0 -clock clk [get_pins {cpu_wdata_pad*/C}]

# Memory response interface
set_input_delay -max 3.0 -clock clk [get_pins {mem_resp_valid_pad/C}]
set_input_delay -max 3.0 -clock clk [get_pins {mem_rdata_pad*/C}]

# Set minimum input delays (if needed)
set_input_delay -min 0.5 -clock clk [get_pins {cpu_req_valid_pad/C}]
set_input_delay -min 0.5 -clock clk [get_pins {cpu_req_rw_pad/C}]
set_input_delay -min 0.5 -clock clk [get_pins {cpu_addr_pad*/C}]
set_input_delay -min 0.5 -clock clk [get_pins {cpu_wdata_pad*/C}]
set_input_delay -min 0.5 -clock clk [get_pins {mem_resp_valid_pad/C}]
set_input_delay -min 0.5 -clock clk [get_pins {mem_rdata_pad*/C}]

set_input_delay -clock clk -max 3.0 [get_pins rst_pad/C]
set_input_delay -clock clk -min 0.5 [get_pins rst_pad/C]

####################################################################
# Output constraints - CPU Response and Memory Request
####################################################################

# CPU response interface
set_output_delay -max 3.0 -clock clk [get_pins {cpu_resp_valid_pad/I}]
set_output_delay -max 3.0 -clock clk [get_pins {cpu_resp_data_pad*/I}]

# Memory request interface
set_output_delay -max 3.0 -clock clk [get_pins {mem_req_valid_pad/I}]
set_output_delay -max 3.0 -clock clk [get_pins {mem_req_rw_pad/I}]
set_output_delay -max 3.0 -clock clk [get_pins {mem_addr_pad*/I}]
set_output_delay -max 3.0 -clock clk [get_pins {mem_wdata_pad*/I}]

# Set minimum output delays (if needed)
set_output_delay -min 0.5 -clock clk [get_pins {cpu_resp_valid_pad/I}]
set_output_delay -min 0.5 -clock clk [get_pins {cpu_resp_data_pad*/I}]
set_output_delay -min 0.5 -clock clk [get_pins {mem_req_valid_pad/I}]
set_output_delay -min 0.5 -clock clk [get_pins {mem_req_rw_pad/I}]
set_output_delay -min 0.5 -clock clk [get_pins {mem_addr_pad*/I}]
set_output_delay -min 0.5 -clock clk [get_pins {mem_wdata_pad*/I}]

####################################################################
# Internal generated clocks (if any)
####################################################################

# No generated clocks in this design based on RTL

####################################################################
# Load capacitance assumptions
####################################################################

# Assuming typical load values (in pF)
set_load 0.05 [get_ports "cpu_resp_valid"]
set_load 0.05 [get_ports "cpu_resp_rdata[*]"]
set_load 0.05 [get_ports "mem_req_valid"]
set_load 0.05 [get_ports "mem_req_rw"]
set_load 0.05 [get_ports "mem_req_addr[*]"]
set_load 0.1  [get_ports "mem_req_wdata[*]"]

####################################################################
# Design-specific timing exceptions
####################################################################

# False paths between internal interfaces (if needed)
# Example: set_false_path -from [get_nets vc_probe_valid] -to [get_nets mem_req_valid]

####################################################################
# Multicycle paths (if any)
####################################################################

# If any paths require multiple cycles, specify them here
# Example: set_multicycle_path -setup 2 -from [get_pins ...] -to [get_pins ...]

####################################################################
# End of SDC
####################################################################
