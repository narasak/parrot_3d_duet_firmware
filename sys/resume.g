; 0:/sys/resume.g
; Called before a print from SD card is resumed

M98 P"current-sense-normal.g"                              	; Ensure the drivers current and sensitivity is set for normal routines.

M106 R1
G1 R1 X0 Y0 Z2 F5000										; move to 2 mm above resume position
G1 R1 X0 Y0 Z0												; lower nozzle to resume point

if state.currentTool != -1
	M83														; relative extruder moves
    G1 E4 F2500												; undo the retraction
    
;G1 E3 F400                                                 ; Extract 3mm of filament.
;G1 R1 X0 Y0 Z5                                             ; Go back to the last print position with Z 5mm above.
;G1 R1 Z0                                                   ; Go to Z position of the last print move.
;M121                                                       ; Recover the last state pushed onto the stack.