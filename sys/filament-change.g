; #####################################################################
; #
; # Filament change
; #
; #####################################################################

M98 P"0:macros/filament-handling/change-filament.g"
;M98 P"0:/sys/functions/filament-sensor-status.g"                           ; update sensor status
M291 P"Press OK to resume print." S2                                   ; display message
M24                                                                    ; recover the last state pushed onto the stack.
