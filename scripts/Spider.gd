extends KinematicBody2D

export(int) var speed = 100
var velocity: Vector2 = Vector2.ZERO 

var type:String = ''
var hp: int = 3

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null

var attack_delay = 0.5
var is_attacking: bool = false

onready var line2d = $Line2D
onready var timer = $Timer as Timer

func _ready():
	yield(get_tree(),"idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]	
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
	timer.wait_time = attack_delay
	
	
func _physics_process(delta):
	#line2d.global_position = Vector2.ZERO
	if player and levelNavigation:
		generate_path()
		navigate()
		if position.distance_to(player.position) <= 80:
			if(!is_attacking):
				timer.start()
				is_attacking = true
	move()
	pass

func navigate():
	if path.size()>0 :
		velocity = global_position.direction_to(path[1]) * speed
		if global_position == path[0]:
			path.pop_front()
	pass
	
func generate_path():
	if levelNavigation != null and player != null :
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		#line2d.points = path
	pass

func move():
	velocity = move_and_slide(velocity)

func attack():
	# TODO: fix this horrible access
	player.hurt()

func hurt(bullet):
	var life = get_node("Life")
	var hurted: bool = false
	#TODO: Add damage life reduction
	#TODO: Add animation
	self.hp -= bullet.damage
	for lifeHeart in life.get_children():
		if !hurted and lifeHeart.is_visible():
			lifeHeart.hide()
			hurted = true
	if(self.hp <= 0): die()

func die():
	#TODO: Play death animation
	queue_free()

func _on_Timer_timeout():
	attack()
	is_attacking = false
