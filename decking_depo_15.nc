;DeckingSubroutine
;Version 1
G0                                     
#MCS Z0
G70                                     ;convert to inches
G501 E0.0039 A65 M2                     ;high speed machining 
D1 	                                ;change tool to welder
M3 M7 
;2000 mm a min @4000 rpm
S4000
G4 K3

V.P.decking_height = [[P1*2+2]/25.4]

G1 X5.347 Y2.96 ;move to beginning of decking path
G0 Z[V.P.decking_height+1] ; move close to buildplate
G1 Z[V.P.decking_height] F30; move to buildplate
G1 X2.815 Y0.422 F75
G0 Z12
G0 X11.899 Y10.808
G0 Z[V.P.decking_height+1]
G1 Z[V.P.decking_height] F30
G1 X2.164 Y1.073 F75
G0 Z12
G0 X11.227 Y11.48
G0 Z[V.P.decking_height+1]
G1 Z[V.P.decking_height] F30
G1 X1.492 Y1.745 F75
G0 Z12
G0 X10.404 Y12
G0 Z[V.P.decking_height+1]
G1 Z[V.P.decking_height] F30
G1 X0.821 Y2.417 F75


M5 M9	                                ;tool off air off 
G0                                     ;rapid move
#MCS Z0 	                           ;return zero 
D2                                  ;turn welder back on 
G71                                    ;convert to mm 
M17		                               ;end subroutine 
M29