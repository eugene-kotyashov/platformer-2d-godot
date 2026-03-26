extends State

@export var speed: float = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name = "walk_state"

func update(delta: float) -> void:
	# print("walking")
	var dir=Input.get_axis("ui_left", "ui_right")
	animations.flip_h = (dir < 0)
	char_body.velocity.x = dir*speed
	char_body.velocity.y += delta*char_body.gravity.y
	char_body.move_and_slide()
	
