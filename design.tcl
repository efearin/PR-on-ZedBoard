###############################
## Manipulation for ZedBoard ##
## Efe Arın 08.2017			 ##
###############################

###############################################################
###   Tcl Variables
###############################################################
#set tclParams [list <param1> <value> <param2> <value> ... <paramN> <value>]
set tclParams [list hd.visual 1] 

#Define custom location for "Tcl" directory. Defaults to "./Tcl"
set tclHome "./Tcl"
if {[file exists $tclHome]} {
   set tclDir $tclHome
} elseif {[file exists "./Tcl"]} {
   set tclDir  "./Tcl"
} else {
   error "ERROR: No valid location found for required Tcl scripts. Set \$tclDir in design.tcl to a valid location."
}

####Source required Tcl Procs
source $tclDir/design_utils.tcl
source $tclDir/log_utils.tcl
source $tclDir/synth_utils.tcl
source $tclDir/impl_utils.tcl
source $tclDir/pr_utils.tcl
source $tclDir/hd_floorplan_utils.tcl

###############################################################
### Define Part, Package, Speedgrade 
###############################################################
set device       "xc7z020"
set package      "clg484"
set speed        "-1"
set part         $device$package$speed
check_part $part

###############################################################
###  Setup Variables
###############################################################
#set tclParams [list <param1> <value> <param2> <value> ... <paramN> <value>]

####flow control
set run.topSynth       1
set run.rmSynth        1
set run.prImpl         0
set run.prVerify       0
set run.writeBitstream 0

####Report and DCP controls - values: 0-required min; 1-few extra; 2-all
set verbose      1
set dcpLevel     1

####Output Directories
set synthDir  "./Synth"
set implDir   "./Implement"
set dcpDir    "./Checkpoint"
set bitDir    "./Bitstreams"

####Input Directories
set srcDir     "./Sources"
set rtlDir     "$srcDir/hdl"
set prjDir     "$srcDir/prj"
set xdcDir     "$srcDir/xdc"
set coreDir    "$srcDir/cores"
set netlistDir "$srcDir/netlist"

###############################################################
### Top Definition
###############################################################
set top "top"
set static "Static"
add_module $static
set_attribute module $static moduleName    $top
set_attribute module $static top_level     1
set_attribute module $static vlog          [list [glob $rtlDir/$top/*.v]]
set_attribute module $static synth         ${run.topSynth}

####################################################################
### RP Module Definitions
####################################################################
set module1 "shift"

set module1_variant1 "shift_right"
set variant $module1_variant1
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vlog         [list $rtlDir/$variant/$variant.v]
set_attribute module $variant synth        ${run.rmSynth}

set module1_variant2 "shift_left"
set variant $module1_variant2
add_module $variant
set_attribute module $variant moduleName   $module1
set_attribute module $variant vlog         [list $rtlDir/$variant/$variant.v]
set_attribute module $variant synth        ${run.rmSynth}

set module1_inst "inst_shift"

####################################################################
### RP Module Definitions
####################################################################
set module2 "count"

set module2_variant1 "count_up"
set variant $module2_variant1
add_module $variant
set_attribute module $variant moduleName   $module2
set_attribute module $variant vlog         [list $rtlDir/$variant/$variant.v]
set_attribute module $variant synth        ${run.rmSynth}

set module2_variant2 "count_down"
set variant $module2_variant2
add_module $variant
set_attribute module $variant moduleName   $module2
set_attribute module $variant vlog         [list $rtlDir/$variant/$variant.v]
set_attribute module $variant synth        ${run.rmSynth}

set module2_inst "inst_count"

########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "implement"
set config "Config_${module1_variant1}_${module2_variant1}_${state}" 

add_implementation $config
set_attribute impl $config top             $top
set_attribute impl $config implXDC         [list $xdcDir/${top}.xdc]
set_attribute impl $config partitions      [list [list $static           $top          $state   ] \
                                                 [list $module1_variant1 $module1_inst implement] \
                                                 [list $module2_variant1 $module2_inst implement] \
                                           ]
set_attribute impl $config pr.impl         1 
set_attribute impl $config impl            ${run.prImpl} 
set_attribute impl $config verify     	    ${run.prVerify} 
set_attribute impl $config bitstream  	    ${run.writeBitstream} 

########################################################################
### Configuration (Implementation) Definition - Replicate for each Config
########################################################################
set state "import"
set config "Config_${module1_variant2}_${module2_variant2}_${state}" 

add_implementation $config
set_attribute impl $config top             $top
set_attribute impl $config implXDC         [list $xdcDir/${top}.xdc]
set_attribute impl $config partitions      [list [list $static           $top          $state   ] \
                                                 [list $module1_variant2 $module1_inst implement] \
                                                 [list $module2_variant2 $module2_inst implement] \
                                           ]
set_attribute impl $config pr.impl         1 
set_attribute impl $config impl            ${run.prImpl} 
set_attribute impl $config verify     	    ${run.prVerify} 
set_attribute impl $config bitstream  	    ${run.writeBitstream} 

########################################################################
### Task / flow portion
########################################################################
# Build the designs
source $tclDir/run.tcl
#exit
