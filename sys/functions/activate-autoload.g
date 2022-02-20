; #####################################################################
; #
; # Filament sensor gets ready for next load
; #
; #####################################################################

M591 D0 P0 C"e0stop" S1           ; enable filament runout sensor
M950 J1 C"nil"                    ; free input 1 e0 filament sensor
M950 J1 C"io5.in"                 ; input 1 e0 filament sensor
M581 P1 T2 S0 R0                  ; filament sensor P1 triggers Trigger1.g always (R0)
G10 L2 P2 Z1                      ; save status into tool 2