; =========================================================================================================
;
;    turns the filament sensor OFF and saves status to config-overrde.g
;
; =========================================================================================================
;
if {move.axes[0].workplaceOffsets[1] != 0}
    M950 J1 C"nil"                                     ; free input 1 e0 filament sensor
    M591 D0 P0 C"e0_stop" S0                           ; turn filament sensor OFF
    G10 L2 P2 X0                                       ; save status into tool 2
    M500                                               ; save status to config-overrde.g
M291 P"Filament sensor is turned OFF." S2              ; display new message
;
; =========================================================================================================
;
