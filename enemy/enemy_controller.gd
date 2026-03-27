extends CharacterController

@export var max_health: float = 100
@export var attack_damage: float = 10
@export var state_machine: StateMachine
@onready var animations: AnimatedSprite2D = $AnimatedSprite2D

var target_player: CharacterController
var gravity: Vector2 = Vector2(0, 100)

var health: float


func _physics_process(_delta: float) -> void:
	if is_on_floor():
		state_machine.transition("walk_state")
	else:
		state_machine.transition("air_state")
