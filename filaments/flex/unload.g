; #####################################################################
; #
; # Prepare to un-load FLEX at 240°C
; #
; #####################################################################

; ######
; # Display message
; ###############
M291 P"Prepare for filament un-loading. Please wait while the nozzle is being heated up. Press OK to continue or CANCEL to abort." R"Unloading FLEX at 240°C" S3;
M291 P"Please wait while the nozzle is being heated up" R"Heating: 240°C" T30 ; Display message

; ######
; # Set temp and wait for the temp to be reached
; ###############
G91                                                    ; relative positioning
G1 Z20 F6000 H2                                        ; lift Z relative to current position
M104 S240                                               ; set current tool temperature to filament 240°C
M116                                                   ; wait for the temperatures to be reached

; ######
; # Call unload filament
; ###############
M98 P"0:/macros/filament-handling/unload-filament.g"  ; execute macro to unload filament
