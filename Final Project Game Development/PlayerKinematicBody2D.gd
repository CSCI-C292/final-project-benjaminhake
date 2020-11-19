extends KinematicBody2D

var inMirrorMode = false
var isJumping = false
var speed = 200
var jumpspeed = -4000
var gravity = 3500
var velocity = Vector2()
var stationarytexture = preload("res://FP Assets/percystationary.png")
var striketexture = preload("res://FP Assets/percysword2.png")

func _ready():
	pass
	
func checkInputPressed():
	velocity = Vector2()
	var jump = Input.is_action_just_pressed("jump")
	if jump and is_on_floor():
		isJumping = true
		velocity.y = jumpspeed
	if Input.is_action_just_pressed("swing"):
		get_child(1).set_texture(striketexture)
		get_child(2).start(.25)
	if Input.is_action_pressed("moveLeft"):
		velocity.x -= speed
	if Input.is_action_pressed("moveRight"):
		velocity.x += speed
	
	
func _physics_process(delta):
	checkInputPressed()
	velocity.y += gravity * delta
	if isJumping and is_on_floor():
		isJumping = false
	move_and_slide(velocity, Vector2(0, -1))
	
func _on_Timer_timeout():
	get_child(1).set_texture(stationarytexture)
