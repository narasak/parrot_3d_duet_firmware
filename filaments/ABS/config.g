; 0:/filaments/ABS/config.g
; Macro use to set 'basic' setting for filament type

M300 S1000 P200 G4 P500 M300 S3000 P300                    	; Play some tones

; Heater model parameters
M307 H0 A110.9 C400.3 D9.0 S1.0 V23.8 B0					; Bed PID tune for 100c
M307 H1 A388.2 C144.0 D3.3 S1.0 V24.0 B0					; Hot end PID tune at 250c

M140 S80                                                   	; Set the bed temperature to 100c
M104 S150                                                  	; Set the extruder warm-up temperature to 150c
                                                           	; Note: actual extruder temperature will be set from the slicer

; Insert additional filament specific settings here