; =========================================================================================================
;
; with this macro you can set the sensor trigger height for a certain print surface / nozzle combination
; you have to set the correct value in line 8 and the remove the semicolon in front
;
; =========================================================================================================
;
;G31 Z1.12                                       ; Thekkiinngg sheet and E3d brass nozzle
M500 P10:31                                     ; save settings to config-overide.g - G31 P31 saves trigger height
M290 R0 S0                                      ; set babystep to 0mm absolute
;
M291 P{"Settings for Thekkiinngg sheet and E3d brass nozzle. Set probe offset to " ^ sensors.probes[0].triggerHeight  } S2
;
; =========================================================================================================
;
