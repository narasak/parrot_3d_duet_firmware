; #####################################################################
; #
; # general settings
; #
; #####################################################################
M111 S0 					                                           ; debugging off
G21 					                                               ; work in millimetres

; #####################################################################
; #
; # General preferences
; #
; #####################################################################
M550 P"Parrot 3D"                                  		; set printer name
M200 D1.75          									; set all extruder filament diameters to 1.75mm

; #####################################################################
; #
; # Configure Dynamic Acceleration Adjustment
; #
; #####################################################################
;M955 P0 C"spi.cs3+spi.cs2" 								; all wires connected to temp DB connector
M593 P"zvdd" F81.2										; use ZVDD input shaping to cancel ringing at 34.4Hz

; #####################################################################
; #
; # Drivers
; #
; #####################################################################

; ######
; # Port config
; ###############
M569 P0.0 S0 D3                  						; physical drive 0.0 goes backwards : x-axis enabled stealthChop2
M569 P0.1 S1 D3                         				; physical drive 0.1 goes forwards : y-axis enabled stealthChop2
M569 P0.2 S1 D3                        					; physical drive 0.2 goes forwards : z-left enabled stealthChop2
M569 P0.3 S1 D3                        					; physical drive 0.3 goes forwards : z-right enabled stealthChop2
M569 P0.4 D3                           					; physical drive 0.4 goes forwards : extruder enabled stealthChop2

; ######
; # Drivers mapping
; ###############
M584 X0.0 Y0.1 Z0.2:0.3 E0.4                       		; set drive mapping

; ######
; # Leadscrew Left and Right position
; ###############
M671 X-36.5:293.5 Y0:0 S1.00                           	; leadscrews at left (connected to 0.2) and right (connected to 0.3) of X axis

; #####################################################################
; #
; # Motor Configuration
; #
; #####################################################################

; ######
; # Microstepping
; ###############
M350 X16 Y16 Z16 E16 I1                            		; configure microstepping with interpolation
M92 X200.00 Y200.00 Z400.00 E400.00               		; set steps per mm (LGX)

; ######
; # Motor current
; ###############
M906 X1400 Y1400 Z650 E800 I40							; set motor currents (mA) [70%] and motor idle factor in per cent

; ######
; # Idle timeout
; ###############
M84 S60                                            		; Set idle timeout

; ######
; # Set Speed
; ###############
;M201 X1000.00 Y1000.00 Z200.00 E5000.00              	; Sets the acceleration that axes can do in mm/second^2 for print moves.
;M203 X12000.00 Y12000.00 Z720.00 E7200.00             	; Sets the maximum feedrates that your machine can do in mm/min [XY-200mm/s, Z-12mm/s, E-120mm/s]
;M204 P1250.00 T1250.00                                 	; Set printing and travel accelerations (mm(s^2)
;M566 X480.00 Y480.00 Z24.00 E270.00 P1                	; Set max instantaneous speed change in mm/min [Jerk]
M201 X2500.00 Y2500.00 Z200.00 E10000.00              	; Sets the acceleration that axes can do in mm/second^2 for print moves.
M203 X12000.00 Y12000.00 Z720.00 E7200.00             	; Sets the maximum feedrates that your machine can do in mm/min [XY-200mm/s, Z-12mm/s, E-120mm/s]
M204 P2500.00 T2500.00                                 	; Set printing and travel accelerations (mm(s^2)
M566 X480.00 Y480.00 Z12.00 E150.00 P1                	; Set max instantaneous speed change in mm/min [Jerk]

; ######
; # Allow unhomed movement
; ###############
M564 H0                                                	; allow unhomed movement

; #####################################################################
; #
; # Printer Configuration
; #
; #####################################################################

; ######
; # Axis Limits
; ###############
M208 X0 Y0 Z0 S1                                   	   	; set axis minima
M208 X250.0 Y210.0 Z230.00 S0                          	; set axis maxima

; #####################################################################
; #
; # Endstops
; #
; #####################################################################

M574 X1 S3                                             	; configure sensorless endstop for low end on X
M574 Y1 S3                                             	; configure sensorless endstop for low end on Y
M574 Z1 S2                                             	; configure Z-probe endstop for low end on Z
M574 Z2 S3                                             	; configure sensorless endstop for high end on Z

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
M557 P3:3 X30:220 Y5:170								; define mesh grid 3x3 Point
M574 Z1 S2                                             	; set endstops controlled by probe

; ######
; # Stallguard Sensitivy
; ###############
M915 X S2 F0 H200 R0                                   	; set X axis Sensitivity
M915 Y S2 F0 H200 R0                                   	; set Y axis Sensitivity
M915 Z S1 F0 H200 R0                                    ; set z axis sensitivity

; #####################################################################
; #
; # Heater & Fans
; #
; #####################################################################

; ######
; # Heated bed
; ###############
M308 S0 P"temp0" Y"thermistor" A"Build Plate" T100000 B4138							; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out1" Q50 T0                                 								; create bed heater output on out1 and map it to sensor 0
M143 H0 S120                                       									; set temperature limit for heater 0 to 120C
M307 H0 B0 S1.00                                   									; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                            									; map heated bed to heater 0

; ######
; # Hotend (Mosquito with SE Thermistor) 
; ###############
M308 S1 P"temp1" Y"thermistor" A"Slice Engineering" T100000 B4680 C6.455513e-8 		; configure sensor 1 as thermistor on pin temp1 300C
;M308 S1 P"temp1" Y"thermistor" A"Slice Engineering" T500000 B4723 C1.196220e-7 	; configure sensor 1 as thermistor on pin temp1 500C
;M308 S1 P"temp1" Y"thermistor" A"E3D" T100000 B4725 C7.06e-8 						; configure sensor 1 as thermistor on pin temp1
M950 H1 C"out2" T1                                 									; create nozzle heater output on out2 and map it to sensor 1
M307 H1 B0 S1.00                                   									; disable bang-bang mode for heater and set PWM limit
M143 H1 S290                                       									; set temperature limit for heater 1 to 290C

; ######
; # display MCU and drivers temperature
; ###############
;M308 S4 P"mcu-temp" Y"mcu-temp" A"MCU"                                 				; set virtual heater for MCU
;M308 S5 P"drivers" Y"drivers" A"Driver"                                				; set virtual heater for stepper drivers

; ######
; # Extruder fan (temerature controlled)
; ###############
M950 F1 C"out9" Q500                           										; create fan 1 on pin out9 and set its frequency
M106 P1 C"Hot End" H1 T45                       									; set fan 1 name and value. Thermostatic control is turned on

; ######
; # Radial fan
; ###############
M950 F0 C"out8" Q25                            										; create fan 0 on pin out8 and set its frequency
M106 P0 C"Printed" S0 H-1                          									; set fan 0 name and value. Thermostatic control is turned off

; #####################################################################
; #
; # Tools
; #
; #####################################################################
M563 P0 S"LGX" D0 H1 F0                             	; define tool 0
G10 P0 X0 Y0 Z0                                        	; set tool 0 axis offsets
M568 P0 S0 R0 A0                                     	; turn off extruder
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
;M98 P"0:/sys/functions/filament-sensor-status.g"

; ######
; # Offsets - place off-sets for x and y here. z-offsets are handled in the print sheet macros
; ###############
; G31 P1000 X-29.982 Y-34.316 Z2.50
; G31 P1000 X-29.982 Y-34.316 Z2.15 ; Z1.65 for 0.4mm Nozzle
G31 P1000 X-29.982 Y-34.316 Z1.83
