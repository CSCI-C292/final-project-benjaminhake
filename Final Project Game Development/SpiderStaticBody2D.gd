extends Area2D

var movingDown = false
var movementCounter = 0

func _ready():
	pass 

func _process(delta):
	var keepGoingInDirection = movementCounter < 160
	if movingDown and keepGoingInDirection:
		position = Vector2(position.x, position.y - 3)
		movementCounter += 1
	elif not movingDown and keepGoingInDirection:
		position = Vector2(position.x, position.y + 3)
		movementCounter += 1
	else:
		movingDown = not movingDown
		movementCounter = 0

func _on_SpiderStaticBody2D_area_entered(area):
	match area.get_groups():
		["player"]:
			if not area.get_parent().isDead:
				area.get_parent().die()
		["sword"]:
			queue_free()
