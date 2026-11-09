extends State

@export var speed: float = 10

func _ready() -> void:
	name="air_state"

func update(delta: float) -> void:
	char_body.velocity.x = char_body.move_direction * speed
	char_body.velocity += char_body.gravity * delta
	char_body.move_and_slide()
