M291 P"Please wait while the nozzle is being heated up" R"Loading PLA" T5 	; Display message
G10 S210 																	; Set current tool temperature to 210C
M116 																		; Wait for the temperatures to be reached
M291 P"Feeding filament..." R"Loading PLA" T5 							    ; Display new message

M98 P"0:/macros/Filament Handling/load.g"

M400 																		; Wait for moves to complete
M292 																		; Hide the message

; LEAVE EMPTY