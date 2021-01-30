; 0:/sys/cancel.g
; Called when a print is canceled after a pause.
; =========================================================================================================
;
;  called when M0 (Stop) is run (e.g. when a print is cancelled)
;
; =========================================================================================================
;
M83                             ; Set the extrusion values as relative.
M104 S0                         ; Turn off the hotend.
M140 S0                         ; Turn off the heatbed.
M107                            ; Turn off part cooling fan.
G1 F1000.0                      ; Set the feed rate.
G1 E-2                          ; Retract 2mm of filament.
G1 H2 X0 Y210 F4000 			; move bed to front
M98 P"current-sense-homing.g"   ; Set the current and sensitivity for homing, non-print, routines.
M400                            ; Finish all moves, clear the buffer.
M18 YXE                         ; Unlock the X, Y, and E axis.