extends State

func _ready() -> void:
	name = "death_state"
	
func on_enter() -> void:
	super.on_enter()
	char_body.is_alive = false
