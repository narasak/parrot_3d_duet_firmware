; =========================================================================================================
;
;   Level the X gantry by ramming at lower motor current against the Z toppers
;
;   Caribou220 Duet3Mini+ Bondtech - SE HT Thermistor - SuperPINDA
;
; =========================================================================================================
;
M913 X100 Y100 Z100          ; set motor currents to 100%
G91                          ; relative positioning
G28                          ; home Axes
G90                          ; absolute positioning
G1 X125 Y55 F6000            ; move extruder to the middle of the X axis
M564 S0                      ; disable minimum and maximum axis limits
G1 Z205 F6000                ; Move Z axis just below top
M913 Z40                     ; reduce Z motor current to 30% of set current
G91                          ; relative positioning
G1 H1 Z15 F300               ; move Z axis 15mm up slowly leveling the X gantry
M913 Z100                    ; return Z motor current to 100% of set current
G90                          ; absolute positioning
M564 S1                      ; enable minimum and maximum axis limits
M208 X256.9 Y214 Z216.50 S0  ; set axis maxima
G1 X11.5 Y4.5 Z10.0 F6000    ; go to first probe point
M400                          ; wait for current moves to finish
G30                          ; probe bed
;
; =========================================================================================================
;
