; =========================================================================================================
;
; filament load macro
;
; for Caribou220 Duet3Mini+ Bondtech - SE HT Thermistor - SuperPINDA
;
; =========================================================================================================
;
if state.status == "processing"                                        ; printer is not currently printing!
   M291 S2 P"Cannot run during an ongoing print. Please run this macro when the printer is paused!" R"WARNING!"
   M99
;
T0                                                                     ; select tool
;
if heat.heaters[1].current < 180                                       ; check extrude temperature
    if heat.heaters[1].current < 180                                   ; check retract temperature
         M291 P"Hotend too cold. Preheat extruder first!" S2           ; ask to preheat extruder
        M99
;
if {move.axes[1].workplaceOffsets[1] == 1}                             ; if autoload is enabled
    M98 P"0:/sys/functions/activate-run-out-sensor.g"
;
M300 S500 P600                                                         ; beep
M291 R"Insert filament." P"Press OK to start feeding filament..." S2   ; display new message
M291 P"Feeding filament.... " S1
;
G91                                                                    ; set to Relative Positioning
G1 E90 F400                                          ; feed 90mm of filament at 400mm/min
G1 E15 F200                                                            ; feed 15mm of filament at 200mm/min
M400
M292
;
M98 P"0:/macros/filament-handling/purge-filament.g"               ; purging needed?
;
G1 E-0.5 F200                                                         ; retract 0.5mm of filament at 400mm/min
;
; =========================================================================================================
;
