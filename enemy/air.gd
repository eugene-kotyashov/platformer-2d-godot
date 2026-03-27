extends State

@export var speed: float = 10

func _ready() -> void:
	name="air_state"

func update(delta: float) -> void:
	char_body.velocity += char_body.gravity*delta
	var dir=Input.get_axis("ui_left", "ui_right")
	animations.flip_h = (dir < 0)
	char_body.velocity.x = dir*speed
	char_body.move_and_slide()
	# print(name)
