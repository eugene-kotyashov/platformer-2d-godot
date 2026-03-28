extends Node
class_name StateMachine

@export var current_state: State
@export var character_body : CharacterBody2D
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.char_body = character_body
	print(character_body.name + " loaded states")
	for state_name in states.keys():
		print("\t" + state_name)
	

# Called when the node enters the scene tree for the first time.
func transition(new_state_name: String):
	if new_state_name == current_state.name:
		# self transition disabled
		return
	var new_state = states.get(new_state_name)
	if new_state == null:
		return
	if !current_state.can_transition:
		return
	current_state.on_exit()
	print(character_body.name + " exitting " + current_state.name )
	current_state = new_state
	print(character_body.name + " entering " + current_state.name)
	current_state.on_enter()
		
			
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
