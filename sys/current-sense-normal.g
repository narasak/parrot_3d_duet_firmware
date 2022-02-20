; #####################################################################
; #
; # Set the current and sensitivity for normal routines
; #
; #####################################################################

M913 X100 Y100          ; return current to 100% for x and y
M569 P0.1 V100          ; restore default V for x
M569 P0.2 V100          ; restore default V for y
G90                     ; absolute positioning