extends Sprite

const ROTATION_MAP = {
	Vector2.UP: 0,
	Vector2.DOWN: 180,
	Vector2.LEFT: 270,
	Vector2.RIGHT: 90,
	Vector2( 1.0, 1.0 ): 90, # down_right
	Vector2( 1.0, -1.0 ): 0, # up_right
	Vector2( -1.0, -1.0 ): 270, # up_left
	Vector2( -1.0, 1.0 ): 180, # down_left
}

var look_direction := Vector2.UP

func _ready():
	pass # Replace with function body.

func _process(delta):
	var input_vector := Vector2( 
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)
	if input_vector.length() > 0.0 and input_vector != look_direction:
		self.rotation_degrees = ROTATION_MAP[input_vector]
		look_direction = input_vector
