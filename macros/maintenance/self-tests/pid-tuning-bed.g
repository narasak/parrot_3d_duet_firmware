; =========================================================================================================
;
; Test Routine for Duet WiFi
; Part of self check
;
; PID tuning Heated bed
;
; =========================================================================================================
;
M291 P"Press OK if target for heated bed is 80°C." R"PID tuning heated bed" S3
;
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28                      ; home all axis without mesh bed level
G90                        ; absolute positioning
G0 X60 Y-3 Z80             ; move extruder above bed,
;
M303 H0 S80                ; start PID tuning for 80°C
;
M291 R"PID tuning BED started" P"When tuning is completed, enter M500 to console to save to config-Override.g!" S1
;
; =========================================================================================================
;
