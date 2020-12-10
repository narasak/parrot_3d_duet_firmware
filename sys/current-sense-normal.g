; 0:/sys/current-sense-normal.g
; Set the current and sensitivity for normal routines

M913 X100 Y100 Z100      			; Set the X, Y, and Z drivers to 100% of their normal current per config.g.
M915 P0.0 S50 R2 F0 H200		    ; X sensitivity 0, tuned stall detection and pause the print automatically when a stall is detected., don’t filter, 200steps/sec
M915 P0.1 S50 R2 F0 H200		    ; Y sensitivity 1, tuned stall detection and pause the print automatically when a stall is detected., don’t filter, 200steps/sec