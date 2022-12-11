; #####################################################################
; #
; # Stop print
; #
; #####################################################################
M568 P0 S0 R0 A0         ; turn off extruder
M140 S0 R0               ; set bed temperature to 0C
M140 S-274               ; set bed temperature to 0K to turn it off
M106 T0 S0                                                             ; turn off cooling fan
M84 XY					 ; Stop the idle hold on x and y axis
