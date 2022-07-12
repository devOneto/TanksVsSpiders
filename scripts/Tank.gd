extends KinematicBody2D

# Getting Child Nodes
onready var tank_sprite = $Sprite
onready var fire_cadense_timer = $FireCadenceTimer
onready var reload_timer = $ReloadTimer
onready var life_progress_bar = $LifeProgressBar

# Getting External Scenes
var Bullet = preload("res://scenes/Bullet.tscn")
onready var Hud = get_parent().get_node("HUD")

# Physics Variables
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

# Entity Properties
var max_hp: int
var hp: int
var move_speed = 200
var bullet_stack = []
var bullet_speed = 800

func _ready():
	self.max_hp = 20
	self.hp = self.max_hp
	input_reload()

func _physics_process(delta):
	# Life Controller
	life_progress_bar.value = hp  * 100/max_hp
	if self.hp <= 0: die()
	# Movement Controller
	var input_vector: Vector2
	var lr_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var ud_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if (lr_input != 0 and ud_input == 0) or (lr_input == 0 and ud_input != 0 ) :
		input_vector = Vector2( lr_input, ud_input )
	var move_direction := input_vector.normalized()
	move_and_slide(move_speed * move_direction)
	# HUD Controller
	Global.bullet_stack = bullet_stack
	# Fire Controller
	if Input.is_action_just_pressed("fire"): 
		if bullet_stack.size() != 0:
			fire()
	if Input.is_action_just_pressed("reload"): 
		input_reload()

func _process(delta):
	pass

func hurt(damage: int):
	hp-=damage

func fire():
	Hud.get_node("HBoxContainer").get_node("BulletStackControl").remove_bullet()
	var bullet = bullet_stack[-1]
	bullet_stack.pop_back()
	bullet.rotation = tank_sprite.rotation
	bullet.position = get_global_position()
	bullet.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(tank_sprite.rotation - PI/2))
	get_tree().get_root().add_child(bullet)
	pass

func reload(bullet):
	Hud.get_node("HBoxContainer").get_node("BulletStackControl").add_bullet(bullet)
	var new_bullet = Bullet.instance()
	new_bullet.type = bullet.type
	bullet_stack.append(new_bullet)
	pass

func input_reload():
	for i in [0,1,2,3,4]:
		var new_bullet = Bullet.instance()
		new_bullet.type = 'white'
		self.bullet_stack.append(new_bullet)
		Hud.get_node("HBoxContainer").get_node("BulletStackControl").add_bullet(new_bullet)

func cure():
	self.hp+=2

func _on_ReloadTimer_timeout():
	pass

func die():
	get_tree().change_scene("res://scenes/Levels/GameOver.tscn")
