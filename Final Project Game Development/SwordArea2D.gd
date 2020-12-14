extends Area2D

var leftPosition = Vector2(-55, -17)
var rightPosition = Vector2(55, -17)

func moveToLeft():
	get_child(0).position = leftPosition

func moveToRight():
	get_child(0).position = rightPosition

func _on_SwordArea2D_area_entered(area):
	match area.get_groups():
		["enemy"]:
			area.queue_free()

func _on_SwordArea2D_body_entered(body):
	get_parent().rootnode.remove_child(body)
