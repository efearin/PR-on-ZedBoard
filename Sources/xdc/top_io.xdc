###############################
## Manipulation for ZedBoard ##
## Efe Arın 08.2017			 ##
###############################


####################################################################################
# Constraints from file : 'top_io.xdc'
####################################################################################



#-----------------------------------
# Clock
#-----------------------------------

# Create clock with name clk_p and frequency 100MHz and assign it to top module clk_p variable 
create_clock -name clk_p -period 10 [get_ports clk_p]

# Programable clock on Zedboard, on pin Y9, is assigned to clk_p created above 
# with IOstandard LVDS_25 (2.5V low voltage differentiable signal) 
# Although differentiable clock setup needs p and n side assignment 
# in this case assigning just p side of it is enough
set_property PACKAGE_PIN Y9 [get_ports clk_p]
set_property IOSTANDARD LVDS_25 [get_ports clk_p]



#-----------------------------------
# LEDs
#    LED[0-3] for shift
#    LED[4-7] for count
#-----------------------------------

# All User Leds' on Zedboard have IOstandard LCVMOS33

# Assign shift_out[0] from top module to Zedboard User_Led[0] (T22)
set_property PACKAGE_PIN T22 [get_ports shift_out[0]]
set_property IOSTANDARD LVCMOS33 [get_ports shift_out[0]]

# Assign shift_out[1] from top module to Zedboard User_Led[1] (T21)
set_property PACKAGE_PIN T21 [get_ports shift_out[1]]
set_property IOSTANDARD LVCMOS33 [get_ports shift_out[1]]

# Assign shift_out[2] from top module to Zedboard User_Led[2] (U22)
set_property PACKAGE_PIN U22 [get_ports shift_out[2]]
set_property IOSTANDARD LVCMOS33 [get_ports shift_out[2]]

# Assign shift_out[3] from top module to Zedboard User_Led[3] (U21)
set_property PACKAGE_PIN U21 [get_ports shift_out[3]]
set_property IOSTANDARD LVCMOS33 [get_ports shift_out[3]]

# Assign count_out[3] from top module to Zedboard User_Led[7] (U14)
set_property PACKAGE_PIN U14 [get_ports count_out[3]]
set_property IOSTANDARD LVCMOS33 [get_ports count_out[3]]

# Assign count_out[2] from top module to Zedboard User_Led[6] (U19)
set_property PACKAGE_PIN U19 [get_ports count_out[2]]
set_property IOSTANDARD LVCMOS33 [get_ports count_out[2]]

# Assign count_out[1] from top module to Zedboard User_Led[5] (W22)
set_property PACKAGE_PIN W22 [get_ports count_out[1]]
set_property IOSTANDARD LVCMOS33 [get_ports count_out[1]]

# Assign count_out[0] from top module to Zedboard User_Led[4] (V22)
set_property PACKAGE_PIN V22 [get_ports count_out[0]]
set_property IOSTANDARD LVCMOS33 [get_ports count_out[0]]



#-----------------------------------
# Push Button
#-----------------------------------

# Randomly one of the Push Button on Zedboard
set_property PACKAGE_PIN T18 [get_ports rst_n]



#-----------------------------------
# Configuration
#-----------------------------------

#set configuration voltage
set_property CONFIG_VOLTAGE 2.5 [current_design]
set_property CFGBVS VCCO [current_design]



#-----------------------------------
# End
#-----------------------------------
