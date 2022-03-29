;DeckingSubroutine
;Version 1
G0                                     
#MCS Z0
G70                                     ;convert to inches
G501 E0.0039 A65 M2                     ;high speed machining 
T1 D1 	                                ;change tool to welder
M3 M7 
;2000 mm a min @4000 rpm
S4000
G4 K3

V.P.decking_height = [[P1*2+2]/25.4]
G1 X9.102 Y0.369                        ;Decking start
G0 Z[V.P.decking_height+2]	            ;move to layer 
G1 Z[V.P.decking_height] F79
G1 X0.084 Y9.382
G1 X0.614 Y9.913
G1 X9.633 Y0.899
G1 X10.163 Y1.43
G1 X1.144 Y10.443
G1 X1.675 Y10.973
G1 X10.693 Y1.96
G1 X11.224 Y2.49
G1 X9.414 Y4.299


M5 M9	                                ;tool off air off 
G0                                     ;rapid move
#MCS Z0 	                           ;return zero 
T1 D2                                  ;turn welder back on 
G71                                    ;convert to mm 
M17		                               ;end subroutine 
M29