; #####################################################################
; #
; # Bed compensation via G32
; #
; #####################################################################

M561                                                   ; clear any existing bed transform
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
        G28                                            ; home all axis without mesh bed level
;
M558 F50 A1 S0.01                                      ; slow z-probe, up to 5 probes until disparity is 0.003 or less - else yield average
while iterations < 1                                   ; perform 3 passes
   G30 P0 X30 Y116 Z-99999                               ; probe near a leadscrew, half way along Y axis
   G30 P1 X220 Y116 Z-99999 S2                           ; probe near a leadscrew and calibrate 2 motors
   G1 X156 F10000                                      ; move to the center of the bed
   G30                                                 ; probe the bed at the current xy position
   M400                                                ; finish all moves, clear the buffer
;
M558 F50 A1 S-1                                        ; slow the z-probe, perform 5 probes and yield the average
while move.calibration.initial.deviation >= 0.40       ; perform additional leveling if previous deviation was over 0.003mm
   if iterations = 1                                   ; perform 5 addition checks, if needed
      M300 S3000 P500                                  ; sound alert, the required deviation could not be achieved
      M558 F200 A1                                     ; set normal z-probe speed
      abort "!!! ABORTED !!! Failed to achieve < 0.40 deviation. Current deviation is " ^ move.calibration.initial.deviation ^ "mm."
      G30 P0 X30 Y116 Z-99999                            ; probe near a leadscrew, half way along Y axis
      G30 P1 X220 Y116 Z-99999 S2                        ; probe near a leadscrew and calibrate 2 motors
   G1 X156 F10000                                      ; move the nozzle to the center of the bed
   G30                                                 ; probe the bed at the current XY position
   M400                                                ; finish all moves, clear the buffer
;
M558 F400 T8000 A1 S0.03                               ; for BL-Touch
;
echo "Gantry deviation of " ^ move.calibration.initial.deviation ^ "mm obtained."
;
G1 Z8                                                  ; raise nozzle 8mm to ensure it is above the z probe trigger height