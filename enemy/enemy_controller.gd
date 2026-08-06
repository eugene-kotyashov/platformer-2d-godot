extends Node2D

@export var attack_damage: float = 10
@export var state_machine: StateMachine
@onready var animations: AnimatedSprite2D = $Physics/AnimatedSprite2D
@onready var left_cast : RayCast2D = $Physics/LeftCast
@onready var right_cast : RayCast2D = $Physics/RightCast
@onready var attack1_area : Area2D = $Physics/Attack1Area
@onready var attack1_target_in_range = $Physics/AttackTargetInRange
@onready var health : HealthComponent = $Health
@onready var attack_area_dir_offset:float = 8
@onready var attack1_target_range_offset:float = 20
@onready var chase_x_dist_threshold: float = 20
@onready var physics : PhysicsComponent = $Physics

var target_player: CharacterController
var gravity: Vector2 = Vector2(0, 100)

func _ready() -> void:
	health.reset()

func get_attack_damage():
	return attack_damage

func change_dir():
	if physics.move_direction > 0:
		animations.flip_h = false
		attack1_area.position.x = attack_area_dir_offset
		attack1_target_in_range.target_position.x = attack1_target_range_offset
	if physics.move_direction < 0:
		animations.flip_h = true
		attack1_area.position.x = -attack_area_dir_offset
		attack1_target_in_range.target_position.x = -attack1_target_range_offset


func _physics_process(_delta: float) -> void:
	if !health.is_alive:
		return
	if physics.is_on_floor():
		if attack1_target_in_range.is_colliding():
			var collider = attack1_target_in_range.get_collider()
			if collider is StaticBody2D:
				physics.move_direction *= -1
			else:
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
	if area.get_parent() is CharacterController:
		target_player = area.get_parent() as CharacterController


func _on_target_detection_area_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	print(name, "'s target detection",
	 " exited by ", parent.name,"'s ", area.name )
	if area.get_parent() == target_player:
		target_player = null
