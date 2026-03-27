extends State

@export var speed: float = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name = "walk_state"

func update(_delta: float) -> void:
	# print("walking")
	animations.flip_h = (char_body.move_direction<0)
	char_body.velocity.x = char_body.move_direction*speed
	char_body.move_and_slide()
