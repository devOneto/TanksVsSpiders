extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO
var move_speed = 200

var hp: int = 5

func _ready():
	pass

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	pass

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
	elif Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * move_speed

func hurt():
	var life = get_node("Life")
	var hurted: bool = false
	for lifeHeart in life.get_children():
		if !hurted and lifeHeart.is_visible():
			lifeHeart.hide()
			hurted = true
		
