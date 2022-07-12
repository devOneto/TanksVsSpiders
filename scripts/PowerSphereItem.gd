extends Area2D

var white_sphere_texture = preload('res://assets/spheres/white_sphere.png')
var red_sphere_texture = preload('res://assets/spheres/red_sphere.png')
var green_sphere_texture = preload('res://assets/spheres/green_sphere.png')
var blue_sphere_texture = preload('res://assets/spheres/blue_sphere.png')

var BULLET_COLOR_SPHERE_MAP = {
	'white':white_sphere_texture,
	'red':red_sphere_texture,
	'green':green_sphere_texture,
	'blue':blue_sphere_texture,
}

var Bullet = preload("res://scripts/Bullet.gd")

var type: String
var sphere_scale = Vector2(0.12, 0.12)

func _ready():
	pass

func mutate(type:String):
	self.type = type
	var sphere_item_sprite = self.get_node("SphereItemSprite")
	sphere_item_sprite.set_texture(BULLET_COLOR_SPHERE_MAP[type])
	sphere_item_sprite.set_scale(sphere_scale)


func _on_Node2D_body_entered(body):
	#TODO: if spiders take sphere they get stronger! hahaha
	if body.is_in_group('Player'):
		var new_bullet = Bullet.new()
		new_bullet.type = self.type
		body.reload(new_bullet)
		queue_free()
	pass # Replace with function body.
