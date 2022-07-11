extends Node2D

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

func reload_bullet_stack_hud():
	for bullet_in_hud in get_children():
		bullet_in_hud.show()
		bullet_in_hud.texture = BULLET_COLOR_SPHERE_MAP['white']

func hide_bullet(index:int):
	get_children()[index].hide()
	
func reload_special_bullet_hud(index: int, type: String):
	get_children()[index].texture = BULLET_COLOR_SPHERE_MAP[type]
	get_children()[index].show()
