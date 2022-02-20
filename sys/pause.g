; #####################################################################
; #
; # Pause printing
; #
; #####################################################################

M83                                          ; relative extruder moves
G1 E-2 F3600                                 ; retract 2mm of filament
G91                                          ; relative positioning
G1 Z5 F360                                   ; lift Z by 5mm
G90                                          ; set absolute positioning
if  {move.axes[2].machinePosition < 80}      ; if z position is below 80mm
    G1 X200 Y0 Z80 F6000                     ; go to the parking position
else
    G1 X200 Y0 F6000                         ; go to the parking position