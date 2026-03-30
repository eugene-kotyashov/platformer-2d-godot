extends State

@export var speed: float = 10

func _ready() -> void:
	name="air_state"

func update(delta: float) -> void:
	var dir=char_body.move_direction
	char_body.velocity.x = dir*speed
	char_body.velocity += char_body.gravity*delta
	char_body.move_and_slide()
	# print(name)
