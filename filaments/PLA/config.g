; 0:/filaments/PLA/config.g
; Macro use to set 'basic' setting for filament type

M300 S1000 P200 G4 P500 M300 S3000 P300                    	; Play some tones  

; Heater model parameters
M307 H0 A129.4 C509.3 D8.5 S1.0 V23.8 B0					; Bed PID tune for 60c
M307 H1 A317.8 C88.2 D2.6 S1.0 V24.0 B0						; Hot end PID tune at 210c

M140 S60                                                   	; Set the bed temperature to 60c  
M104 S150                                                  	; Set the extruder warm-up temperature to 150c  
                                                           	; Note: actual extruder temperature will be set from the slicer  
 
; Insert additional filament specific settings here