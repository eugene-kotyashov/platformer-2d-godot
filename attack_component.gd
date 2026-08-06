extends Node2D
class_name AttackComponent

@export var damage: float = 100
@onready var state : State = $Attack1
@onready var player: AnimationPlayer = $AnimationPlayer
@onready var area: Area2D = $AttackArea

func play_active():
	player.play("attack_active")
	
func play_reset():
	player.play("RESET")
	
func change_attack_dir(new_direction):
	if new_direction > 0:
		area.position.x = 3
	else:
		area.position.x = -3
