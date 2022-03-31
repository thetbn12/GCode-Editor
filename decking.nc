;DeckingSubroutine
;Version 1
G0                                     
#MCS Z0
G70                                     ;convert to inches
G501 E0.0039 A65 M2                     ;high speed machining 
T1 D1 	                                ;change tool to welder
M3 M7 
S18000
G4 K3

V.P.decking_height = [[P1*2+2]/25.4]
G0 X2 Y2.5                              ;Decking start
G0 Z[V.P.decking_height+2]	            ;move to layer 
G1 Z[V.P.decking_height] F100
G1 X5.5
G1 Y2.7
G1 X2
G1 Y2.9
G1 X5.5
G1 Y3.1
G1 X2
G1 Y3.3
G1 X5.5
G1 Y3.5
G1 X2
G1 Y3.7
G1 X5.5
G1 Y3.9
G1 X2
G1 Y4.1
G1 X5.5
G1 Y4.3
G1 X2
G1 Y4.5
G1 X5.5
G1 Y4.7
G1 X2
G1 Y4.9
G1 X5.5

M5 M9	                                ;tool off air off 
G0                                     ;rapid move
#MCS Z0 	                           ;return zero 
T1 D2                                  ;turn welder back on 
G71                                    ;convert to mm 
M17		                               ;end subroutine 
M29