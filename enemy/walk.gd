extends State

@export var speed: float = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name = "walk_state"

func update(_delta: float) -> void:
	# print("walking")
	char_body.velocity.x = speed
	char_body.move_and_slide()
