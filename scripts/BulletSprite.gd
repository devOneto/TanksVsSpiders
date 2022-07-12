extends Sprite

var white_bullet_sprite = preload('res://assets/bullets/white_bullet.png')
var red_bullet_sprite = preload('res://assets/bullets/red_bullet.png')
var green_bullet_sprite = preload('res://assets/bullets/green_bullet.png')
var blue_bullet_sprite = preload('res://assets/bullets/blue_bullet.png')

var BULLET_COLOR_SPHERE_MAP = {
	'white':white_bullet_sprite,
	'red':red_bullet_sprite,
	'green':green_bullet_sprite,
	'blue':blue_bullet_sprite,
}

func _process(delta):
	var type = get_parent().type
	texture = BULLET_COLOR_SPHERE_MAP[type]
	scale = Vector2(0.2,0.2)
