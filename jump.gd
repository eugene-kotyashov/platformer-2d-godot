extends State

func _ready() -> void:
	name="jump_state"
	
func on_enter() -> void:
	char_body.velocity.y += 10

func update(delta: float) -> void:
	print("jumping")
	char_body.velocity += delta*char_body.gravity
	char_body.move_and_slide()
