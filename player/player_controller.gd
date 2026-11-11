extends Node2D
class_name PlayerController

@export var health : HealthComponent
## Downward acceleration for the player. Higher values give a snappier, less floaty jump.
@export var gravity: float = 450.0

func _ready() -> void:
	health.reset()
	var physics := get_node_or_null("PhysicsComponent") as PhysicsComponent
	if physics != null:
		physics.gravity = Vector2(0, gravity)
