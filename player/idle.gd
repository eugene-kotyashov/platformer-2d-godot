extends State

func _ready() -> void:
	name = "idle_state"
	
func update(_delta: float) -> void:
	char_body.velocity.x = 0
	char_body.move_and_slide()
	#print("idling")
