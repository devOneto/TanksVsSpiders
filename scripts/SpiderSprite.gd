extends Sprite

var white_spider_texture = preload('res://assets/spiders/white-spider.png')
var red_spider_texture = preload('res://assets/spiders/red-spider.png')
var green_spider_texture = preload('res://assets/spiders/green-spider.png')
var blue_spider_texture = preload('res://assets/spiders/blue-spider.png')

var SPIDER_COLOR_TYPE_MAP = {
	'white':white_spider_texture,
	'red':red_spider_texture,
	'green':green_spider_texture,
	'blue':blue_spider_texture,
}

onready var body = get_parent()
onready var type

func _ready():
	type = body.type

func _process(delta):
	self.texture = SPIDER_COLOR_TYPE_MAP[self.type]
