; #####################################################################
; #
; # Set the current and sensitivity for homing, non-printing routines
; #
; #####################################################################

;M569 P0.0 V10            ; reduce V to ensure stealthChop is enabled for x
;M569 P0.1 V10            ; reduce V to ensure stealthChop is enabled for y
M913 X30 Y30             ; drop motor current to 30%
G4 P100                  ; wait 100ms

; ######
; # Tune drivers
; ###############
G91                      ; relative positioning
G1 H2 X0.2 Y0.2 F3000    ; power up motors to ensure they are not stalled
G4 P100                  ; wait 100ms
M400                     ; wait for current moves to finish
G1 H2 X-0.2 Y-0.2 F3000  ; go back to the original position