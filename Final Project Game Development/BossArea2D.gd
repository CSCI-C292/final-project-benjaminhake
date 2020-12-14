extends Area2D

var health
var attacking
var onFloor

var frog 
var snake
var spider
var player

var audioDeath
var audioLaugh
var audioHurt

var sprite
var timer

var rng
var frogandsnakeposition

var attackingsprite
var normalsprite

func _ready():
	health = 20
	attacking = false
	onFloor = true
	
	audioHurt = get_child(3).get_child(1)
	audioDeath = get_child(3).get_child(2)
	audioLaugh = get_child(3).get_child(0)
	
	frog = preload("res://FrogKinematicBody2D.tscn")
	snake = preload("res://SnakeKinematicBody2D.tscn")
	spider = preload("res://SpiderStaticBody2D.tscn")
	
	sprite = get_child(0)
	timer = get_child(2)
	
	frogandsnakeposition = Vector2(position.x - 20, position.y - 20)
	rng = RandomNumberGenerator.new()
	
	attackingsprite = preload("res://FP Assets/medusaattack.png")
	normalsprite = preload("res://FP Assets/medusa-removebg-preview.png")
	
func spawnEnemy():
	rng.randomize()
	var spawnnumber = rng.randi_range(0,3)
	if spawnnumber == 2:
		audioLaugh.play()
	for i in range(spawnnumber):
		rng.randomize()
		var whichenemy = rng.randi_range(0,3)
		if whichenemy == 0:
			spawnSnake()
		elif whichenemy == 1:
			spawnSpider()
		else:
			spawnFrog()

func spawnFrog():
	var frogi1 = frog.instance()
	frogi1.position = spawnRandomPosition()
	get_parent().add_child(frogi1)

func spawnSnake():
	var snakei1 = snake.instance()
	snakei1.position = spawnRandomPosition()
	get_parent().add_child(snakei1)

func spawnSpider():
	var spideri1 = spider.instance()
	#rng.randomize()
	var randx = rand_range(40, get_viewport().size.x - 40)
	spideri1.position = Vector2(randx, 0)
	get_parent().add_child(spideri1)

func spawnRandomPosition():
	#rng.randomize()
	var xDiff = rand_range(position.x - 100.0, position.y-20.0)
	return Vector2(xDiff, position.y - 20)
	
func _on_Timer_timeout():
	if attacking:
		attacking = false
		sprite.set_texture(normalsprite)
		timer.start(6.0)
	else:
		attacking = true
		sprite.set_texture(attackingsprite)
		timer.start(.25)
		spawnEnemy()

func takeDamage():
	if health > 1:
		health -= 1
		audioHurt.play()
	else:
		timer.stop()
		audioDeath.play()

func _on_BossArea2D_area_entered(area):
	match area.get_groups():
		["sword"]:
			takeDamage()
