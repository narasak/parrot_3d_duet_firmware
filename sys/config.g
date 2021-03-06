; Default config.g template for DuetPi
; Replace this with a proper configuration file (e.g from https://configtool.reprapfirmware.org)

; Display initial welcome message
; M291 P"Please go to <a href=""https://www.duet3d.com/StartHere"" target=""_blank"">this</a> page for further instructions on how to set it up." R"Welcome to your new Duet 3!" S1 T0

; =========================================================================================================
; General preferences
; =========================================================================================================
G90                                                		; send absolute coordinates...
M83                                                		; ...but relative extruder moves
M550 P"Parrot 3D"                                  		; set printer name

; =========================================================================================================
; NEOPIXEL RGB
; =========================================================================================================
M98 P"0:/macros/NEOPIXEL/red.g"
M98 P"0:/macros/NEOPIXEL/green.g"
M98 P"0:/macros/NEOPIXEL/blue.g"
M98 P"0:/macros/NEOPIXEL/purple.g"
M98 P"0:/macros/NEOPIXEL/white.g"

; =========================================================================================================
; Drives
; =========================================================================================================
M569 P0.0 S0 D3 H5 V5                                	; physical drive 0.0 goes backwards, set stealthChop mode, set tpwmthrs and thigh
M569 P0.1 S1 D3 H5 V5                                  	; physical drive 0.1 goes forwards, set stealthChop mode, set tpwmthrs and thigh
M569 P0.2 S1                                       		; physical drive 0.2 goes forwards
M569 P0.3 S1                                       		; physical drive 0.3 goes forwards
M569 P0.4 S1                                       		; physical drive 0.4 goes forwards
M584 X0.0 Y0.1 Z0.2:0.3 E0.4                       		; set drive mapping

; =========================================================================================================
; Leadscrew Left and Right position
; =========================================================================================================
M671 X-38.1:288.1 Y0:0 S1 					   			; leadscrews at left (connected to Z) and right (connected to E1) of X axis

; =========================================================================================================
; Motor Configuration
; =========================================================================================================
;
; Microstepping
; ---------------------------------------------------------------------------------------------------------
M350 X256 Y256 Z256 E256 I1                            	; configure microstepping with interpolation
M92 X3200.00 Y3200.00 Z6400.00 E13280.00               	; set steps per mm
;M350 X32 Y32 Z32 E32 I1                            	; configure microstepping with interpolation
;M92 X400.00 Y400.00 Z800.00 E1660.00               	; set steps per mm
;
; Speed
; ---------------------------------------------------------------------------------------------------------
;M201 X5000.00 Y5000.00 Z1000.00 E5000.00				; set accelerations (mm/s^2)
M201 X500.00 Y500.00 Z100.00 E500.00              		; set accelerations (mm/s^2)
;M203 X15000.00 Y15000.00 Z1000.00 E3600.00				; set maximum speeds (mm/min)
M203 X9000.00 Y9000.00 Z1000.00 E3600.00            	; set maximum speeds (mm/min)
M204 P500.00 T500.00                                  	; set print and travel accelerations (mm(s^2)
;M566 X600.00 Y600.00 Z48.00 E300.00 P1					; set maximum instantaneous speed changes (mm/min) [Jerk]
M566 X480.00 Y480.00 Z48.00 E300.00 P1                	; set maximum instantaneous speed changes (mm/min) [Jerk]
;
; Current
; ---------------------------------------------------------------------------------------------------------
M906 X1400 Y1400 Z450 E1400 I40                    		; set motor currents (mA) and motor idle factor in per cent
M84 S60                                            		; Set idle timeout

; =========================================================================================================
; Configure Dynamic Acceleration Adjustment
; =========================================================================================================
; M593 F40.00  											; cancel ringing at 49.4Hz

; =========================================================================================================
; Set bed dimensions
; =========================================================================================================
M208 X0:255 Y-4:212.5 Z0.15:210                    		; X carriage moves from 0 to 250, Y bed goes from 0 to 210
M564 H0                                         		; Allow unhomed movement

; =========================================================================================================
; Endstops
; =========================================================================================================
M574 X1 S3                                     			; configure sensorless endstop for low end on X
M574 Y1 S3                                         		; configure sensorless endstop for low end on Y

; =========================================================================================================
; Stallgaurd Sensitivity
; =========================================================================================================
M98 P"current-sense-homing.g"                        	; Set the current and sensitivity for normal routine, per the macro

; =========================================================================================================
; Z-Probe
; =========================================================================================================
M558 P5 C"io4.in" I1 H1.5 F1000 T12000 A3.           			; Prusa P.I.N.D.A 2
M308 S2 P"temp2" A"P.I.N.D.A. 2" Y"thermistor" T100000 B3950	; Prusa P.I.N.D.A 2
G31 P500 X23.00 Y5.00 Z1.17 P2                     				; set Z probe trigger value, offset and trigger height (Z1.24)
M557 X23:235 Y5:186 S30.25:30									; define mesh grid
M376 H10                                           				; Set bed compensation taper at Z=10mm

; =========================================================================================================
; Heaters
; =========================================================================================================
;
; Heated bed
; ---------------------------------------------------------------------------------------------------------
M308 S0 P"temp0" Y"thermistor" A"Build Plate" T100000 B4138		; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out1" T0                                 				; create bed heater output on out1 and map it to sensor 0
M143 H0 S120                                       				; set temperature limit for heater 0 to 120C
M307 H0 B0 S1.00                                   				; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                            				; map heated bed to heater 0
;
; Extruder
; ---------------------------------------------------------------------------------------------------------
;M308 S1 P"temp1" Y"thermistor" A"Mosquito" T500000 B4723 C1.196220e-7 	; configure sensor 1 as thermistor on pin temp1
M308 S1 P"temp1" Y"thermistor" A"Mosquito" T100000 B4725 C7.06e-8 		; configure sensor 1 as thermistor on pin temp1
M950 H1 C"out2" T1                                 						; create nozzle heater output on out2 and map it to sensor 1
M143 H1 S315                                       						; set temperature limit for heater 1 to 315C
M307 H1 B0 S1.00                                   						; disable bang-bang mode for heater  and set PWM limit

; =========================================================================================================
; PID Tune
; =========================================================================================================
M307 H0 R0.274 C466.5 D11.16 S1.00 V23.9				; Bed PID tune for 80c
M307 H1 R2.417 C126.7 D4.88 S1.00 V24.0					; Hot end PID tune at 250c

; =========================================================================================================
; Filament Sensor
; =========================================================================================================
M591 D0 P2 C"io1.in" S1									; Filament Runout Sensor

; =========================================================================================================
; Fans
; =========================================================================================================
M950 F0 C"out8" Q10                            			; create fan 0 on pin out8 and set its frequency
M106 P0 C"Printed" S0 H-1                          		; set fan 0 name and value. Thermostatic control is turned off
M950 F1 C"out9" Q255                               		; create fan 1 on pin out9 and set its frequency
M106 P1 C"Hot End" S1 H1 T50                       		; set fan 1 name and value. Thermostatic control is turned on

; =========================================================================================================
; Tools
; =========================================================================================================
M563 P0 S"BMG" D0 H1 F0                            		; define tool 0
G10 P0 X0 Y0 Z0                                    		; set tool 0 axis offsets
G10 P0 R0 S0                                       		; set initial tool 0 active and standby temperatures to 0C

; Relase X, Y, and E axis
M18 XYZE                                             	; Unlock the X, Y, and E axis

; Custom settings are not defined

; =========================================================================================================
; Power Failed Resume
; =========================================================================================================
M911 S21.0 R23.0 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000" 	; set voltage thresholds and actions to run on power loss
T0                                                 		; select first tool