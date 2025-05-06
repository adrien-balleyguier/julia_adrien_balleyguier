##################################################################################
#                                 _             _
#                                | |_  ___ _ __(_)__ _
#                                | ' \/ -_) '_ \ / _` |
#                                |_||_\___| .__/_\__,_|
#                                         |_|
#
##################################################################################
#
# Company: hepia
# Author: Joachim Schmidt <joachim.schmidt@hesge.ch>
#
# Project Name: scalp_user_design
# Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
# Tool version: 2023.2
# Description: Export the hardware design to Vitis SDK
#
# Last update: 2024-03-26 08:26:57
#
##################################################################################

source utils.tcl

# Project paths
set PRJ_DIR ".."
set SRC_DIR "${PRJ_DIR}/../src"
set EXPORT_DIR "${SRC_DIR}/sw/hw_export"

# Initialize workspace directories name
set prj_name "scalp_user_design"
# Create the export directory if not present
file mkdir ${EXPORT_DIR}
print_status "Initialize workspace directories" "OK"

# Open the project
open_project -verbose ${PRJ_DIR}/${prj_name}/${prj_name}.xpr
print_status "Open project $prj_name" "OK"

# Export the hardware including the bitstream
if {[version -short] < "2019.2"} {
    # Before Vivado 2019.2, export the .hdf
    set IMPL_DIR "${PRJ_DIR}/${prj_name}/${prj_name}.runs/impl_1/"
    file copy -force ${IMPL_DIR}/${prj_name}.sysdef ${EXPORT_DIR}/${prj_name}.hdf
} else {
    # Starting with Vivado 2019.2, export the .xsa
    if {[get_property platform.extensible [current_project]] == 1} {
        # - For extensible platform
        # Export hardware for Vitis extensible platform requires that all sources are local to project
        # Import them at project creation
        import_files
        # setup the platform parameters
        set_property pfm_name xilinx:scalp_ext_pfm:${prj_name}:1.0 [get_files -all ${PRJ_DIR}/${prj_name}/${prj_name}.srcs/sources_1/bd/bd_${prj_name}/bd_${prj_name}.bd]
        set_property platform.extensible {true} [current_project]
        set_property platform.version {1.0} [current_project]
        set_property platform.design_intent.embedded {true} [current_project]
        set_property platform.design_intent.datacenter {false} [current_project]
        set_property platform.design_intent.server_managed {false} [current_project]
        set_property platform.design_intent.external_host {false} [current_project]
        set_property platform.default_output_type {sd_card} [current_project]
        set_property platform.uses_pr {false} [current_project]

        write_hw_platform -hw -include_bit -force -file ${EXPORT_DIR}/${prj_name}.xsa
    } else {
        # - For others
        write_hw_platform -fixed -force -include_bit -file ${EXPORT_DIR}/${prj_name}.xsa
    }
}
print_status "Export hardware to SDK" "OK"

exit
