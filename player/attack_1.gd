extends State

@export var attack_area : Area2D

func _ready() -> void:
	name = "attack1_state"

func on_enter() -> void:
	super.on_enter()
	attack_area.monitorable = true
	attack_area.monitoring = true

func on_exit() -> void:
	attack_area.monitorable = false
	attack_area.monitoring = false
	
func update(_delta: float) -> void:
	print("attack1")
