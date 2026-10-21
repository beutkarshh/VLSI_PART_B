
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name MOD25_counter -dir "C:/Xilinx/42363/MOD25_counter/planAhead_run_1" -part xc3s250epq208-5
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "C:/Xilinx/42363/MOD25_counter/MOD25_counter.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Xilinx/42363/MOD25_counter} }
set_property target_constrs_file "MODD25_counter_UCF.ucf" [current_fileset -constrset]
add_files [list {MODD25_counter_UCF.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "C:/Xilinx/42363/MOD25_counter/MOD25_counter.ncd"
if {[catch {read_twx -name results_1 -file "C:/Xilinx/42363/MOD25_counter/MOD25_counter.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"C:/Xilinx/42363/MOD25_counter/MOD25_counter.twx\": $eInfo"
}
