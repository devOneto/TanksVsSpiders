extends RigidBody2D

func _ready():
	pass

func _on_Node2D_body_entered(body):
	print(body)
	pass


func _on_Area2D_body_entered(body):
	# TODO: add bullet explosion efect and sprite animation
	if body.name == 'Spider':
		body.queue_free()
		queue_free()
	pass
