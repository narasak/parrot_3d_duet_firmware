; 0:/sys/pause.g
; Called when a print from SD card is paused

; =========================================================================================================
; NEOPIXEL RGB
; =========================================================================================================
M98 P"0:/macros/NEOPIXEL/orange.g"

if state.currentTool != 1
	M83
    G1 E-4 F2500											; Retract 4mm of filament.
G91
G1 Z5 F360													; Raise Z 5mm.
G90                                                        	; Set absolute positioning.
G1 X10 Y210 F6000                                          	; Move to the parking position.
M106 S0

;M120                                                       	; Push the state of the machine onto the memory stack.

;if sensors.filamentMonitors[0].filamentPresent = false
;   G1 E-3 F1000                                            ; If the filament has run out, retract 6mm of filament.

;M83                                                        	; Set relative extruder moves.
;G1 E-2 F3600                                               	; Retract 3mm of filament.
;G91                                                        	; Set relative positioning.
;G1 Z5 F360                                              	; Raise Z 5mm.
;G90                                                        	; Set absolute positioning.
;G1 X10 Y210 F6000                                          	; Move to the parking position.
;M300 S80 P2000                                             	; Play a beep sound.