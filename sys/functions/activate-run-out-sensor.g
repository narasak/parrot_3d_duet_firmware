; #####################################################################
; #
; # Activates the RunOutSensor
; #
; #####################################################################

M581 P1 T2 S-1 R0                 ; filament sensor P1 triggers Trigger2.g always (R0)  TRIGGER OFF
M950 J1 C"nil"                    ; free input 1 e0 filament sensor
M591 D0 P2 C"io5.in" S1           ; filament runout sensor;
G10 L2 P2 Z0                      ; save status into tool 2