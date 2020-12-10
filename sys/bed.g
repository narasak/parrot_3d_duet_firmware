; 0:/sys/bed.g
; Called to perform automatic bed compensation via G32

M561                                                       	; Clear any existing bed transform.
G28                                                        	; Home all axis.

G30 P0 X25 Y98 Z-99999                                 		; Probe near a leadscrew, halfway along Y-axis.
G30 P1 X222 Y98 Z-99999 S2                             		; Probe near a leadscrew and calibrate 2 motors.
G1 X104 F10000                                          	; Move to the center of the bed.
G30                                                     	; Probe the bed at the current XY position.
M400                                                    	; Finish all moves, clear the buffer.

M558 F200 A1                                               	; Set normal z-probe speed.
echo "Gantry deviation of " ^ move.calibration.initial.deviation ^ "mm obtained."
G1 Z8                                                      	; Raise nozzle 8mm to ensure it is above the Z probe trigger height.