; #####################################################################
; #
; # Checks for filament and switches status of the sensor
; #
; #      No filament = Run Macro "Activate_Autoload" to
; #      activate Autoload Feature (trigger.2g in sys folder)
; #
; #####################################################################

if {move.axes[0].workplaceOffsets[1] == 1}                   ; if filament sensor is enabled
    M98 P"0:/sys/functions/activate-run-out-sensor.g"
    if {sensors.filamentMonitors[0].status == "noFilament"}  ; activates autoload function when no filament loaded
        if {move.axes[1].workplaceOffsets[1] == 1}           ; if autoload is active
            M98 P"0:/sys/functions/activate-autoload.g"