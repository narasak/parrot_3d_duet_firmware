; =========================================================================================================
;
; Test Routine for Duet WiFi
; Part of self check
;
; check fans
;
; =========================================================================================================
;
M106 P0 S255                     ; set front fan to full speed
;
M291 P"Press OK if front fan is FULL on, else press CANCEL to exit." R"FRONT fan test" S3
;
M106 P0 S150                     ; set front fan to medium speed
;
M291 P"Press OK if front fan is running at MEDIUM speed, else press CANCEL to exit." R"FRONT fan test" S3
;
M106 P0 S0                       ; set front fan off
;
M291 P"Press OK if front fan is OFF, else press CANCEL to exit." R"FRONT fan test" S3
;
M106 P1 H1 T0                    ; set minimum temperature to 0°C so that fan should turn on, don't turn temperature control off!!!
;
M291 P"Press OK if left fan is FULL on, else press CANCEL to exit." R"EXTRUDER fan test" S3
;
M106 P1 H1 T45                   ; set minimun temperature back to 45°C
;
M291 P"Press OK if left fan is OFF, else press CANCEL to exit." R"EXTRUDER fan test" S3

M291 P"all ok" R"FAN test" S2
;
; =========================================================================================================
;
