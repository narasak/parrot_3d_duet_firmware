; =========================================================================================================
;
; display the status of the filament sensor
;
; =========================================================================================================
;
if {move.axes[0].workplaceOffsets[1] == 1}                                      ; if filament sensor is active
    M98 P"0:/sys/functions/activate-run-out-sensor.g"
    if {sensors.filamentMonitors[0].status = "ok"}                              ; if filament is loaded
        if {move.axes[1].workplaceOffsets[1] == 1}                              ; if autoload is enabled
            M291 R{"Filament Sensor"} P{"Status: ON, Autoload: ON, Filament: LOADED "  } S2
        else
            M291 R{"Filament Sensor"} P{"Status: ON, Autoload: OFF, Filament: LOADED "  } S2
    else                                                                         ; filament not loadad
        if {move.axes[1].workplaceOffsets[1] == 1}                               ; if autoload is not enabled
            M291 R{"Filament Sensor"} P{"Status: ON, Autoload: ON, Filament: NOT LOADED "  } S2
        else
            M291 R{"Filament Sensor"} P{" Status: ON, Autoload: OFF, Filament: NOT LOADED "  } S2

        if sensors.filamentMonitors[0].status == "noFilament"                     ; activates autoload function when no filament loaded
            if {move.axes[1].workplaceOffsets[1] == 1}                            ; if autoload is active
                M98 P"0:/sys/functions/activate-autoload.g"
else                                                                              ; filament sensor not active
    M291 P{"Filament Sensor Status: OFF"  } S2
;
; =========================================================================================================
;
