ball1 = sphere radius:10 wireColor:blue
ball2 = sphere radius:10 wireColor:red
ball3 = sphere radius:5 wireColor:green

animate on
( 
	at time 0 
	(
		ball1.pos = [-100,50,0] 
		ball2.pos = [-100, -50, 0]
	)
	at time 100
	(
		ball1.pos = [100,50,0] 
		ball2.pos = [100, -50, 0]
	)
)

animate on for t in 0 to 100 by 5 do
	at time t 
	(
		ball1.pos = ball1.pos + random [-5,-5,-5] [5,5,5]
		ball2.pos = ball2.pos + random [-5,-5,-5] [5,5,5]
		ball3.pos = (ball2.pos + ball1.pos)/2
	)