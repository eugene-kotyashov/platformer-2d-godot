extends Node
class_name InputComponent

@export var physics : PhysicsComponent
@export var health : HealthComponent
@export var state_machine : StateMachine
@export var visuals : VisualsComponent
@export var attack1 : AttackComponent
@export var attack2 : AttackComponent

## Grace period after leaving the ground during which a jump still works.
@export var coyote_time: float = 0.1
## How early a jump press is remembered before landing.
@export var jump_buffer_time: float = 0.12
## Upward velocity is multiplied by this when the jump button is released early.
@export var jump_release_multiplier: float = 0.5

var _time_since_on_floor: float = 0.0
var _jump_buffer_left: float = 0.0

func update_move_dir_from_input() -> float:
	var dir_input := Input.get_axis("move_left", "move_right")
	if dir_input > 0.0:
		return 1.0
	if dir_input < 0.0:
		return -1.0
	return physics.move_direction

func _physics_process(delta : float) -> void:
	if not health.is_alive:
		return

	if physics.is_on_floor():
		_time_since_on_floor = 0.0
	else:
		_time_since_on_floor += delta

	if Input.is_action_just_pressed("jump"):
		_jump_buffer_left = jump_buffer_time
	else:
		_jump_buffer_left = maxf(_jump_buffer_left - delta, 0.0)

	# Variable jump height: releasing early cuts the rise short.
	if Input.is_action_just_released("jump") and physics.velocity.y < 0.0:
		physics.velocity.y *= jump_release_multiplier

	var new_direction := update_move_dir_from_input()
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

	# Jump on the ground or within the coyote window after leaving it.
	if _jump_buffer_left > 0.0 and _time_since_on_floor <= coyote_time:
		_jump_buffer_left = 0.0
		_time_since_on_floor = coyote_time + 1.0
		state_machine.transition(state_machine.jump)
		return

	if not physics.is_on_floor():
		state_machine.transition(state_machine.air)
		return
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition(state_machine.walk)
		return
	if physics.is_on_floor():
		state_machine.transition(state_machine.idle)
