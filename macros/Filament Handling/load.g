M300 S500 P600     ; beep
M291 P"Insert filament. Press ok to start feeding filament..." S2; Display new message
M291 P"Feeding filament.... " S1 T25
;
G91                		; Set to Relative Positioning
G1 E80 F600	       		; Feed 80mm of filament at 600mm/min
G1 E35 F200	       		; Feed 35mm of filament at 200mm/min
G4 P1000	       		; Wait one second
G1 E-0.5 F200	   		; Retract -0.5mm of filament at 200mm/min
M291 P"..... done" T30
M400               		; Wait for the moves to finish
M84 E0             		; Turn off extruder drives 1 
;G10 S0		       		; Turn off the heater again