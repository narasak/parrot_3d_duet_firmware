; #####################################################################
; #
; # Set the current and sensitivity for normal routines
; #
; #####################################################################

M913 X100 Y100 Z100                                                    ; set the x, y, and z drivers to 100% of their normal current per config.g.
M915 X S2 F0 H200 R0                                                   ; set the x axis sensitivity.
M915 Y S2 F0 H200 R0                                                   ; set the y axis sensitivity.