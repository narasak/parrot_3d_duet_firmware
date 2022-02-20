; =========================================================================================================
;
; macro to measure the real length of the x-axis
;
; =========================================================================================================
;
;
M208 X0 S1                        ; set axis minimum
M208 X260 S0                      ; set axis maximum
;
G91                               ; relative positioning
;
M98 P"current-sense-homing.g"     ; Ensure the current and sensitivity is set for homing routines.
;
G1 H2 X0.5 F10000                 ; energise motor to ensure it is not stalled
M400                              ; wait for current moves to finish
G4 P200                           ; wait 200ms
;
G1 H2 Z5 F6000                    ; lift z axis relative to current position to avoid collisions
M400                              ; wait for current moves to finish
;
G1 H1 X5 F1000                    ; move slowly away
G1 H1 X-260 F3000                 ; move quickly to x axis endstop and stop there (first pass)
G1 H2 X5 F1000                    ; go back a few mm
G1 H1 X-10 F3000                  ; move slowly to x axis endstop once more (second pass)
;
G1 H3 X260 F3000                  ; Move quickly to right x axis endstop and stop there (first pass)
;
; analyze measured value
;
if move.axes[0].min > 256.8
    M291 P{"x axis length: " ^ move.axes[0].min ^ "mm. ERROR: axis too long." } S1
elif move.axes[0].min < 255.2
    M291 P{"x axis length: " ^ move.axes[0].min ^ "mm. ERROR: axis too short." } S1
else
    M291 P{"x axis length: " ^ move.axes[0].min ^ "mm. Axis length ok." } S1
;
M208 X-2 S1                       ; set axis minimum
M208 X254.6 S0                    ; set axis maximum. Would be nice to set to the measured value, not possible with RRF3.2
;
; because of the changed offsets we have to home again
;
G1 H1 X-260 F3000                 ; move quickly to y axis endstop and stop there (first pass)
G1 H2 X5 F1000                    ; go back a few mm
G1 H1 X-10 F3000                  ; move slowly to x axis endstop once more (second pass)
;
G1 H2 Z-5 F6000                   ; lower z again
G90                               ; absolute positioning
;
M98 P"current-sense-normal.g"     ; Ensure the current and sensitivity is set for normal routines.
;
; =========================================================================================================
;
