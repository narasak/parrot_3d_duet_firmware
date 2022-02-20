; =========================================================================================================
;
;    turns the filament sensor ON and saves status to config-overrde.g
;
; =========================================================================================================
;
if {move.axes[0].workplaceOffsets[1] != 1}
    M98 P"0:/sys/functions/activate-run-out-sensor.g"
    G10 L2 P2 X1.00                                     ; save status into tool 2
    M500                                                ; save status to config-overrde.g
M291 P"Filament sensor is turned ON." S2                ; display new message
;
; =========================================================================================================
;
