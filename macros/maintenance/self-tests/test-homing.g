; =========================================================================================================
;
; Test Routine for Duet WiFi
; Part of self check
;
; for Caribou220 Duet3Mini+ Bondtech - SE HT Thermistor - SuperPINDA
;
; test homing
;
; =========================================================================================================
; Home X Axis
; =========================================================================================================
;
M98 P"0:/sys/homex.g"
M400
M291 P"Press OK if x axis is homed, else press CANCEL to exit." R"Homing test" S3
;
; =========================================================================================================
; Home Y Axis
; =========================================================================================================
;
M98 P"0:/sys/homey.g"
M400                              ; wait for current moves to finish
M291 P"Press OK if y axis is homed, else press CANCEL to exit." R"Homing test" S3
;
; =========================================================================================================
; Home Z Axis
; =========================================================================================================
;
G90                               ; absolute positioning
;
G1 X11.5 Y4.5 F6000               ; go to first probe point
G91                               ; relative positioning
G1 H2 Z5 F6000                    ; lift Z relative to current position
G30                               ; home Z by probing the bed
G1 Z0.15 F100                     ; move Z to origin
G91                               ; relative positioning
G1 Z1 F100                        ; lift Z relative to current position
G90                               ; absolute positioning
M400                              ; wait for current moves to finish
;
M400
M291 P"Press OK if z axis is homed, else press CANCEL to exit." R"Homing test" S3
;
; =========================================================================================================
;
M291 P"all ok" R"Homing test" S2
;
; =========================================================================================================
;
