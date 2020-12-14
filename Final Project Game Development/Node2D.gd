extends Node2D

var inMirrorMode = false
var normaltexture = preload("res://FP Assets/Background.jpg")
var mirrortexture = preload("res://FP Assets/MirrorBackground.jpg")
var screenPaths = ["res://Screen1.tscn","res://Screen2.tscn","res://Screen3.tscn","res://Screen4.tscn","res://Screen5.tscn"]
var playerIsDead = false
var gotoNextLevel = false
var currentlevel = 0
var currentlevelscene = preload("res://Screen1.tscn").instance() as Node2D
var timer

func _ready():
	timer = get_child(1).get_child(1)

func _input(event):
	if Input.is_action_just_pressed("mirror"):
		if not inMirrorMode:
			get_child(0).set_texture(mirrortexture)
			inMirrorMode = true
		else:
			get_child(0).set_texture(normaltexture)
			inMirrorMode = false

func _process(delta):
	if playerIsDead:
		playerIsDead = false
		timer.start(1.5)
	if gotoNextLevel:
		gotoNextLevel = false
		currentlevel += 1
		if currentlevel == 4:
			get_child(1).get_child(0).stop()
			get_child(1).get_child(2).play()
		remove_child(get_child(2))
		currentlevelscene = load(screenPaths[currentlevel]).instance() as Node2D
		add_child(currentlevelscene)

func restartScreen():
	remove_child(get_child(2))
	add_child(currentlevelscene)


func _on_Timer_timeout():
	restartScreen()
	currentlevelscene = load(screenPaths[currentlevel]).instance() as Node2D
	timer.stop()
