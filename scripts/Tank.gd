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

var bulletStack = []

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var move_speed = 200

var hp: int = 5

func hurt():
	var life = get_node("Life")
	var hurted: bool = false
	#TODO: implement damage affection according to spider type
	for lifeHeart in life.get_children():
		if !hurted and lifeHeart.is_visible():
			lifeHeart.hide()
			hurted = true

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.rotation = sprite.rotation
	bullet_instance.position = get_global_position()
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(sprite.rotation - PI/2))
	get_tree().get_root().add_child(bullet_instance)
	
func _ready():
	pass

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
	# Input Fire
	isShooting = fire() if Input.is_action_just_pressed("fire") else false

func _process(delta):
	line.points = [Vector2(0,0),Vector2(0,-1).rotated(sprite.rotation) * 50]
	pass
