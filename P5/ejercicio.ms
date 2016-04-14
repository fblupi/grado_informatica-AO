ball = sphere radius:8 wireColor:blue
cp1 = box length:5 width:5 height:5 pos:[30,10,0] wireColor:red
cp2 = box length:5 width:5 height:5 pos:[-25,40,0] wireColor:red

fn interpolacionCuadratica Traveler CP_ini CP_fin= 
(
	CP_inter.x = (CP_ini.x + CP_fin.x) / 2
	CP_inter.y = (CP_ini.y + CP_fin.y) / 2
	CP_inter.z = distance CP_ini CP_fin
	
	V1 = (CP_inter-CP_ini)
	V2 = (CP_fin-CP_inter)

	animate on
	(
		for t in 0 to 100 by 10 do
		(
			at time t
			(
				CP4 = CP_ini + ((normalize V1)*(((length V1)/100)*t))
				CP5 = CP_inter + ((normalize V2)*(((length V2)/100)*t))
				V3 = (CP5 - CP4)
				Traveler.pos = CP4 + ((normalize V3)*(((length V3)/100)*t))
			)
			
		)
	)
	
	Traveler.showTrajectory = on
)

interpolacionCuadratica ball cp1.pos cp2.pos
