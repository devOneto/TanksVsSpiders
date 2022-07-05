extends KinematicBody2D

const UP = Vector2(0,-1)
const RIGHT = Vector2(1,0)
const DOWN = Vector2(0,1)
const LEFT = Vector2(-1,0)

var bullet = preload("res://scenes/YellowBullet.tscn")
var bullet_speed = 200

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var move_speed = 200

var hp: int = 5

func hurt():
	var life = get_node("Life")
	var hurted: bool = false
	for lifeHeart in life.get_children():
		if !hurted and lifeHeart.is_visible():
			lifeHeart.hide()
			hurted = true

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)

func _ready():
	pass

func _physics_process(delta):
	# Input Detection:
	var input_vector := Vector2( 
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
	# Get Move Direction
	var move_direction := input_vector.normalized()
	# Finally, Move!
	move_and_slide(move_speed * move_direction)

func _process(delta):
	pass
