ball = sphere radius:8 wireColor:blue
cp1 = box length:5 width:5 height:5 pos:[-60,10,0] wireColor:red
cp2 = box length:5 width:5 height:5 pos:[-10,100,0] wireColor:red
cp3 = box length:5 width:5 height:5 pos:[20,-80,0] wireColor:red
cp4 = box length:5 width:5 height:5 pos:[60,-10,0] wireColor:red
cp5 = box length:2 width:2 height:2 wireColor:yellow
cp6 = box length:2 width:2 height:2 wireColor:yellow
cp7 = box length:2 width:2 height:2 wireColor:yellow
cp8 = box length:2 width:2 height:2 wireColor:green
cp9 = box length:2 width:2 height:2 wireColor:green

fn interpolacionCubica Traveler CP1 CP2 CP3 CP4 CP5 CP6 CP7 CP8 CP9=
(
	V1 = (CP2-CP1)
	V2 = (CP3-CP2)
	V3 = (CP4-CP3)

	animate on
	(
		for t in 0 to 100 by 10 do
		(
			at time t
			(
				CP5.pos = CP1 + ((normalize V1)*(((length V1)/100)*t))
				CP6.pos = CP2 + ((normalize V2)*(((length V2)/100)*t))
				CP7.pos = CP3 + ((normalize V3)*(((length V3)/100)*t))
				
				V4 = (CP6.pos - CP5.pos)
				V5 = (CP7.pos - CP6.pos)
				
				CP8.pos = CP5.pos + ((normalize V4)*(((length V4)/100)*t))
				CP9.pos = CP6.pos + ((normalize V5)*(((length V5)/100)*t))
				
				V6 = (CP9.pos - CP8.pos)
				Traveler.pos = CP8.pos + ((normalize V6)*(((length V6)/100)*t))
			)
			
		)
	)
	Traveler.showTrajectory = on
)

interpolacionCubica ball cp1.pos cp2.pos cp3.pos cp4.pos cp5 cp6 cp7 cp8 cp9