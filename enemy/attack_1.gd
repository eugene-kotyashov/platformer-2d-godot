extends State

@export var attack1_area : Area2D

func set_atack_area_active(active : bool):
	attack1_area.set_deferred( "monitorable", active)
	attack1_area.set_deferred( "monitoring", active)
	
func _ready() -> void:
	name = "attack1_state"
	
func on_enter() -> void:
	super.on_enter()
	set_atack_area_active(true)
	
func on_exit() -> void:
	set_atack_area_active(false)
