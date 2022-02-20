; =========================================================================================================
;
;  Preheat for PC at 275°C
;
; =========================================================================================================
;
M291 P"Press OK to continue or CANCEL to abort." R"Heat up for PC at 275°C?" S3
;
T0                                            ; select tool
G91                                           ; relative positioning
G1 Z20 F6000 H2                               ; lift Z relative to current position
G90                                           ; absolute positioning
M104 S275                                     ; set current tool temperature to filament 275°C
;
; =========================================================================================================
;
