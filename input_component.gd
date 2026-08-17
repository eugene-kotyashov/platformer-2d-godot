extends Node
class_name InputComponent

@export var physics : PhysicsComponent
@export var health : HealthComponent
@export var state_machine : StateMachine
@export var visuals : VisualsComponent
@export var attack1 : AttackComponent
@export var attack2 : AttackComponent


func update_move_dir_from_input():
	var dir_input = Input.get_axis("ui_left", "ui_right")
	# print("dir_input ", dir_input)
	if dir_input > 0:
		return 1
	if dir_input < 0:
		return -1
	return physics.move_direction

func _physics_process(delta : float) -> void:
	if !health.is_alive:
		return
	var new_direction=update_move_dir_from_input()
	
	if physics.move_direction != new_direction:
		physics.move_direction = new_direction
		visuals.change_move_dir(new_direction)
		attack1.change_attack_dir(new_direction)
		attack2.change_attack_dir(new_direction)
	
	if Input.is_action_pressed("attack"):
		if physics.is_on_floor():
			state_machine.transition(state_machine.attack1)
			return
	if Input.is_action_pressed("attack_two"):
		if physics.is_on_floor():
			state_machine.transition(state_machine.attack2)
			return
	if !physics.is_on_floor():
		state_machine.transition(state_machine.air)
		return
	if Input.is_action_just_pressed("ui_accept"):
		# print("ui_accept")
		if physics.is_on_floor():
			state_machine.transition(state_machine.jump)
			return
	if Input.is_action_pressed("ui_left"):
		state_machine.transition(state_machine.walk)
		return
	if Input.is_action_pressed("ui_right"):
		state_machine.transition(state_machine.walk)
		return
	if physics.is_on_floor():
		state_machine.transition(state_machine.idle)
