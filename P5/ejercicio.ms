fn ChangeInterval A A_min A_max B_min B_max= --cambia de intervalo A con intervalor original (A_min, A_max) a (B_min, B_max)
(	
	return B_min + (A - A_min) * (B_max - B_min) / (A_max - A_min)
)

fn SquashAndStretch Traveler T T_ini T_fin H H_MIN H_MAX SQUASH_FACTOR STRETCH_FACTOR=
(
	Squash_val = ChangeInterval H H_MIN H_MAX 0 SQUASH_FACTOR
	Stretch_val = ChangeInterval H H_MIN H_MAX 0 STRETCH_FACTOR
	
	Squash_max = 1 + Squash_val
	Squash_min = 1 - Squash_val
	Stretch_max = 1 + Stretch_val
	Stretch_min = 1 - Stretch_val
	
	animate on 
	(
		at time (T_ini)
		(
			Traveler.scale = [Squash_max, Squash_max, Squash_min] --aplasta
		)
		at time (T_ini + (T / 8))
		(
			Traveler.scale = [1, 1, 1] --pos. original
		)
		at time (T_ini + (T / 4))
		(
			Traveler.scale = [Stretch_min, Stretch_min, Stretch_max] --estira
		)
		at time (T_ini + (T / 2))
		(
			Traveler.scale = [1, 1, 1] --pos. original
		)
		at time (T_fin - (T / 8))
		(
			Traveler.scale = [1, 1, 1] --pos. original
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

fn Saltar Traveler CPs T_ini T_salto H_MIN H_MAX SQUASH_FACTOR STRETCH_FACTOR=
(
	for i = 1 to CPs.count - 1 do
	(
		T_salto_ini = (i - 1) * T_salto
		T_salto_fin = i * T_salto
		H = random H_MIN H_MAX
		InterpolacionCuadratica Traveler CPs[i].pos CPs[i + 1].pos T_salto_ini T_salto_fin H
		SquashAndStretch Traveler T_salto T_salto_ini T_salto_fin H H_MIN H_MAX SQUASH_FACTOR STRETCH_FACTOR
	)
)

rollout Salto "Salto"
(
	label EActor "Actor:" 
	pickbutton UI_SelectorActor "Selecciona Actor"
	spinner UI_IF "Comienzo" range:[0, 1000, 0] type:#Integer
	spinner UI_FF "Duración salto" range:[10, 100, 20] type:#Integer
	spinner UI_SQ "Squash" range:[0, 0.5, 0.3] type:#Float
	spinner UI_ST "Stretch" range:[0, 0.5, 0.3] type:#Float
	spinner UI_HMIN "Altura mínima" range:[0.4, 1.0, 0.5] type:#Float
	spinner UI_HMAX "Altura máxima" range:[1.0, 2.5, 2.0] type:#Float
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
			Saltar Traveler cps UI_IF.value (UI_IF.value + UI_FF.value) UI_HMIN.value UI_HMAX.value UI_SQ.value UI_ST.value
			Traveler.showTrajectory = on
		)
	)
)

createDialog Salto