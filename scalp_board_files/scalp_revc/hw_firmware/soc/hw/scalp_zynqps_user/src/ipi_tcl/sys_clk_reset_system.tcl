
################################################################
# This is a generated script based on design: sys_clk_reset_system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2023.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

   } else {
     catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   }

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source sys_clk_reset_system_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z015clg485-2
   set_property BOARD_PART hepia-cores.ch:scalp_node:part0:0.2 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name sys_clk_reset_system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:clk_wiz:6.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set Clk125PllLockedxS [ create_bd_port -dir O Clk125PllLockedxS ]
  set Clk125RstxRNAO [ create_bd_port -dir O -from 0 -to 0 -type rst Clk125RstxRNAO ]
  set Clk125RstxRO [ create_bd_port -dir O -from 0 -to 0 -type rst Clk125RstxRO ]
  set Clk125xCO [ create_bd_port -dir O -type clk Clk125xCO ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_RESET {Clk125RstxRO:Clk125RstxRNAO} \
   CONFIG.FREQ_HZ {125000000} \
 ] $Clk125xCO
  set PsClockxCI [ create_bd_port -dir I -type clk -freq_hz 125000000 PsClockxCI ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_RESET {PsResetxRN} \
 ] $PsClockxCI
  set PsResetxRN [ create_bd_port -dir I -type rst PsResetxRN ]
  set Clk125IntConnRstxRNAO [ create_bd_port -dir O -from 0 -to 0 -type rst Clk125IntConnRstxRNAO ]

  # Create instance: rst_ps7_0_125M, and set properties
  set rst_ps7_0_125M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps7_0_125M ]

  # Create instance: sys_clock, and set properties
  set sys_clock [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 sys_clock ]
  set_property -dict [list \
    CONFIG.CLKIN1_JITTER_PS {80.0} \
    CONFIG.CLKOUT1_JITTER {119.348} \
    CONFIG.CLKOUT1_PHASE_ERROR {96.948} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125} \
    CONFIG.CLKOUT1_USED {true} \
    CONFIG.CLKOUT2_JITTER {149.891} \
    CONFIG.CLKOUT2_PHASE_ERROR {95.888} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {100.000} \
    CONFIG.CLKOUT2_USED {false} \
    CONFIG.CLKOUT3_JITTER {100.399} \
    CONFIG.CLKOUT3_PHASE_ERROR {86.876} \
    CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {100.000} \
    CONFIG.CLKOUT3_USED {false} \
    CONFIG.CLKOUT4_JITTER {150.677} \
    CONFIG.CLKOUT4_PHASE_ERROR {214.542} \
    CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {100.000} \
    CONFIG.CLKOUT4_USED {false} \
    CONFIG.CLK_OUT1_PORT {clk_125} \
    CONFIG.CLK_OUT2_PORT {clk_out2} \
    CONFIG.CLK_OUT3_PORT {clk_out3} \
    CONFIG.CLK_OUT4_PORT {clk_out4} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {8.000} \
    CONFIG.MMCM_CLKIN1_PERIOD {8.000} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {1} \
    CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
    CONFIG.MMCM_CLKOUT3_DIVIDE {1} \
    CONFIG.MMCM_DIVCLK_DIVIDE {1} \
    CONFIG.NUM_OUT_CLKS {1} \
    CONFIG.PRIM_SOURCE {Global_buffer} \
    CONFIG.RESET_PORT {resetn} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
  ] $sys_clock


  # Create port connections
  connect_bd_net -net PsClockxCI_1 [get_bd_ports PsClockxCI] [get_bd_pins sys_clock/clk_in1]
  connect_bd_net -net PsResetxRN_1 [get_bd_ports PsResetxRN] [get_bd_pins rst_ps7_0_125M/ext_reset_in] [get_bd_pins sys_clock/resetn]
  connect_bd_net -net rst_ps7_0_125M_interconnect_aresetn [get_bd_pins rst_ps7_0_125M/interconnect_aresetn] [get_bd_ports Clk125IntConnRstxRNAO]
  connect_bd_net -net rst_ps7_0_125M_peripheral_aresetn [get_bd_pins rst_ps7_0_125M/peripheral_aresetn] [get_bd_ports Clk125RstxRNAO]
  connect_bd_net -net rst_ps7_0_125M_peripheral_reset [get_bd_pins rst_ps7_0_125M/peripheral_reset] [get_bd_ports Clk125RstxRO]
  connect_bd_net -net sys_clock_clk_125 [get_bd_pins sys_clock/clk_125] [get_bd_pins rst_ps7_0_125M/slowest_sync_clk] [get_bd_ports Clk125xCO]
  connect_bd_net -net sys_clock_locked [get_bd_pins sys_clock/locked] [get_bd_pins rst_ps7_0_125M/dcm_locked] [get_bd_ports Clk125PllLockedxS]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  # Create PFM attributes
  set_property PFM.CLOCK {clk_125 {id "2" is_default "true" proc_sys_reset "/rst_ps7_0_125M" status "fixed" freq_hz "125000000"}} [get_bd_cells /sys_clock]


  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


