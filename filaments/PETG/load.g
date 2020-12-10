M291 P"Please wait while the nozzle is being heated up" R"Loading PETG" T5 	; Display message
G10 S240 																	; Set current tool temperature to 240C
M116 																		; Wait for the temperatures to be reached
M291 P"Feeding filament..." R"Loading PEETG" T5 							; Display new message

M98 P"0:/macros/Filament Handling/load.g"

M400 																		; Wait for moves to complete
M292 																		; Hide the message

; LEAVE EMPTY