; #####################################################################
; #
; # Triggered by filament sensor mapping - used for autoload
; #
; #####################################################################

; ######
; # Play beep tune
; ###############
M300 S500 P600                                                   ; beep
G4 P2000                                                         ; wait two seconds

M581 P1 T2 S-1 R0                                                ; filament sensor does not listen anymore (S-1). Autoload is disabled.
T0                                                               ; activate hotend

; ######
; # Check filament
; ###############
if heat.heaters[1].current < 180                                 ; check temperature
    M98 P"0:/sys/functions/activate-run-out-sensor.g"              ; activate RunOut Sensor to check if filament is loaded
    M291 R"Hotend too cold. Preheat extruder first!" P"Please pull out filament!" S2 ; ask to preheat extruder
    while {sensors.filamentMonitors[0].status != "noFilament"}   ; check filament status
        M291 P"Please pull out filament!" S2                     ; ask to pull out filament
    M98 P"0:/sys/functions/filament-sensor-status.g"              ; macro to activtate RunOut Sensor when filament has been loaded successfully
    M99

; ######
; # Feeding filament
; ###############
M291 P"Feeding filament.... " S1 T25

G91                    ; set to Relative Positioning
G1 E90 F400            ; feed 90mm of filament at 400mm/min
G1 E15 F200            ; feed 15mm of filament at 200mm/min
G4 P1000               ; wait one second

; ######
; # Purge filament
; ###############
M98 P"0:/macros/filament-handling/purge-filament.g"          ; need to purge?

G1 E-0.5 F200           ; retract 0.5mm of filament at 400mm/min

; ######
; # Filament RunOut Sensor
; ###############
M98 P"0:/sys/functions/filament-sensor-status.g"                  ; activtate RunOut Sensor when filament has been loaded successfully