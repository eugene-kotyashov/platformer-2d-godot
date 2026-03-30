extends CharacterController

@export var max_health: float = 100
@export var attack_damage: float = 10
@export var state_machine: StateMachine
@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var left_cast : RayCast2D = $LeftCast
@onready var right_cast : RayCast2D = $RightCast
@onready var attack1_area : Area2D = $Attack1Area
@onready var attack1_target_in_range = $AttackTargetInRange

var target_player: CharacterController
var gravity: Vector2 = Vector2(0, 100)

var health: float

func _ready() -> void:
	health = max_health

func get_attack_damage():
	return attack_damage

func change_dir():
	if move_direction > 0:
		animations.flip_h = false
		attack1_area.position.x = 8
		attack1_target_in_range.target_position.x = 20
	if move_direction < 0:
		animations.flip_h = true
		attack1_area.position.x = -8
		attack1_target_in_range.target_position.x = -20


func _physics_process(_delta: float) -> void:
	if !is_alive:
		return
	if is_on_floor():
		if attack1_target_in_range.is_colliding():
			state_machine.transition("attack1_state")
		if !right_cast.is_colliding() && left_cast.is_colliding():
			move_direction = -1
		if right_cast.is_colliding() && !left_cast.is_colliding():
			move_direction = 1
		chase_target()
		change_dir()
		#state_machine.transition("walk_state")
		state_machine.transition("walk_state")
	else:
		state_machine.transition("air_state")

func chase_target() -> void:
	if !target_player:
		return
	var target_vec = target_player.position - position
	if target_vec.x > 0:
		move_direction = 1
	else:
		move_direction = -1

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print(name, "'s hurtbox area",
	 " entered by ", parent.name,"'s ", area.name )
	if parent is CharacterController:
		var hitter: CharacterController = area.get_parent()
		print(name, " is hit by ", hitter.name )
		var incoming_damage = hitter.get_attack_damage()
		health -= incoming_damage
		print(name, " received damage ",
		incoming_damage, " health left ", health)
		if health > 0:
			state_machine.transition("hurt_state", true)
		else:
			state_machine.transition("death_state", true)


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
