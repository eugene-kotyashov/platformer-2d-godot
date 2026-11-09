extends State

@export var friction: float = 500.0

func _ready() -> void:
	name = "hurt_state"

func on_enter() -> void:
	super.on_enter()

func update(delta: float) -> void:
	char_body.velocity.x = move_toward(char_body.velocity.x, 0.0, friction * delta)
	if char_body.is_on_floor():
		char_body.velocity.y = 0
	else:
		char_body.velocity += char_body.gravity * delta
	char_body.move_and_slide()
