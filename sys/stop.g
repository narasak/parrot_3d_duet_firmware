; #####################################################################
; #
; # Stop print
; #
; #####################################################################
G10 P0 S-274 R-274       ; turn off extruder
M140 S0 R0               ; set bed temperature to 0C
M140 S-274               ; set bed temperature to 0K to turn it off
M107                     ; turn off fan
;M84 X,Y					 ; Stop the idle hold on x and y axis
