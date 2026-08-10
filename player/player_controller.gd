extends Node2D
class_name CharacterController

@export var state_machine : StateMachine
@onready var animations : AnimatedSprite2D = $PhysicsComponent/AnimatedSprite2D
@onready var hurtbox : Area2D = $PhysicsComponent/Hurtbox
@onready var health : HealthComponent = $Health
@onready var physics : PhysicsComponent = $PhysicsComponent
@onready var attack1 : AttackComponent = $PhysicsComponent/Attack1
@onready var user_input : InputComponent
	
func _ready() -> void:
	scale.x = 1
	physics.velocity = Vector2.ZERO
	health.reset()

	# print(name + " vx ", velocity.x)
