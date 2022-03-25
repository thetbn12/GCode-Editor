%DeckingSubroutine
%Version 1

#MCS Z0
G501 E0.0039 A65 M2 ;high speed machining 
T1 D1 M6 	                            ;tool on 
V.P.decking_height = P1*2 +2
G1 ZV.P.decking_height   	            ;move to layer 
G1 X2 Y2.5 F10                          ;Decking start
G1 X5.5
G1 Y2.875
G1 X2
G1 Y3.25
G1 X5.5
G1 Y3.625
G1 X2
G1 Y4
G1 X5.5
G1 Y4.375
G1 X2
G1 Y4.75
G1 X5.5
#MCS Z0 	                           ;return zero 
T1 D1 M5	                           ;tool off 
M17		                               ;end subroutine 
M29