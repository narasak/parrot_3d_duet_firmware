; 0:/macros/Maintenance/Save-Z-Baby
; This macro subtracts the current babystep offset from the current Z trigger height and informs the user what offset
; value to change the G31 Z metric to in the 0:/sys/config.g. Additionally, the macro issues a G31 command with the new
; calculated z-offset, clears the current baby-stepping and then rehomes the machine to make the new z-offset effective.
; If this is for a specific filament type, recommend placing this yielded information in the filament's config.g - not
; the 0:/sys/config.g.


if state.status != "processing"                                      ; Printer is not currently printing!

   if move.axes[2].babystep !=0                                      ; If no babysteps are currently adjusted - exit routine
      echo {"Previous Z probe trigger height: " ^ sensors.probes[0].triggerHeight ^ ", New: " ^ sensors.probes[0].triggerHeight - move.axes[2].babystep}
      echo {"Edit the G31 command in your config.g with a new Z offset of: " ^ sensors.probes[0].triggerHeight - move.axes[2].babystep}
      M291 P{"Set probe offset to " ^ sensors.probes[0].triggerHeight - move.axes[2].babystep ^ ", clear babysteps, and REHOME ALL?"} R"!WARNING! Do not proceed if printing!" S3
      M400                                                           ; Finish all current moves / clear the buffer
      G31 Z{sensors.probes[0].triggerHeight - move.axes[2].babystep} ; set G31 Z offset to corrected
      M500 P10:31                                                    ; save settings to config-overide.g - G31 P31 saves trigger height
      M290 R0 S0                                                     ; set babystep to 0mm absolute
      G28                                                            ; home all
      M291 P"Ensure M501 exists in 0:/sys/config, or manually edit the G31 Z offset, to make this change permanent." R"Note on making change permanent." S3
   else
      echo "Babystepping is not currently active, nothing to do."

else
   M291 S2 P"This would be detrimental to the ongoing print. Please run this macro when the print is finished, and the bed is clear & ready for the homing sequence to be conducted." R"WARNING"