; =========================================================================================================
;
;   testcode for printing a meander and a rectangle at the end to adjust babysteps
;
; =========================================================================================================
;
M291 R{"First layer calibration for PETG at 230°C."} P{"Press OK to continue or CANCEL to abort."}  S3
;
;====== print meander and square ==========================================================================
;
M32 0:/macros/maintenance/first-layer-calibration/gcodes/petg-first-layer-calibration.gcode
;
;====== end meander and square ============================================================================
