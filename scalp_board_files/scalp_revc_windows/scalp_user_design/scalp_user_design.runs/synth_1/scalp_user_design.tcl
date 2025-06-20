# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "/home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.runs/synth_1/scalp_user_design.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param chipscope.maxJobs 3
set_msg_config  -severity {STATUS}  -suppress 
set_msg_config  -severity {INFO}  -suppress 
set_msg_config  -severity {WARNING}  -suppress 
set_msg_config  -severity {CRITICAL WARNING}  -suppress 
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7z015clg485-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.cache/wt [current_project]
set_property parent.project_path /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_repo_paths /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows [current_project]
update_ip_catalog
set_property ip_output_repo /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_vhdl -library xil_defaultlib {
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/new/bram.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/new/compute.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/new/julia_compute.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/new/prio_encoder.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/new/scheduler.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/new/top.vhd
}
read_vhdl -vhdl2008 -library scalp_lib {
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/scalp_axi_pkg.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/scalp_hdmi_pkg.vhd
}
read_vhdl -vhdl2008 -library xil_defaultlib {
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/scalp_zynqps_user.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/scalp_firmwareid.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/scalp_pwm.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/scalp_cplx_num_regs.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/vga_stripes.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/vga_controler.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/vga.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/tmds_encoder.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/serializer_10_to_1.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/vga_to_hdmi.vhd
  /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/imports/files/scalp_hdmi.vhd
}
add_files /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/scalp_zynqps.bd
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_processing_system7_0_0/scalp_zynqps_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_xbar_0/scalp_zynqps_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_auto_pc_0/scalp_zynqps_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_switches_0/scalp_zynqps_axi_gpio_switches_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_switches_0/scalp_zynqps_axi_gpio_switches_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_switches_0/scalp_zynqps_axi_gpio_switches_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_intc_0_0/scalp_zynqps_axi_intc_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_intc_0_0/scalp_zynqps_axi_intc_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_intc_0_0/scalp_zynqps_axi_intc_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_reset_btn_0/scalp_zynqps_axi_gpio_reset_btn_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_reset_btn_0/scalp_zynqps_axi_gpio_reset_btn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_reset_btn_0/scalp_zynqps_axi_gpio_reset_btn_0.xdc]
set_property used_in_synthesis false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_system_ila_0_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_system_ila_0_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_system_ila_0_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_system_ila_0_0/bd_0/ip/ip_0/bd_c0d9_ila_lib_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_system_ila_0_0/bd_0/bd_c0d9_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_system_ila_0_0/scalp_zynqps_system_ila_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_rst_ps7_0_125M_0/scalp_zynqps_rst_ps7_0_125M_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_rst_ps7_0_125M_0/scalp_zynqps_rst_ps7_0_125M_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_rst_ps7_0_125M_0/scalp_zynqps_rst_ps7_0_125M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_sys_clock_0/scalp_zynqps_sys_clock_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_sys_clock_0/scalp_zynqps_sys_clock_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_sys_clock_0/scalp_zynqps_sys_clock_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_iic_ioext_0/scalp_zynqps_axi_iic_ioext_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_iic_ioext_0/scalp_zynqps_axi_iic_ioext_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_joystick_0/scalp_zynqps_axi_gpio_joystick_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_joystick_0/scalp_zynqps_axi_gpio_joystick_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/ip/scalp_zynqps_axi_gpio_joystick_0/scalp_zynqps_axi_gpio_joystick_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/scalp_zynqps_ooc.xdc]

add_files /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/vga_hdmi_clk_rst_system_inst_0.bd
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0/vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0/vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0/vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0/vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0/vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0/vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0/vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0/vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/ip/vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0/vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_zynqps/bd/vga_hdmi_clk_rst_system_inst_0/vga_hdmi_clk_rst_system_inst_0_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/constrs_1/imports/files/debug.xdc
set_property used_in_implementation false [get_files /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/constrs_1/imports/files/debug.xdc]

read_xdc /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/constrs_1/imports/files/scalp_firmware.xdc
set_property used_in_implementation false [get_files /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/constrs_1/imports/files/scalp_firmware.xdc]

read_xdc /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/constrs_1/imports/files/timing_constraints.xdc
set_property used_in_implementation false [get_files /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/constrs_1/imports/files/timing_constraints.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1

read_checkpoint -auto_incremental -incremental /home/adrien-etude/etude/LPSC/lpsc/scalp_board_files/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/utils_1/imports/synth_1/scalp_user_design.dcp
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top scalp_user_design -part xc7z015clg485-2
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef scalp_user_design.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
generate_parallel_reports -reports { "report_utilization -file scalp_user_design_utilization_synth.rpt -pb scalp_user_design_utilization_synth.pb"  } 
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
