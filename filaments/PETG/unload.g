M291 P"Please wait while the nozzle is being heated up" R"Unloading PETG" T5 	; Display message
G10 S200 																		; Heat up the current tool to 200C
M116 																			; Wait for the temperatures to be reached

M98 P"0:/macros/Filament Handling/unload.g"

M400 																			; Wait for the moves to finish
M292 																			; Hide the message again
M84 E0	 																		; Turn off extruder drives 0