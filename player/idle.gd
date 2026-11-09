extends State

func _ready() -> void:
	name = "idle_state"
	
func update(delta: float) -> void:
	char_body.velocity.x = 0
	if char_body.is_on_floor():
		char_body.velocity.y = 0
	else:
		char_body.velocity += char_body.gravity * delta
	char_body.move_and_slide()
