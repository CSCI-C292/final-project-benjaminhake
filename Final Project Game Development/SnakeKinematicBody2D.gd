extends KinematicBody2D

var speed
var gravity
var velocity

var player
var playerposition
var rootnode

func _ready():
	speed = 200
	velocity = Vector2()
	gravity = 10000
	
	player = get_tree().get_root().get_child(0).get_child(2).get_child(0)

	playerposition = Vector2()
	rootnode = get_tree().get_root().get_child(0)

func _physics_process(delta):
	movement()
	velocity.y += gravity * delta
	move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var collidernode = get_slide_collision(i).collider
		if "player" in collidernode.get_groups():
			if not collidernode.isDead:
				collidernode.die()

func movement():
	velocity = Vector2()
	if not rootnode.playerIsDead:
		playerposition = player.position.x
		if position.x < playerposition:
			velocity.x += speed
		else:
			velocity.x -= speed

func _on_SnakeArea2D_area_entered(area):
	match area.get_groups():
		#["player"]:
		#	rootnode.playerIsDead = true
		#	area.get_parent().queue_free()
		["sword"]:
			get_parent().remove_child(self)
