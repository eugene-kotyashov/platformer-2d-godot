extends Node
class_name StateMachine

@export var char_body: PhysicsComponent
@export var animations: AnimationComponent
@export var current_state: State
@export var idle : State
@export var walk : State
@export var air : State
@export var jump : State
@export var hurt : State
@export var death : State
@export var attack1 : State
@export var attack2: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			child.char_body = char_body
			child.animations = animations
	if attack1 != null:
		attack1.char_body = char_body
		attack1.animations = animations
	if attack2 != null:
		attack2.char_body = char_body
		attack2.animations = animations

# Called when the node enters the scene tree for the first time.
func transition(new_state: State, force_transition: bool=false):
	if new_state == current_state:
		# self transition disabled
		return
	if new_state == null:
		return
	if !current_state.can_transition:
		if !force_transition:
			return
	current_state.on_exit()
	current_state = new_state
	current_state.on_enter()
		
			
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update_duration(delta)
		current_state.update(delta)
