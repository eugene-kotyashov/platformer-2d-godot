extends CharacterController

@export var state_machine : StateMachine
@onready var attack1_area : Area2D = $Attack1Area
@onready var attack1_damage : float = 50
@export var max_health : float = 100
var health: float

#@onready var state_machine : StateMachine = $StateMachine
var gravity: Vector2 = Vector2(0, 100)

func get_attack_damage():
	return attack1_damage
	
func process_input():
	move_direction=Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("attack"):
		if is_on_floor():
			state_machine.transition("attack1_state")
			return
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

func _physics_process(_delta: float) -> void:
	process_input()
