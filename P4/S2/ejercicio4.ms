ball = sphere radius:8 wireColor:blue
cp1 = box length:5 width:5 height:5 pos:[-60,10,0] wireColor:red
cp2 = box length:5 width:5 height:5 pos:[60,-10,0] wireColor:red
cp3 = box length:5 width:5 height:5 pos:[-10,100,0] wireColor:yellow
cp3 = box length:5 width:5 height:5 pos:[20,-80,0] wireColor:yellow

fn interpolacionCubica Traveler CP1 CP2 CP3 CP4=
(
	
	
	Traveler.showTrajectory = on
)

interpolacionCubica ball cp1.pos cp2.pos cp3.pos cp4.pos