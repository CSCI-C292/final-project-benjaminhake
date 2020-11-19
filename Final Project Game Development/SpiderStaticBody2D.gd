extends StaticBody2D

var movingDown = false
var movementCounter = 0

func _ready():
	pass 

func _process(delta):
	var keepGoingInDirection = movementCounter < 150
	if movingDown and keepGoingInDirection:
		position = Vector2(position.x, position.y - 2)
		movementCounter += 1
	elif not movingDown and keepGoingInDirection:
		position = Vector2(position.x, position.y + 2)
		movementCounter += 1
	else:
		movingDown = not movingDown
		movementCounter = 0
		
