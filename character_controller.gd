extends CharacterBody2D
class_name CharacterController

@export var move_direction : float = 1
var is_alive: bool = true
@export var max_health : float = 100
var health: float

signal health_changed

func get_attack_damage():
	pass
