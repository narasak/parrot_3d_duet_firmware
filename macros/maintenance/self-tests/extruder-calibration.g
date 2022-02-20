; =========================================================================================================
;
; calibrate extruder esteps for PLA at 215°C
;
; =========================================================================================================
;
M291 P"Press OK to continue or CANCEL to abort." R"Run extruder calibration for PLA at 215°C?" S3
;
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28                         ; home all axis without mesh bed level
G90                           ; absolute positioning
G0 X60 Y-3 Z80                ; move extruder above bed, keep extruder in front for cleaning and checking
;
T0                            ; select tool 0
M104 S215                     ; pre-heat extruder to 215°C
;
M291 S2 R"Heating to 215°C" P"Mark 120mm on filament from top of extruder body."
;
M116                          ; wait for temp to 215°C
;
M291 S2 R"Temperature reached. Extruding 100mm filament at 1mm/s" P"Press OK to start."
;
M83                           ; relative extrusion
G1 E100 F60                   ; extrude 100mm of filament at 1mm/s
M400                          ; wait for moves to finish
G10 P0 S-274 R-274            ; turn off extruder
;
M291 S2 R"Measure distance to mark and update e steps in config.g." P{"new_e_steps = " ^ move.extruders[0].stepsPerMm ^ " * (100 / (120 - distance_to_mark_in_mm))"}
M291 S2 P"Repeat test to verify." R"Extruder calibration done."
;
; =========================================================================================================
;
