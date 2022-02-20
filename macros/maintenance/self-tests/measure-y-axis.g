; =========================================================================================================
;
; macro to measure the real length of the y-axis
;
; =========================================================================================================
;
M208 Y0 S1                        ; set axis minima
M208 Y225 S0                      ; set axis minima
;
G91                               ; relative positioning
M98 P"current-sense-homing.g"     ; Ensure the current and sensitivity is set for homing routines.
;
G1 H2 Y0.5 F10000                 ; energise motor to ensure it is not stalled
M400                              ; wait for current moves to finish
G4 P200                           ; wait 200ms
;
G1 H2 Z5 F6000                    ; lift z axis relative to current position to avoid collisions
M400                              ; wait for current moves to finish
;
G1 H1 Y5 F1000                    ; move slowly away
G1 H1 Y-225 F3000                 ; move quickly to y axis endstop and stop there (first pass)
G1 H2 Y5 F1000                    ; go back a few mm
G1 H1 Y-10 F3000                  ; move slowly to y axis endstop once more (second pass)
;
G1 H3 Y225 F3000                  ; Move quickly to right y axis endstop and stop there (first pass)
;
; analyze measured value
;
if move.axes[1].min > 222.5
    M291 P{"y axis length: " ^ move.axes[1].min ^ "mm. ERROR: axis too long." } S1
elif move.axes[1].min < 220.5
    M291 P{"y axis length: " ^ move.axes[1].min ^ "mm. ERROR: axis too short." } S1
else
    M291 P{"y axis length: " ^ move.axes[1].min ^ "mm. Axis length ok." } S1
;
M208 Y-7.5 S1                     ; set axis minima
M208 Y214 S0                      ; set axis maxima. Would be nice to set to the measured value, not possible with RRF3.2
;
; because of the changed offsets we have to home again
;
G1 H1 Y-225 F3000                 ; move quickly to y axis endstop and stop there (first pass)
G1 H2 Y5 F1000                    ; go back a few mm
G1 H1 Y-10 F3000                  ; move slowly to y axis endstop once more (second pass)
;
G1 H2 Z-5 F6000                   ; lower z again
G90                               ; absolute positioning
;
M98 P"current-sense-normal.g"     ; Ensure the current and sensitivity is set for normal routines.
;
; =========================================================================================================
;
