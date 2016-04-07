ball = sphere radius:8 wireColor:blue
cp1 = box length:5 width:5 height:5 pos:[30,10,0] wireColor:red
cp2 = box length:5 width:5 height:5 pos:[0,-50,0] wireColor:red
cp3 = box length:5 width:5 height:5 pos:[-25,40,0] wireColor:red
cp4 = box length:2 width:2 height:2 wireColor:yellow
cp5 = box length:2 width:2 height:2 wireColor:yellow

fn casteljau Traveler CP1 CP2 CP3 CP4 CP5= 
(
	V1 = (CP2-CP1)
	V2 = (CP3-CP2)

	animate on
	(
		for t in 0 to 100 by 10 do
		(
			at time t
			(
				CP4.pos = CP1 + ((normalize V1)*(((length V1)/100)*t))
				CP5.pos = CP2 + ((normalize V2)*(((length V2)/100)*t))
				V3 = (CP5.pos - CP4.pos)
				Traveler.pos = CP4.pos + ((normalize V3)*(((length V3)/100)*t))
			)
			
		)
	)
	
	Traveler.showTrajectory = on
)

casteljau ball cp1.pos cp2.pos cp3.pos cp4 cp5
