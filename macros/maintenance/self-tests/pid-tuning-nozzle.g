; =========================================================================================================
;
; Test Routine for Duet WiFi
; Part of self check
;
; PID tuning Nozzle
;
; =========================================================================================================
;
M291 P"Press OK if target for nozzle is 210°C." R"PID tuning nozzle" S3
;
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28                      	; home all axis without mesh bed level
G90                       	; absolute positioning
G0 X60 Y-3 Z160            	; move extruder above bed
;
M106 P0 S255				; start print part fan 100%
M303 H1 S210               	; start PID tuning for 210°C
;
M291 R"PID tuning NOZZLE started" P"When tuning is completed, enter M500 to console to save to config-Override.g!" S1
;
; =========================================================================================================
;
