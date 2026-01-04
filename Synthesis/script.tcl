####################################################################################################
## Environment Setup
####################################################################################################

# Print environment info
if {[file exists /proc/cpuinfo]} {
    sh grep "model name" /proc/cpuinfo
    sh grep "cpu MHz"    /proc/cpuinfo
}
puts "Hostname : []"

# Library setup
set_db / .init_lib_search_path /home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/65_lp_libs

read_libs {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/65_lp_libs/tcbn65lptc.lib /home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/65_lp_libs/tpzn65lpgv2od3tc.lib}

####################################################################################################
## Design Setup
####################################################################################################

set DESIGN top_wrapper ;# Top-level design module
set GEN_EFF  high           ;# Generic synthesis effort
set MAP_OPT_EFF high        ;# Mapping/Optimization effort

####################################################################################################
## Read and Elaborate RTL
####################################################################################################

read_hdl -sv {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/RTL/data_store.sv}
read_hdl -sv {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/RTL/tag_store.sv}
read_hdl -sv {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/RTL/victim_cache_controller.sv}
read_hdl -sv {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/RTL/l1_cache_dm_fsm.sv}
read_hdl -sv {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/RTL/top.sv}
read_hdl -sv {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/RTL/top_wrapper.sv}
elaborate $DESIGN
check_design -unresolved

####################################################################################################
## Constraints
####################################################################################################

# (Update constraints file if needed)
read_sdc {/home/cc/Downloads/Victim-Cache-Design-RTL-GDSII--main/victim_cache_layout_data/frontend/constraints/victim_cache_controller_io.sdc}

####################################################################################################
## Prevent Scan Flip-Flops
####################################################################################################

# Block scan flip-flops (various naming styles)
set_dont_use [get_lib_cells */S*]

####################################################################################################
## Synthesis Flow
####################################################################################################

# Step 1: Generic synthesis
set_db / .syn_generic_effort $GEN_EFF
syn_generic

# Step 2: Technology mapping
set_db / .syn_map_effort $MAP_OPT_EFF
syn_map

# Step 3: Optimization
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt

####################################################################################################
## Write Outputs
####################################################################################################

file mkdir ./Netlist
file mkdir ./out
file mkdir ./RPT

# Netlist
write_hdl $DESIGN -mapped   >> ./Netlist/${DESIGN}_map.v

# Constraints for backend
write_sdc $DESIGN           >> ./out/${DESIGN}_map.sdc

# Delay annotation
write_sdf -design $DESIGN   >> ./out/${DESIGN}_map.sdf

# HTML report
report_metric -format html -file synthesis_report.html

####################################################################################################
## Reports
####################################################################################################

report timing  -full_pin_names   >> ./RPT/${DESIGN}_timing.rpt
report area                     >> ./RPT/${DESIGN}_area.rpt
report gates                    >> ./RPT/${DESIGN}_gates.rpt
report power                    >> ./RPT/${DESIGN}_power.rpt
report qor -levels_of_logic      >> ./RPT/${DESIGN}_qor.rpt

####################################################################################################
## GUI (Optional)
####################################################################################################
gui_show
# quit

