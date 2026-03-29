extends CharacterController

@export var max_health: float = 100
@export var attack_damage: float = 10
@export var state_machine: StateMachine
@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var left_cast : RayCast2D = $LeftCast
@onready var right_cast : RayCast2D = $RightCast


var target_player: CharacterController
var gravity: Vector2 = Vector2(0, 100)

var health: float

func _ready() -> void:
	health = max_health

func get_attack_damage():
	return attack_damage


func _physics_process(_delta: float) -> void:
	if !is_alive:
		return
	if is_on_floor():
		if !right_cast.is_colliding() && left_cast.is_colliding():
			move_direction = -1
		if right_cast.is_colliding() && !left_cast.is_colliding():
			move_direction = 1
		state_machine.transition("walk_state")
	else:
		state_machine.transition("air_state")


func _on_hurt_box_area_entered(area: Area2D) -> void:
	print(area.name + " entered")
	if area.get_parent() is CharacterController:
		print("enemy is hit")
		var hitter: CharacterController = area.get_parent()
		var incoming_damage = hitter.get_attack_damage()
		print(name, "received damage",incoming_damage)
		health -= incoming_damage
		if health > 0:
			state_machine.transition("hurt_state")
		else:
			state_machine.transition("death_state")
