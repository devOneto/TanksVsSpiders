extends KinematicBody2D

export(int) var speed = 100
var velocity: Vector2 = Vector2.ZERO 

var type:String = 'blue'
var hp: int = 10
var max_hp:int = 10

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null

var attack_delay = 0.5
var is_attacking: bool = false

onready var line2d = $Line2D
onready var timer = $Timer as Timer

onready var power_sphere = preload('res://scenes/PowerSphereItem.tscn')

func _ready():
	yield(get_tree(),"idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]	
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
	timer.wait_time = attack_delay
	
	
func _physics_process(delta):
	get_node("LifeProgressBar").value = hp  * 100/max_hp
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
	#TODO: Add animation
	self.hp -= bullet.damage
	if(self.hp <= 0): die()

func die():
	#TODO: Drop random power sphere
	drop_sphere()
	#TODO: Play death animation
	queue_free()

func drop_sphere():
	var droped_power_sphere = power_sphere.instance()
	droped_power_sphere.position = self.position
	droped_power_sphere.mutate(type)
	get_parent().add_child(droped_power_sphere)
	pass

func _on_Timer_timeout():
	attack()
	is_attacking = false
