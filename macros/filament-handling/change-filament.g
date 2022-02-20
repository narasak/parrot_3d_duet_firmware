; =========================================================================================================
;
; Macro to change filament (unloading / loading).
;
; for Caribou220 Duet3Mini+ Bondtech - SE HT Thermistor - SuperPINDA
;
; Assumption is that users has chosen the correct temperature!
;
; =========================================================================================================
;
if heat.heaters[1].current < 180                                          ; check extrude temperature
    if heat.heaters[1].current < 180                                      ; check retract temperature
        M291 P"Hotend too cold. Preheat extruder first!" S2               ; ask to preheat extruder
        M99
;
if state.status == "processing"                                           ; printer is currently printing!
    M25                                                                   ; pause printing
    G91                                                                   ; set relative positioning
    G1 Z5 F360                                                            ; lift z by 5mm
    M400                                                                  ; finish all moves, clear the buffer.

else
    T0                                                                    ; select tool
    if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
        G28                                                               ; home all axis without mesh bed level
;
G90                                                                       ; set absolute positioning
if  {move.axes[2].machinePosition < 80}                                   ; if z position is below 80mm
    G1 X200 Y0 Z80 F6000                                                  ; go to the parking position
else
    G1 X200 Y0 F6000                                                      ; go to the parking position
;
if heat.heaters[1].current < 180                                          ; check extrude temperature again
    if heat.heaters[1].current < 180                                      ; check retract temperature again
        M291 P"Hotend too cold. Preheat extruder first!" S2               ; ask to preheat extruder
        M99
;
M300 S500 P600                                                            ; beep
;
M291 R"Unloading Filament..." P"Press OK to start." S2                    ; display message
;
G91                                                                       ; set to relative positioning
M913 E100                                                                 ; set motor current to 100% of set current;
;
G1 E4 F300                                                                ; extrude 4mm of filament at 300mm/min
G1 E-8 F3000                                                              ; retract 8mm of filament at 3000mm/min
G1 E-95 F2500                                                             ; retract 95mm of filament at 2500mm/min
;
M400                                                                      ; finish all moves, clear the buffer.
M292
;
if {move.axes[0].workplaceOffsets[1] == 1}                                ; if filament sensor is enabled
    if {move.axes[1].workplaceOffsets[1] == 1}                            ; if autoload is enabled
        M98 P"0:/sys/functions/activate-run-out-sensor.g"                   ; update sensor status
        while {sensors.filamentMonitors[0].status != "noFilament"}        ; check filament status
            M291 P"Please pull out filament!" S2                          ; ask to pull out filament
else
    M291 P"Please pull out filament!" S2                                  ; ask to pull out filament
;
M400                                                                      ; finish all moves, clear the buffer.
;
M300 S500 P600                                                            ; beep
if {move.axes[0].workplaceOffsets[1] == 1}                                ; if filament sensor is enabled
    if {move.axes[1].workplaceOffsets[1] == 1}                            ; if autoload is enabled
        M98 P"0:/sys/functions/activate-autoload.g"                       ; update sensor status
        M291 P"Insert filament ... " S1                                   ; display new message
        while {move.axes[2].workplaceOffsets[1] == 1}
            M400
        M292
else
    M291 R"Insert filament." P"Press OK to start feeding filament..." S2  ; display new message
    M291 P"Feeding filament.... " S1                                      ; display new message
    G91                                                                   ; set to Relative Positioning
    G1 E90 F400                                                           ; feed 90mm of filament at 400mm/min
    G1 E15 F200                                                           ; feed 15mm of filament at 200mm/min
;
M400                                                                      ; finish all moves, clear the buffer.
;
if !{{move.axes[0].workplaceOffsets[1] == 1} && {move.axes[1].workplaceOffsets[1] == 1}}   ; only if autoload is enabled and sensor is active purging is done through trigger
    M98 P"0:/macros/filament-handling/purge-filament.g"               ; need to purge?
;
M98 P"0:/sys/functions/filament-sensor-status.g"                           ; update sensor status
;
if state.status == "paused"                                               ; printer is currently paused from printing!
    M291 P"Press OK to resume print." S2                                  ; display message
    M24                                                                   ; resume printing
;
; =========================================================================================================
;
