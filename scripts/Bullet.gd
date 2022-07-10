extends RigidBody2D

# Bullet Types: White, Red, Green, Blue

#TODO: define different types
var type: String = 'White'
var damage: int = 1

func _ready():
	pass

func _on_Area2D_body_entered(body):
	# TODO: add bullet explosion efect
	if body.name == 'Spider':
		var spider = body
		spider.hurt(self)
	queue_free()

