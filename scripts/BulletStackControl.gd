extends Control

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

var bullet_stack
var bullet_stack_hud

func _process(delta):
	bullet_stack_hud = get_children()

func add_bullet(bullet):
	var new_power_sphere_hud = Sprite.new()
	new_power_sphere_hud.texture = BULLET_COLOR_SPHERE_MAP[bullet.type]
	new_power_sphere_hud.position.x = 50 + 50*bullet_stack_hud.size()
	new_power_sphere_hud.position.y = 40
	new_power_sphere_hud.scale = Vector2(0.2,0.2)
	add_child(new_power_sphere_hud)

func remove_bullet():
	bullet_stack_hud[-1].queue_free()
