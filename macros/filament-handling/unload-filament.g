; =========================================================================================================
;
; filament unload macro
;
; for Caribou220 Duet3Mini+ Bondtech - SE HT Thermistor - SuperPINDA
;
; =========================================================================================================
;
if state.status == "processing"                                    ; printer is not currently printing!
   M291 S2 P"Cannot run during an ongoing print. Please run this macro when the printer is paused!" R"WARNING!"
   M99
;
T0                                                                 ; select tool
;
if heat.heaters[1].current < 180                                   ; check extrude temperature
    if heat.heaters[1].current < 180                               ; check retract temperature
        M291 P"Hotend too cold. Preheat extruder first!" S2        ; ask to preheat extruder
        M99
;
M291 R"Unloading Filament..." P"Press OK to start." S2             ; display message
;
G91                                                                ; set to Relative Positioning
M913 E100                                                          ; set motor current to 100% of set current;
;
G1 E4 F300                                                         ; extrude 4mm of filament at 300mm/min
G1 E-8 F3000                                                       ; retract 8mm of filament at 3000mm/min
G1 E-95 F2500                                    ; retract 95mm of filament at 2500mm/min
;
M400
M292
;
if {move.axes[1].workplaceOffsets[1] == 1}                         ; if autoload is enabled
    M98 P"0:/sys/functions/activate-run-out-sensor.g"
    while {sensors.filamentMonitors[0].status != "noFilament"}     ; check filament status
        M291 P"Please pull out filament!" S2                       ; ask pull out filament
;
if {move.axes[0].workplaceOffsets[1] == 1}                         ; if filament sensor is active
    if {move.axes[1].workplaceOffsets[1] == 1}                     ; if autoload is active
        M98 P"0:/sys/functions/activate-autoload.g"                ; activate autoload
;
; =========================================================================================================
;
