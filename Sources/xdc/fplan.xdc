###############################
## Manipulation for ZedBoard ##
## Efe Arın 08.2017			 ##
###############################


# User Generated miscellaneous constraints 

set_property DONT_TOUCH true [get_cells inst_shift]
set_property HD.RECONFIGURABLE true [get_cells inst_shift]
set_property DONT_TOUCH true [get_cells inst_count]
set_property HD.RECONFIGURABLE true [get_cells inst_count]

# User Generated physical constraints 

create_pblock pblock_inst_count
add_cells_to_pblock [get_pblocks pblock_inst_count] [get_cells -quiet [list inst_count]]
resize_pblock [get_pblocks pblock_inst_count] -add {SLICE_X26Y50:SLICE_X37Y99}
resize_pblock [get_pblocks pblock_inst_count] -add {DSP48_X2Y20:DSP48_X2Y39}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB18_X2Y20:RAMB18_X2Y39}
resize_pblock [get_pblocks pblock_inst_count] -add {RAMB36_X2Y10:RAMB36_X2Y19}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_inst_count]
set_property SNAPPING_MODE ROUTING [get_pblocks pblock_inst_count]

# User Generated miscellaneous constraints 


# User Generated physical constraints 

create_pblock pblock_inst_shift
add_cells_to_pblock [get_pblocks pblock_inst_shift] [get_cells -quiet [list inst_shift]]
resize_pblock [get_pblocks pblock_inst_shift] -add {SLICE_X100Y50:SLICE_X107Y99}
resize_pblock [get_pblocks pblock_inst_shift] -add {DSP48_X4Y20:DSP48_X4Y39}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB18_X5Y20:RAMB18_X5Y39}
resize_pblock [get_pblocks pblock_inst_shift] -add {RAMB36_X5Y10:RAMB36_X5Y19}
set_property RESET_AFTER_RECONFIG true [get_pblocks pblock_inst_shift]
set_property SNAPPING_MODE ROUTING [get_pblocks pblock_inst_shift]

# User Generated miscellaneous constraints 


# Vivado Generated miscellaneous constraints 

#revert back to original instance
current_instance -quiet
