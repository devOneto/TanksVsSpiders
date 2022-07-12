extends RigidBody2D

# Bullet Types: White, Red, Green, Blue
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

#TODO: define different types
export var type: String = 'green'
var damage: int = 1

func _on_Area2D_body_entered(body):
	# TODO: add bullet explosion efect
	if body.is_in_group('Spiders'):
		var spider = body
		spider.hurt(self)
	queue_free()
