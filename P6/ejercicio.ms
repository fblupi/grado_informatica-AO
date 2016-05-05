myTraveller = $Sphere001
myFollower = $Box001
myFloor = $Plane001

deletekeys myTraveller

ini = 0
fin = 500

fn getCollision t = (
	return IntersectRay myFloor (ray (at time t myFollower.pos) [0, 0, -1])
)

animate on (
	for t in ini to fin by 1 do (
		collision0 = getCollision t	-- traza un rayo hacia el plano de la curva en el instante t
		p0 = collision0.pos + collision0.dir * myTraveller.radius	-- obtiene la posición actual de la bola
		
		at time t myTraveller.pos = p0	-- actualiza el valor de posición de la bola
			
		if t > ini do (
			if t < fin then (
				collision1 = getCollision (t + 1)	-- traza un rayo hacia el plano de la curva en el instante t
				p1 = collision1.pos + collision1.dir * myTraveller.radius	-- obtiene la posición siguiente de la bola
			) else (
				collision1 = getCollision ini	-- traza un rayo hacia el plano de la curva en el instante t
				p1 = collision1.pos + collision1.dir * myTraveller.radius	-- obtiene la posición siguiente de la bola
			)
			
			diff = p1 - p0		-- calcula la diferencia entre la posición actual y la siguiente
			len = Length diff	-- calcula la distancia entre las dos posiciones
			vec = diff / len	-- vector de movimiento normalizado
			
			rotAxis = cross vec collision0.dir	-- eje de rotación
			ang = 360 * len / (myTraveller.radius * 2 * pi)	-- cantidad de rotación
			rotDiff = quat ang rotAxis	-- quaternion que define la rotación desde la posición actual a la siguiente
			
			rotEuler = QuatToEuler rotDiff	-- conversión a rotación de euler
			at time t rotate myTraveller rotEuler	-- rota la bola
		)
	)
)