; #####################################################################
; #
; # Start printing script
; #
; #####################################################################

T0                                                     	; ensure the tool is selected

; ######
; # Prepare for start
; ###############
M572 D0 S0.0                                           	; clear pressure advance.
M220 S100                                              	; set speed factor back to 100% in case it was changed
M221 S100                                              	; set extrusion factor back to 100% in case it was changed
M290 R0 S0                                             	; clear any baby-stepping
M106 S0                                                	; turn part cooling blower off if it is on
M703                                                   	; execute loaded filament's config.g

; ######
; # Gantry and mesh bed leveling
; ###############
;G32                                                    ; execute bed.g (level gantry)
;G29 S1                                                 ; load bed mesh for the system's set filament type

; ######
; # Try to load mesh from current filament
; # if it not exists perform mesh and save it to filaments directory
; ###############
G29 S1 P{"0:/filaments/" ^ move.extruders[0].filament ^ "/heightmap.csv"} ; Load bed mesh for the system's set filament type.
if result > 1                                              ; If the file doesn't exist, perform mesh and save.
   G29                                                     ; Perform mesh now.
   G29 S3 P{"0:/filaments/" ^ move.extruders[0].filament ^ "/heightmap.csv"} ; Save heightmap.csv to filament type's directory.

M400                                                   	; finish all moves, clear the buffer
G90                                                    	; absolute Positioning
M83                                                    	; extruder relative mode

; ######
; # Set motor current to normal before prnt
; ###############
M98 P"0:/sys/current-sense-normal.g"                   	; ensure that motor currents and sense are set for printing