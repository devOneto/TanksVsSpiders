extends Node2D

var Spider = preload("res://scenes/Spider.tscn")
var stage = 4
var max_spiders
var rand = RandomNumberGenerator.new()
var types = ['white','red','green','blue']
onready var screen_size = get_viewport().get_visible_rect().size
onready var nex_stage_timer = $NextStageTimer
var is_waiting_next_stage = false

func _ready():
	generate_spiders()
	pass

func _process(delta):
	pass

func _physics_process(delta):
	if get_tree().get_nodes_in_group('Spiders').empty() and !is_waiting_next_stage:
		is_waiting_next_stage = true
		nex_stage_timer.start()
	pass

func generate_spiders():
	var max_spiders = stage * 2
	var actual_spiders = 0
	while(actual_spiders != max_spiders):
		actual_spiders+=1
		var new_spider = Spider.instance()
		var random_type = types[rand.randf_range(0,types.size())]
		var random_x = rand.randf_range(60, screen_size.x)
		var random_y = rand.randf_range(60, screen_size.y)
		new_spider.type = random_type
		new_spider.position.x = random_x
		new_spider.position.y = random_y
		add_child(new_spider)

func _on_NextStageTimer_timeout():
	stage+=1
	generate_spiders()
	is_waiting_next_stage = false
	pass
