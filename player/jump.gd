extends State

@export var jump_speed: float = -100

func _ready() -> void:
	name="jump_state"

func on_enter() -> void:
	super.on_enter()
	char_body.velocity.y = jump_speed

func update(delta: float) -> void:
	char_body.velocity += char_body.gravity * delta
	char_body.move_and_slide()
