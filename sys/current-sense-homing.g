; 0:/sys/current-sense-homing.g
; Set the current and sensitivity for homing, non-printing, routines

M915 P0.0 S1 R0 F0 H400		    		; X sensitivity 1, don’t take action, don’t filter, 400steps/sec
M915 P0.1 S1 R0 F0 H400		    		; Y sensitivity 1, don’t take action, don’t filter, 400steps/sec
M913 X55 Y55 Z50                  		; Set the X, Y, and Z drivers current percentage for non-print moves, per config.g.