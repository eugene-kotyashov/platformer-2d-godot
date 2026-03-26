extends CharacterBody2D
class_name CharacterController

#@onready var state_machine : StateMachine = $StateMachine
var gravity: Vector2 = Vector2(0, 10)

func _physics_process(delta: float) -> void:
	pass
	#state_machine.process_input()
