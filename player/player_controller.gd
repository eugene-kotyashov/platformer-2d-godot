extends CharacterController

@export var state_machine : StateMachine
@onready var attack1_area : Area2D = $Attack1Area
@onready var animations : AnimatedSprite2D = $AnimatedSprite2D
@onready var attack1_damage : float = 50
@export var max_health : float = 100
var health: float

#@onready var state_machine : StateMachine = $StateMachine
var gravity: Vector2 = Vector2(0, 100)


func get_attack_damage():
	return attack1_damage
	
func _ready() -> void:
	scale.x = 1
	velocity = Vector2.ZERO

func update_move_dir_from_input():
	var dir_input = Input.get_axis("ui_left", "ui_right")
	# print("dir_input ", dir_input)
	if dir_input > 0:
		return 1
	if dir_input < 0:
		return -1
	return move_direction

func change_move_dir():
	if move_direction > 0:
		animations.flip_h = false
	if move_direction < 0:
		animations.flip_h = true


func change_attack_dir():
	if move_direction > 0:
		attack1_area.position.x = 3
	if move_direction < 0:
		attack1_area.position.x = -3
	
func process_input():
	
	var new_direction=update_move_dir_from_input()
	
	if move_direction != new_direction:
		move_direction = new_direction
		change_move_dir()
		change_attack_dir()
	
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
	print(name + " vx ", velocity.x)
