myTraveler = $Sphere001
myFollower = $Box001
myPath = $Line001
myFloor = $Plane001

animate on (
	for T in 0 to 500 by 1 do (
		at time t (
			myRay = ray myFollower.pos [0, 0, -1]
			myCollision = IntersectRay myFloor myRay
			myTraveler.pos = myCollision.pos + myCollision.dir * myTraveler.radius
		)
	)
)