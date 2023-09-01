G90 ; use absolute coordinates
M83 ; extruder relative mode
M140 S{first_layer_bed_temperature[initial_extruder]} ; set final bed temp
M104 S150 ; set temporary nozzle temp to prevent oozing during homing and auto bed leveling
M190 S{first_layer_bed_temperature[initial_extruder]} ; wait for bed temp to stabilize

; --- Home Axis and Load UBL Mesh  
G28                 ; home all axis
G29 A               ; enable UBL system
@BEDLEVELVISUALIZER	; tell the plugin to watch for reported mesh
G29 L0              ; load UBL Mesh from Slot 0
G29 J3              ; 6 point tilt
G29 T0              ; output the grid to the terminal

G1 Z50 F240
G1 X2 Y10 F3000
M104 S{first_layer_temperature[initial_extruder]+extruder_temperature_offset[initial_extruder]} ; set final nozzle temp
M109 S{first_layer_temperature[initial_extruder]+extruder_temperature_offset[initial_extruder]} ; wait for nozzle temp to stabilize

; --- clean the nozzle --
G1 Z0.28 F240           ; lift printhead so we no crash into bed
G1 X1 F3000             ; move to x1,y0
G92 E0                  ; reset extruder
G1 E10                  ; spit out da goo
G1 X10 Y0 Z0.3          ; smear it aroung
G1 Z2.0 F3000           ; Move Z Axis up little to prevent scratching of Heat Bed
G1 X10 Y1 Z2.0 F5000.0  ; Move over to prevent blob squish
G92 E0                  ; reset extruder
