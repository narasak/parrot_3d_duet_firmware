; 0:/macros/Maintenance/Hotmesh.g
; Called to perform automatic heated bedmesh compensation
; This saves the heightmap to the system's set filament's type directory (0:/filaments/XXXX/heightmap.csv)

if state.status = "processing"                             ; Printer is currently printing!
   M99                                                     ; Abort this macro

T0                                                         ; Ensure tool is selected
M703                                                       ; Heat bed to set temp based off current system filament type
M104 S-273                                                 ; Turn off hotend
M106 S0                                                    ; Turn part cooling blower off if it is on
M291 P{"Performing bed heatup per " ^ move.extruders[0].filament ^ " profile. This process will take approximately 6 minutes."} R"Hotmesh" S0 T10
G28                                                        ; Home
G1 X105 Y105                                               ; Place nozzle center of bed

; Give 5 minutes for stabilization
G91                                                        ; Set to Rel Positioning
while iterations <=9                                       ; Perform 10 passes
    G1 Z15 F300                                            ; Move Z 15mm up
    G4 S0.5                                                ; Wait .5 seconds
G1 Z3 F300                                                 ; Raise an additional 3mm
M116                                                       ; Wait for all temperatures
M291 P"Bed temperature at setpoint. Please wait 5 minutes for stabilization, Z indicates countdown." R"Hotmesh" S0 T10
; Start countdown - use Z as indicator
while iterations <=9                                       ; Perform 10 passes
    G4 S30                                                 ; Wait 30 seconds
    G1 Z-15 F300                                           ; Move Z 15mm down
G90                                                        ; Set to Absolute Positioning

M291 P"Performing homing, gantry alignment, and mesh probing. Please wait." R"Hotmesh" S0 T10
G32                                                        ; Home and Level gantry
M400                                                       ; Clear queue
M558 F50 A4 S-1                                            ; slow z-probe, take 5 probes and yield average
G29                                                        ; Perfrom bed mesh
G29 S3 [P{"0:/filaments/" ^ move.extruders[0].filament ^ "/heightmap.csv"}] ; Save heightmap.csv to filament type's directory
M558 F200 A1                                               ; normal z-probe
M104 S-273                                                 ; Turn off hotend
M140 S-273                                                 ; Turn off heatbed
M291 P"Hotmesh complete. Hotend and Heatbed are turned off. Performing final homing routine. Please wait." R"Hotmesh" S0 T10

G28                                                        ; Home
M18                                                        ; Free all