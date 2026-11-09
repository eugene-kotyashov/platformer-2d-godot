extends Node2D
class_name AIComponent

@export var attack1 : AttackComponent
@export var health: HealthComponent
@export var physics: PhysicsComponent
@export var visuals : VisualsComponent
@onready var right_cast: RayCast2D = $DownRightCast
@onready var left_cast: RayCast2D = $DownLeftCast
@export var state_machine: StateMachine
@export var chase_x_dist_threshold: float

var target_player: PhysicsComponent = null

func change_dir():
	attack1.change_attack_dir(physics.move_direction)
	visuals.change_move_dir(physics.move_direction)


func _physics_process(_delta: float) -> void:
	if !health.is_alive:
		return
	if physics.is_on_floor():
		if attack1.attack_target_in_range.is_colliding():
			state_machine.transition(state_machine.attack1)
		if !right_cast.is_colliding() && left_cast.is_colliding():
			physics.move_direction = -1
		if right_cast.is_colliding() && !left_cast.is_colliding():
			physics.move_direction = 1
		chase_target()
		change_dir()
		#state_machine.transition("walk_state")
		state_machine.transition(state_machine.walk)
	else:
		state_machine.transition(state_machine.air)

func chase_target() -> void:
	if target_player == null:
		return
	var target_vec = target_player.global_position - physics.global_position
	# print("enemy ", physics.move_direction, " target x ", target_vec.x)
	if abs(target_vec.x) > chase_x_dist_threshold:
		if target_vec.x*physics.move_direction < 0:
			if target_vec.x > 0:
				physics.move_direction = 1
			else:
				physics.move_direction = -1


func _on_target_detection_area_area_entered(area: Area2D) -> void:
	if area.get_parent() is PhysicsComponent:
		target_player = area.get_parent() as PhysicsComponent


func _on_target_detection_area_area_exited(area: Area2D) -> void:
	if area.get_parent() == target_player:
		target_player = null
