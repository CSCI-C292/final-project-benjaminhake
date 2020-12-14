extends Area2D




func _on_SnakeArea2D_area_entered(area):
	match [area.get_groups()]:
		["sword"]:
			get_parent().queue_free()
