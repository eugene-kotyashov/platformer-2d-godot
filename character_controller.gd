extends CharacterBody2D
class_name CharacterController

@export var state_machine : StateMachine

#@onready var state_machine : StateMachine = $StateMachine
var gravity: Vector2 = Vector2(0, 100)

func process_input():
	if !is_on_floor():
		state_machine.transition("air_state")
		return
	if Input.is_action_just_pressed("ui_accept"):
		print("ui_accept")
		if is_on_floor():
			state_machine.transition("jump_state")
			return
	if Input.is_action_pressed("ui_left"):
		state_machine.transition("walk_state")
		return
	if Input.is_action_pressed("ui_right"):
		state_machine.transition("walk_state")
		return
	if is_on_floor():
		state_machine.transition("idle_state")

func _physics_process(delta: float) -> void:
	process_input()
