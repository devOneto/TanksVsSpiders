extends KinematicBody2D

export(int) var speed = 150
var velocity: Vector2 = Vector2.ZERO 

var rng = RandomNumberGenerator.new()

var type:String = 'blue'
var hp: int = 10
var max_hp:int = 10
var hurting = false
var red_hurt_times = 0

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null

var attack_damage = rng.randi() % 5
var attack_delay = 0.5
var is_attacking: bool = false
var is_player_on_hitbox: bool = false

onready var line2d = $Line2D
onready var attack_timer = $AttackTimer
onready var redDamageTimer = $RedEffectTimer
onready var roar_audio_stream = $AudioStreamPlayer

onready var power_sphere = preload('res://scenes/PowerSphereItem.tscn')

var entityType: String = 'Spider'

func _ready():
	yield(get_tree(),"idle_frame")
	
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]	
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
		
	attack_timer.wait_time = attack_delay
	
func _physics_process(delta):
	# Movement
	get_node("LifeProgressBar").value = hp  * 100/max_hp
	if player and levelNavigation:
		generate_path()
		navigate()
	velocity = move_and_slide(velocity)
	# Life Controller
	if(self.hp <= 0): die()
	# Attack Controller
	if(is_player_on_hitbox and !is_attacking):
		attack_timer.start()
		is_attacking = true
	
	if Input.is_action_just_pressed("test"): die()

func navigate():
	if path.size()>0 :
		velocity = global_position.direction_to(path[1]) * speed
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	if levelNavigation != null and player != null :
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)

func apply_bullet_effect(type: String):
	if type == 'white': white_hurt_effect()
	if type == 'red': red_hurt_effect()
	if type == 'green': green_hurt_effect()
	if type == 'blue': blue_hurt_effect()

func drop_sphere():
	var droped_power_sphere = power_sphere.instance()
	droped_power_sphere.position = self.position
	droped_power_sphere.mutate(type)
	get_parent().add_child(droped_power_sphere)
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group('Player'): 
		is_player_on_hitbox = true

func _on_HitBox_body_exited(body):
	if body.is_in_group('Player'): 
		is_player_on_hitbox = false

func _on_AttackTimer_timeout():
	player.hurt(attack_damage)
	is_attacking = false

func hurt(bullet):
	roar_audio_stream.play()
	#TODO: Add animation
	apply_bullet_effect(bullet.type)

func white_hurt_effect(): 
	self.hp -= 5

func red_hurt_effect(): 
	redDamageTimer.start()

func blue_hurt_effect():
	self.hp -= 3 
	self.speed -= 25 
	pass

func green_hurt_effect():
	player.cure()

func _on_RedDamageTimer_timeout():
	hp -= 1
	red_hurt_times+=1
	if(red_hurt_times==3): 
		redDamageTimer.stop()
		red_hurt_times = 0

func die():
	#TODO: Drop random power sphere
	drop_sphere()
	#TODO: Play death animation
	queue_free()

