extends State

@export var jump_speed: float = -100

func _ready() -> void:
	name="jump_state"

func update(delta: float) -> void:
	print("jumping")
	char_body.velocity.y += jump_speed
	char_body.move_and_slide()
