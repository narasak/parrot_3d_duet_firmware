; 0:/filaments/PETG/config.g
; Macro use to set 'basic' setting for filament type

M300 S1000 P200 G4 P500 M300 S3000 P300                    	; Play some tones  

; Heater model parameters
M307 H0 R0.274 C466.5 D11.16 S1.00 V23.9					; Bed PID tune for 80c
M307 H1 R2.417 C126.7 D4.88 S1.00 V24.0 					; Hot end PID tune at 250c

M140 S85                                                   	; Set the bed temperature to 85c  
M104 S150                                                  	; Set the extruder warm-up temperature to 150c  
                                                           	; Note: actual extruder temperature will be set from the slicer  
 
; Insert additional filament specific settings here