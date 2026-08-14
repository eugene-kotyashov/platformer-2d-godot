extends Node2D
class_name PlayerController

@export var health : HealthComponent

func _ready() -> void:
	health.reset()
