extends KinematicBody2D

var inMirrorMode
var isJumping
var isAttacking
var facingLeft
var isDead

var speed
var jumpspeed
var gravity
var velocity

var stationarytexture
var stationarymirrortexture
var striketexture
var strikemirrortexture
var deathtexture

var levelnode

var pos1 = Vector2(0, 0)
var pos2 = Vector2(35,0)

func _ready():
	inMirrorMode = false
	isJumping = false
	isAttacking = false
	facingLeft = false
	isDead = false
	
	speed = 200
	jumpspeed = -11750
	gravity = 7500
	velocity = Vector2()
	
	var levelnode = get_parent()

	stationarytexture = preload("res://FP Assets/percystationary.png")
	stationarymirrortexture = preload("res://FP Assets/percystationarymirror.png")
	striketexture = preload("res://FP Assets/percysword2.png")
	strikemirrortexture = preload("res://FP Assets/percysword2mirror.png")
	deathtexture = preload("res://FP Assets/percydead.png")
	

func die():
	get_child(6).play()
	isDead = true
	get_parent().get_parent().playerIsDead = true
	get_child(1).set_texture(deathtexture)
	
func checkInputPressed():
	velocity = Vector2()
	var jump = Input.is_action_just_pressed("jump")
	if jump:
		get_child(5).stop()
	if jump and is_on_floor():
		isJumping = true
		velocity.y = jumpspeed
	if Input.is_action_pressed("moveLeft") and not isDead:
		if inMirrorMode:
			movePlayerRight()
		else:
			movePlayerLeft()
	if Input.is_action_pressed("moveRight") and not isDead:
		if inMirrorMode:
			movePlayerLeft()
		else:
			movePlayerRight()

func movePlayerLeft():
	velocity.x -= speed
	facingLeft = true

func movePlayerRight():
	velocity.x += speed
	facingLeft = false

func _process(delta):
	if position.y > 600:
		die()
	if position.x >= 1000:
		get_parent().get_parent().gotoNextLevel = true

func _physics_process(delta):
	checkInputPressed()
	velocity.y += gravity * delta
	var onFloor = is_on_floor()
	
	if isJumping and onFloor:
		isJumping = false
	move_and_slide(velocity, Vector2(0, -1))


func _input(event):
	if Input.is_action_just_pressed("mirror"):
		if inMirrorMode:
			inMirrorMode = false
			if isAttacking:
				get_child(1).set_texture(striketexture)
			else:
				get_child(1).set_texture(stationarytexture)
		else:
			inMirrorMode = true
			if isAttacking:
				get_child(1).set_texture(strikemirrortexture)
			else:
				get_child(1).set_texture(stationarymirrortexture)
	if Input.is_action_just_pressed("swing"):
		isAttacking = true
		if not inMirrorMode:
			get_child(1).set_texture(striketexture)
		else:
			get_child(1).set_texture(strikemirrortexture)
		get_child(1).position = pos2
		get_child(3).get_child(0).disabled = false
		get_child(2).start(.25)
			
	
	if Input.is_action_just_pressed("moveLeft"):
		if inMirrorMode:
			switchDirectionRight()
		else:
			switchDirectionLeft()
		if not isJumping:
			get_child(5).play()
	if Input.is_action_just_pressed("moveRight"):
		if inMirrorMode:
			switchDirectionLeft()
		else:
			switchDirectionRight()
		if not isJumping:
			get_child(5).play()
	if (Input.is_action_just_released("moveLeft") and not Input.is_action_pressed("moveRight")) or (Input.is_action_just_released("moveRight") and not Input.is_action_pressed("moveLeft")):
		get_child(5).stop()

func switchDirectionRight():
	if facingLeft:
		facingLeft = false
		get_child(1).flip_h = false
		get_child(3).moveToRight()
		pos2 = Vector2(35, 0)

func switchDirectionLeft():
	if not facingLeft:
		facingLeft = true
		get_child(1).flip_h = true
		get_child(3).moveToLeft()
		pos2 = Vector2(-35, 0)

func _on_Timer_timeout():
	isAttacking = false
	if inMirrorMode:
		get_child(1).set_texture(stationarymirrortexture)
	else:
		get_child(1).set_texture(stationarytexture)
	get_child(1).position = pos1
	get_child(3).get_child(0).disabled=true
