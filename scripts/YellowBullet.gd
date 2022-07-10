extends RigidBody2D

#TODO: define different types
var type: String = 'Yellow'
var damage: int = 1

func _ready():
	pass

func _on_Node2D_body_entered(body):
	print(body)
	pass

func _on_Area2D_body_entered(body):
	# TODO: add bullet explosion efect
	if body.name == 'Spider':
		var spider = body
		spider.hurt(self)
	queue_free()

