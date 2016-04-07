ball1 = sphere radius:10 wireColor:blue
ball2 = sphere radius:4 wireColor:red position:[-110,0,0]
ball3 = sphere radius:4 wireColor:green position:[-120,0,0]

animate on
( 
	at time 0 ball1.pos = [-100,0,0]
	at time 100 ball1.pos = [100,0,0]
)

animate on for t in 10 to 100 by 5 do
	at time t 
	(
		ball2.pos = ball1.pos - [25,0,0]
	) 

animate on
(
	at time 10 ball2.pos = [-110, 0, 0]
)

animate on for t in 10 to 100 by 5 do
	at time t 
	(
		ball3.pos = ball2.pos - [10,0,0]
	) 
