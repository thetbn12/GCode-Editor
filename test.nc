Threadmill_top
N10 ; T3  D=0.3937 CR=0 - ZMIN=-0.6348 - FLAT END MILL
N15 #MCS OFF
N20 #CS OFF
N25 G70 G80 G90
N30 G17 G40
N35 G53
N40 G0 G53 Z24
N45 G53
N50 ; 2D CONTOUR5
N55 T3 M6
N60 S20000
N65 M3

N55 Z12 ; END LAYER

N70 G4 K3
N75 G54
;(ORGX58=0,ORGY58=0,ORGZ58=0)
N80 G58
N85 D1
N90 G0 X5.4291 Y3
N95 G43 Z0.6

N100 M3
N105 M30