; #####################################################################
; #
; # called when M0 (Stop) is run (e.g. when a print is cancelled)
; #
; #####################################################################

M568 P0 S0 R0 A0                                                       ; turn off extruder
M140 S0 R0                                                             ; set bed temperature to 0C
M140 S-274                                                             ; set bed temperature to 0K to turn it off
M106 T0 S0                                                             ; turn off cooling fan
G91                                                                    ; set relaitive postitioning
G1 H2 Z10                                                              ; lift z axis 10mm
G90                                                                    ; set absolute postitioning
G1 H2 X0 Y210 F4000                                                    ; move bed to front
M84 XY                                                                 ; stop the idle hold on x and y axis