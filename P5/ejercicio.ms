ball = sphere radius:8 wireColor:blue

fn saltar Traveler CPs T_ini T_fin=
(
	T_total = T_fin - T_ini -- tiempo total de la animación
	T_salto = T_total / (CPs.count - 1) -- tiempo de cada salto
	for i = 1 to CPs.count - 1 do
	(
		T_salto_ini = (i - 1) * T_salto
		T_salto_fin = i * T_salto
		interPolacionCuadratica Traveler CPs[i].pos CPs[i + 1].pos T_salto_ini T_salto_fin
	)
	Traveler.showTrajectory = on
)

fn interpolacionCuadratica Traveler CP_ini CP_fin T_ini T_fin= 
(
	CP_inter.x = (CP_ini.x + CP_fin.x) / 2
	CP_inter.y = (CP_ini.y + CP_fin.y) / 2
	CP_inter.z = distance CP_ini CP_fin
	
	V1 = (CP_inter - CP_ini)
	V2 = (CP_fin - CP_inter)

	animate on
	(
		for t in T_ini to T_fin by 1 do
		(
			at time t
			(
				CP4 = CP_ini + ((normalize V1) * (((length V1) / T_fin) * t)) -- cambiar t por u reparametrizando
				CP5 = CP_inter + ((normalize V2) * (((length V2) / T_fin) * t))
				V3 = (CP5 - CP4)
				Traveler.pos = CP4 + ((normalize V3) * (((length V3) / T_fin) * t))
			)
		)
	)
)

cps = $Box* as array -- crear el array con todos los puntos de control

if cps.count >= 2 do
(
	saltar ball cps 0 100
)
