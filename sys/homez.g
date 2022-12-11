; #####################################################################
; #
; # Home xyz Axis
; #
; # for Parrot 3D BL-Touch
; #
; #####################################################################

G91                                                    ; relative positioning

; ######
; # Change motor current for homing
; ###############
M98 P"current-sense-homing.g"                          ; ensure the current and sensitivity is set for homing routines.

G1 H2 X0.5 F10000                                      ; energise motors to ensure they are not stalled
M400                                                   ; wait for current moves to finish
G4 P200                                                ; wait 200ms

; ######
; # Move Z-Axis
; ###############
G1 H2 Z5 F6000                                         ; lift Z relative to current position
M400                                                   ; wait for current moves to finish

; ######
; # Home X-Axis
; ###############
G1 H1 X5 F1000                                         ; move slowly away
G1 H1 X-260 F2200                                      ; move quickly to x axis endstop and stop there (first pass)
G1 H2 X5 F1000                                         ; go back a few mm
G1 H1 X-10 F2200                                       ; move slowly to x axis endstop once more (second pass)

; ######
; # Home Y-Axis
; ###############
M400                                                   ; wait for current moves to finish
G1 H2 Y0.5 F10000                                      ; energise motors to ensure they are not stalled
M400                                                   ; wait for current moves to finish
G1 H1 Y5 F1000                                         ; move slowly away
G1 H1 Y-260 F2400                                      ; move quickly to x axis endstop and stop there (first pass)
G1 H2 Y5 F1000                                         ; go back a few mm
G1 H1 Y-10 F2400                                       ; move slowly to x axis endstop once more (second pass)

; ######
; # Waiting
; ###############
M400                                                   ; wait for current moves to finish
M913 X156 Y42.5                                        ; return x & y motor
G4 P200                                                ; wait 200ms

G90                                                    ; absolute positioning

; ######
; # Home Z-Axis
; ###############
G90                                                    ; absolute positioning
M280 P0 S160                                           ; BLTouch, alarm release
G4 P100                                                ; BLTouch, delay for the release command
G1 X156 Y150 F3600                                     ; go to center of the bed
G30                                                    ; home z by probing the bed
G1 Z1.15 F100                                          ; move z to origin and 1.15mm above bed
G90                                                    ; absolute positioning
M400                                                   ; wait for current moves to finish

G90                                                    ; absolute positioning

; ######
; # Change motor current back to normal
; ###############
M98 P"current-sense-normal.g"                          ; ensure the current and sensitivity is set for normal routines.