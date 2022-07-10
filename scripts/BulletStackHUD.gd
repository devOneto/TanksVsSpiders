extends Node2D

var BULLET_COLOR_SPHERE_MAP = {
	'white':white_sphere_texture,
	'red':red_sphere_texture,
	'green':green_sphere_texture,
	'blue':blue_sphere_texture,
}

# TODO: rename assets according to color
var white_sphere_texture = preload('res://assets/objects/spheres/sprite_0.png')
var red_sphere_texture = preload('res://assets/objects/spheres/sprite_2.png')
var green_sphere_texture = preload('res://assets/objects/spheres/sprite_3.png')
var blue_sphere_texture = preload('res://assets/objects/spheres/sprite_1.png')

func reload_bullet_stack_hud():
	for bullet_in_hud in get_children():
		bullet_in_hud.show()

func hide_bullet(index:int):
	get_children()[index].hide()
