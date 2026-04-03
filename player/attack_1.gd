extends State

@export var property_player: AnimationPlayer

	
func _ready() -> void:
	name = "attack1_state"
	
func on_enter() -> void:
	super.on_enter()
	property_player.play("attack1_area_active")
	
func on_exit() -> void:
	property_player.stop()
