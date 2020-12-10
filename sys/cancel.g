; 0:/sys/cancel.g
; Called when a print is canceled after a pause.

;M83                                                        	; Set the extrusion values as relative.
;M104 S0                                                 	; Turn off the hotend.
;M140 S0                                                 	; Turn off the heatbed.
;M107                                                       	; Turn off part cooling fan.
;G1 F1000.0                                                 	; Set the feed rate.
;G1 E-2                                                     	; Retract 2mm of filament.
;M98 P"current-sense-homing.g"                              	; Set the current and sensitivity for homing, non-print, routines.
;M400                                                       	; Finish all moves, clear the buffer.
;M18 YXE                                                    	; Unlock the X, Y, and E axis.

; =========================================================================================================
;
;  called when M0 (Stop) is run (e.g. when a print is cancelled)
;
; =========================================================================================================
;
M104 S0             ; turn off temperature
M140 S0             ; turn off heatbed
M107                ; turn off fan
G91                 ; set relaitive postitioning
G1 H2 Z10           ; lift z axis 10mm
G90                 ; set absolute postitioning
G1 H2 X0 Y210 F4000 ; move bed to front
