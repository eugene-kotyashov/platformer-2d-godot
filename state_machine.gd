extends Node
class_name StateMachine

@export var current_state: State
@export var idle : State
@export var walk : State
@export var air : State
@export var jump : State
@export var hurt : State
@export var death : State
@export var attack1 : State
	

# Called when the node enters the scene tree for the first time.
func transition(new_state: State, force_transition: bool=false):
	if new_state == current_state:
		# self transition disabled
		return
	if new_state == null:
		return
	var parent = get_parent()
	if !current_state.can_transition:
		if !force_transition:
			return
		else:
			print(parent.name + " force transitioning to " + new_state.name)
	current_state.on_exit()
	print(parent.name + " exitting " + current_state.name )
	current_state = new_state
	print(parent.name + " entering " + current_state.name)
	current_state.on_enter()
		
			
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update_duration(delta)
		current_state.update(delta)
