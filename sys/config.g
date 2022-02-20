; #####################################################################
; #
; # General preferences
; #
; #####################################################################

M550 P"Parrot 3D"                                  		; set printer name

; #####################################################################
; #
; # Configure Dynamic Acceleration Adjustment
; #
; #####################################################################
M593 P"daa" F93.2  									; cancel ringing at 156.50Hz
;M593 P"zvd" F156.5  									; use ZVD input shaping to cancel ringing at 156.50Hz

; #####################################################################
; #
; # Drivers
; #
; #####################################################################
M569 P0.0 S0 D3 V2000                  					; physical drive 0.0 goes backwards : x-axis
M569 P0.1 S1 D3 V2000                         			; physical drive 0.1 goes forwards : y-axis
M569 P0.2 S1 D3 V1000                        			; physical drive 0.2 goes forwards : z-left
M569 P0.3 S1 D3 V1000                        			; physical drive 0.3 goes forwards : z-right
M569 P0.4 D3 V1000                           			; physical drive 0.4 goes forwards : extruder

; ######
; # Drivers mapping
; ###############
M584 X0.0 Y0.1 Z0.2:0.3 E0.4                       		; set drive mapping

; ######
; # Leadscrew Left and Right position
; ###############
M671 X-36.5:293.5 Y0:0 S1.00                           	; leadscrews at left (connected to Z) and right (connected to E1) of X axis

; ######
; # Idle timeout
; ###############
M84 S60                                            		; Set idle timeout

; ######
; # Printer
; ###############
;M201 X1250.00 Y1250.00 Z200.00 E5000.00              	; set accelerations (mm/s^2)
M201 X500.00 Y500.00 Z200.00 E500.00              		; set accelerations (mm/s^2)
;M203 X12000.00 Y12000.00 Z1200.00 E12000.00            ; set maximum speeds (mm/min) [XY-200mm/s, Z-20mm/s, E-200mm/s]
M203 X9000.00 Y9000.00 Z1200.00 E3600.00               	; set maximum speeds (mm/min)
;M204 P1250.00 T1250.00                                 ; set print and travel accelerations (mm(s^2)
M204 P500.0 T500.0                                     	; set print and travel accelerations (mm(s^2)
;M566 X600.00 Y600.00 Z12.00 E150.00 P1                	; set maximum instantaneous speed changes (mm/min) [Jerk]
M566 X480.00 Y480.00 Z48.00 E300.00                    	; set maximum instantaneous speed changes (mm/min)

; ######
; # Allow unhomed movement
; ###############
M564 H0                                                ; allow unhomed movement

; #####################################################################
; #
; # Motor Configuration
; #
; #####################################################################

; ######
; # Microstepping
; ###############
;M350 X256 Y256 Z256 E256 I0                            	; configure microstepping with no interpolation
;M92 X3200.00 Y3200.00 Z6400.00 E6400.00               		; set steps per mm (LGX)
M350 X256 Y256 E256 I0                            			; configure microstepping with no interpolation
M350 Z32 I1                            						; configure microstepping with interpolation
M92 X3200.00 Y3200.00 E6400.00               				; set steps per mm (LGX)
M92 Z800.00               									; set steps per mm

; ######
; # Motor current
; ###############
M906 X1200 Y1200 Z500 E550 I40                    		; set motor currents (mA) and motor idle factor in per cent

; ######
; # Axis Limits
; ###############
M208 X-2 Y-7.5 Z0 S1                                   ; set axis minima
M208 X253.6 Y213 Z225.50 S0                            ; set axis maxima

; ######
; # Stallguard Sensitivy
; ###############
M915 X S1 F0 H200 R0                                   ; set X axis Sensitivity
M915 Y S1 F0 H200 R0                                   ; set Y axis Sensitivity
M915 Z S1 F0 H200 R0                                   ; set Z axis Sensitivity

; #####################################################################
; #
; # Endstops
; #
; #####################################################################
M574 X1 S3                                             ; configure sensorless endstop for low end on X
M574 Y1 S3                                             ; configure sensorless endstop for low end on Y
M574 Z1 S2                                             ; configure Z-probe endstop for low end on Z
M574 Z2 S3                                             ; configure sensorless endstop for high end on Z

; #####################################################################
; #
; # Probe
; #
; #####################################################################

; ######
; # Super P.I.N.D.A.
; ###############
;M558 P5 C"^io4.in" H1.5 F600 T8000 A3 S0.03            ; set z probe to SuperPINDA
;M557 P3:3 X23:235 Y5:186								; define mesh grid 3x3 Point
;M574 Z1 S2                                             ; set endstops controlled by probe

; ######
; # BLTouch
; ###############
M950 S0 C"io4.out" 										; Duet 3 MB6HC
M558 P9 C"^io4.in" H2.5 F400 T8000 A1 S0.03            	; for BL-Touch
;M557 P3:3 X23:235 Y5:186								; define mesh grid 3x3 Point
M557 P3:3 X10:220 Y1:150								; define mesh grid 3x3 Point
M574 Z1 S2                                             	; set endstops controlled by probe

; ######
; # Offsets - place off-sets for x and y here. z-offsets are handled in the print sheet macros
; ###############
G31 P1000 X-24.679 Y-54.623 Z2.20

; #####################################################################
; #
; # Heater & Fans
; #
; #####################################################################

; ######
; # Heated bed
; ###############
M308 S0 P"temp0" Y"thermistor" A"Build Plate" T100000 B4138		; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out1" Q50 T0                                 			; create bed heater output on out1 and map it to sensor 0
M143 H0 S120                                       				; set temperature limit for heater 0 to 120C
M307 H0 B0 S1.00                                   				; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                            				; map heated bed to heater 0

; ######
; # Hotend (Mosquito with SE Thermistor) 
; ###############
;M308 S1 P"temp1" Y"thermistor" A"Slice Engineering" T100000 B4680 C6.455513e-8 	; configure sensor 1 as thermistor on pin temp1 300C
M308 S1 P"temp1" Y"thermistor" A"Slice Engineering" T500000 B4723 C1.196220e-7 	; configure sensor 1 as thermistor on pin temp1 500C
;M308 S1 P"temp1" Y"thermistor" A"E3D" T100000 B4725 C7.06e-8 			; configure sensor 1 as thermistor on pin temp1
M950 H1 C"out2" T1                                 						; create nozzle heater output on out2 and map it to sensor 1
M307 H1 B0 S1.00                                   						; disable bang-bang mode for heater and set PWM limit
M143 H1 S365                                       						; set temperature limit for heater 1 to 365C

; ######
; # Extruder fan (temerature controlled)
; ###############
M950 F1 C"out9" Q500                           			; create fan 1 on pin out9 and set its frequency
M106 P1 C"Hot End" H1 T45                       		; set fan 1 name and value. Thermostatic control is turned on

; ######
; # Radial fan
; ###############
M950 F0 C"out8" Q25                            				; create fan 0 on pin out8 and set its frequency
M106 P0 C"Printed" S0 H-1                          		; set fan 0 name and value. Thermostatic control is turned off

; #####################################################################
; #
; # Tools
; #
; #####################################################################
M563 P0 S"LGX" D0 H1 F0                             	; define tool 0
G10 P0 X0 Y0 Z0                                        	; set tool 0 axis offsets
G10 P0 S-274 R-274                                     	; turn off tool 0, set active and standby temperature to 0K
M302 S180 R180                                         	; allow extrusion starting from 180°C and retractions already from 180°C

; #####################################################################
; #
; # Other settings
; #
; #####################################################################
M18 XY                                                 ; release / unlock X, Y
M501                                                   ; use config-override (for Thermistor Parameters and other settings)
G90                                                    ; send absolute coordinates...
M83                                                    ; ... but relative extruder moves

; #####################################################################
; #
; # Filament handling
; #
; #####################################################################

; ######
; # Execute macros that has the status of the filament sensor
; ###############
M98 P"0:/sys/functions/filament-sensor-status.g"
