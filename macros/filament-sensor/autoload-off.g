; =========================================================================================================
;
;  turns the autoload OFF (only if filament sensor is enabled) and saves status to config-overrde.g
;
;  checks for filament on startup.
;        No filament = Run Macro "Activate_Autoload" to
;        activate Autoload Feature (trigger.2g in sys folder)
;
; =========================================================================================================
;
if {move.axes[0].workplaceOffsets[1] == 1}                                  ; if filament sensor is enabled
    M98 P"0:/sys/functions/activate-run-out-sensor.g"                         ; actiavte run out sensor
    G10 L2 P2 Y0                                                            ; save status into tool 2
    M500                                                                    ; save status to config-overrde.g
    M291 P"Autoload function is turned OFF." S2                             ; display new message
else
    M291 P"Filament sensor is turned OFF. Please turn sensor on first." S2  ; display new message
;
; =========================================================================================================
;
