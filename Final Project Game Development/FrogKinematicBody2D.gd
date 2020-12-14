extends KinematicBody2D

var jumpingsprite = preload("res://FP Assets/frognobg-removebg-preview.png")
var stationarysprite = preload("res://FP Assets/frog-removebg-preview.png")
var player

var speed = 400
var gravity = 7000
var jumpspeed = -9000
var velocity = Vector2()

var jump = false
var isjumping = false
func _ready():
	player = get_tree().get_root().get_child(0).get_child(2).get_child(0)
	get_child(2).start()
	
func _physics_process(delta):
	velocity = Vector2(velocity.x, 0)
	if isjumping and is_on_floor():
		isjumping = false
		velocity = Vector2(0,0)
		get_child(2).start()
		get_child(0).set_texture(stationarysprite)
	if jump:
		jump = false
		
		velocity.y = jumpspeed
		if player.position.x < position.x:
			get_child(0).flip_h = false
			velocity.x -= speed
		else:
			get_child(0).flip_h = true
			velocity.x += speed
		isjumping = true
		get_child(2).start()
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var collidernode = get_slide_collision(i).collider
		if "player" in collidernode.get_groups():
			if not collidernode.isDead:
				collidernode.die()
		



func _on_FrogTimer_timeout():
	get_child(0).set_texture(jumpingsprite)
	jump = true


func _on_FrogArea2D_area_entered(area):
	match area.get_groups():
		["sword"]:
			queue_free()
