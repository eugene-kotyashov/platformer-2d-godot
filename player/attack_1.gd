extends State

@export var attack_area : Area2D

func _ready() -> void:
	name = "attack1_state"

func set_atack_area_active(active : bool):
	attack_area.set_deferred( "monitorable", active)
	attack_area.set_deferred( "monitoring", active)
	
func on_enter() -> void:
	super.on_enter()
	set_atack_area_active(true)

func on_exit() -> void:
	set_atack_area_active(false)
	
func update(_delta: float) -> void:
	pass
	#print("attack1")
