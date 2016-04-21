fn SquashAndStretch Traveler T T_ini T_fin=
(
	animate on 
	(
		at time (T_ini)
		(
			scale Traveler [1.1, 1.1, 0.9] --aplasta
		)
		at time (T_ini + (T / 8))
		(
			scale Traveler [0.9, 0.9, 1.1] --pos. original
		)
		at time (T_ini + (T / 4))
		(
			scale Traveler [0.8, 0.8, 1.2] --estira
		)
		at time (T_ini + (T / 2))
		(
			scale Traveler [1.2, 1.2, 0.8] --pos. original
		)
		at time (T_fin - (T / 8))
		(
			scale Traveler [1, 1, 1] --pos. original
		)
	)
)

fn InterpolacionCuadratica Traveler CP_ini CP_fin T_ini T_fin H=
(
	
	CP_aux = [(CP_ini.x + CP_fin.x) / 2, (CP_ini.y + CP_fin.y) / 2, (distance CP_ini CP_fin) * H]
	
	V1 = CP_aux - CP_ini
	V2 = CP_fin - CP_aux
	
	animate on
	(
		for T in T_ini to T_fin by 1 do
		(
			at time T
			(
				CP4 = CP_ini + normalize V1 * (length V1 / (T_fin - T_ini)) * (T - T_ini)
				CP5 = CP_aux + normalize V2 * (length V2 / (T_fin - T_ini)) * (T - T_ini)
				
				V3 = CP5 - CP4
				
				Traveler.pos = CP4 + (normalize V3 * (length V3 / (T_fin - T_ini) * (T - T_ini)))
			)
		)
	)
)

fn Saltar Traveler CPs T_ini T_salto=
(
	for i = 1 to CPs.count - 1 do
	(
		T_salto_ini = (i - 1) * T_salto
		T_salto_fin = i * T_salto
		InterpolacionCuadratica Traveler CPs[i].pos CPs[i + 1].pos T_salto_ini T_salto_fin (random 0.5 2)
		SquashAndStretch Traveler T_salto T_salto_ini T_salto_fin
	)
)

rollout Salto "Salto"
(
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	spinner UI_IF "Comienzo" range:[0,1000,0] type:#Integer
	spinner UI_FF "Duración del salto" range:[5,100,20] type:#Integer
	button UI_CrearSalto "Crear"
	
	on UI_SelectorActor picked obj do
	(
		global Traveler = obj
		UI_SelectorActor.text = obj.name
	)
	
	on UI_CrearSalto pressed do
	(
		cps = $Box* as array -- crear el array con todos los puntos de control
		if Traveler != undefined and cps.count >= 2 do
		(
			deletekeys Traveler
			Traveler.dir = [0, 0, 1]
			Saltar Traveler cps UI_IF.value (UI_IF.value + UI_FF.value)
			Traveler.showTrajectory = on
		)
	)
)

createDialog Salto