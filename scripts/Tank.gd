extends KinematicBody2D

const UP = Vector2(0,-1)
const RIGHT = Vector2(1,0)
const DOWN = Vector2(0,1)
const LEFT = Vector2(-1,0)

onready var sprite = $Sprite
onready var line = $Line2D

var bullet = preload("res://scenes/Bullet.tscn")
var bullet_speed = 1000
var isShooting = false
onready var FireCadenseTimer = get_node("FireCadenceTimer")

var bullet_stack: Array
onready var bullet_stack_hud = get_node("BulletStackHUD")
onready var reload_timer = get_node("ReloadTimer")
var isReloading = false

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var move_speed = 200

var hp: int = 5
	
func _ready():
	# Define basic status
	reload()

func hurt():
	var life = get_node("Life")
	var hurted: bool = false
	#TODO: implement damage affection according to spider type
	for lifeHeart in life.get_children():
		if !hurted and lifeHeart.is_visible():
			lifeHeart.hide()
			hurted = true

func fire(bullet):
	bullet.rotation = sprite.rotation
	bullet.position = get_global_position()
	bullet.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(sprite.rotation - PI/2))
	get_tree().get_root().add_child(bullet)
	# Remove shooted bullet -> actual bullet_stack[0]
	bullet_stack.pop_front()

func _physics_process(delta):
	var input_vector: Vector2
	
	# Input Detection:
	var lr_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var ud_input = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if (lr_input != 0 and ud_input == 0) or (lr_input == 0 and ud_input != 0 ) :
		input_vector = Vector2( lr_input, ud_input )
	# Get Move Direction
	var move_direction := input_vector.normalized()
	# Finally, Move!
	move_and_slide(move_speed * move_direction)
	
	# Debug
	if Input.is_action_just_pressed("test"): print(bullet_stack)
	
	# Identify Ammunition
	if !bullet_stack.empty():
		# Input Fire
		# Always takes the first bullet
		# TODO: Add delay to fire
		
		if !isShooting and Input.is_action_just_pressed("fire"): 
			isShooting = true
			FireCadenseTimer.start()
			fire(bullet_stack[0])
		var last_bullet = bullet_stack.size() - 1
		bullet_stack_hud.hide_bullet(last_bullet)
	else:
		#Reload Delay
		if !isReloading : reload_timer.start()
		# Define Behaviour Flag
		isReloading = true

func _process(delta):
	line.points = [Vector2(0,0),Vector2(0,-1).rotated(sprite.rotation) * 50]
	pass

func reload():
	for i in 6:
		var new_bullet = bullet.instance()
		new_bullet.type = 'white'
		bullet_stack.append(new_bullet)
	get_node("BulletStackHUD").reload_bullet_stack_hud()

func _on_ReloadTimer_timeout():
	reload()
	isReloading = false
	pass

func reload_special_bullet(type: String):
	if bullet_stack.size() < 6:
		var new_special_bullet = bullet.instance()
		new_special_bullet.type = type
		bullet_stack.append(new_special_bullet)
		bullet_stack_hud.reload_special_bullet_hud(bullet_stack.size() - 2, type )

func _on_FireCadenceTimer_timeout():
	isShooting = false
	pass # Replace with function body.
