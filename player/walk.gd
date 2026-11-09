extends State


@export var speed: float = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name = "walk_state"

func update(delta: float) -> void:
	char_body.velocity.x = char_body.move_direction * speed
	if char_body.is_on_floor():
		char_body.velocity.y = 0
	else:
		char_body.velocity += char_body.gravity * delta
	char_body.move_and_slide()
