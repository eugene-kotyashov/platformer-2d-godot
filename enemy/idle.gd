extends State

func _ready() -> void:
	name = "idle_state"

func on_enter() -> void:
	super.on_enter()
	char_body.velocity.x = 0
	char_body.move_and_slide()
