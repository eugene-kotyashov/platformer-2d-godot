extends Node
class_name StateMachine

var current_state: State
@export var char_body: CharacterController
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
	print("loaded states")
	for state_name in states.keys():
		print(state_name)
	current_state = states["idle_state"]

# Called when the node enters the scene tree for the first time.
func transition(new_state_name: String):
	if new_state_name == current_state.name:
		# self transition disabled
		return
	var new_state = states.get(new_state_name)
	if new_state == null:
		return
	current_state.on_exit()
	current_state = new_state
	current_state.on_enter()
	
func process_input():
	if Input.is_action_just_pressed("ui_accept"):
		print("ui_accept")
		if char_body.is_on_floor():
			print("transition to jjump")
			transition("jump_state")
			return
	if Input.is_action_pressed("ui_left"):
		transition("walk_state")
		return
	if Input.is_action_pressed("ui_right"):
		transition("walk_state")
		return
	if char_body.is_on_floor():
		transition("idle_state")
		
			
func _physics_process(delta: float) -> void:
	process_input()
	current_state.update(delta)
