; =========================================================================================================
;
; Test Routine for Duet WiFi
; Part of self check
;
; check heaters
;
; =========================================================================================================
;
M291 P"Checking heaters" S3
;
;
G28                         ; home all without mesh bed level
G0 X60 Y-3 Z80              ; move extruder above bed  keep extruder in front for cleaning and checking
;
M570 H1 P120 T120            ; extend the heater H1 fault timeout to 120 seconds for testing
M570 H0 P120 T120            ; same for H0
;
;
; =========================================================================================================
;
; Start heating bed to 60°C
;
M291 P"Wait until bed is heated up to to 60°C" S3
;
M140 S60                   ; set bed temperature
M190 S60                   ; wait for bed temperature
;
M140 S0                    ; turn off Bed
;
; =========================================================================================================
;
M291 P"Wait until nozzle is heated up to to 215°C" S3
;
; start heating hotend
;
M104 S215                  ; set extruder temperature
M109 S215                  ; wait for extruder temp
;
M104 S0                    ; turn off extruder
;
M291 P"all ok" R"HEATER test" S2
;
; =========================================================================================================
;
