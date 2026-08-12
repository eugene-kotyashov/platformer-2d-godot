extends Node2D
class_name AIComponent

@export var attack1 : AttackComponent
@export var health: HealthComponent
@export var physics: PhysicsComponent
@onready var right_cast: RayCast2D = $RightCast
@onready var left_cast: RayCast2D = $LeftCast
@export var state_machine: StateMachine
@onready var chase_x_dist_threshold: float = 20

var target_player: PhysicsComponent = null

func change_dir():
	pass


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
	if !target_player:
		return
	var target_vec = target_player.position - physics.position
	if target_vec.x > chase_x_dist_threshold:
		physics.move_direction = 1
	if target_vec.x < -chase_x_dist_threshold:
		physics.move_direction = -1

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print(name, "'s hurtbox area",
	 " entered by ", parent.name,"'s ", area.name )
	if parent is CharacterController:
		var hitter: CharacterController = area.get_parent()
		print(name, " is hit by ", hitter.name )
		var incoming_damage = hitter.get_attack_damage()
		health -= incoming_damage
		if health.is_alive == false:
			emit_signal("death")
		print(name, " received damage ",
		incoming_damage, " health ", health)
		if health.is_alive:
			state_machine.transition(state_machine.hurt, true)
		else:
			state_machine.transition(state_machine.death, true)


func _on_target_detection_area_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print(name, "'s target detection",
	 " entered by ", parent.name,"'s ", area.name )
	if area.get_parent() is PhysicsComponent:
		target_player = area.get_parent() as PhysicsComponent


func _on_target_detection_area_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	print(name, "'s target detection",
	 " exited by ", parent.name,"'s ", area.name )
	if area.get_parent() == target_player:
		target_player = null
