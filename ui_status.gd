extends CanvasLayer

@export var health_bar: ProgressBar
@export var player: CharacterController
@onready var kill_count_text = $MarginContainer/VBoxContainer/HBoxContainer/KillCounText
var enemy_kill_count = 0

func _ready() -> void:
	enemy_kill_count = 0
	
func _on_player_health_changed():
	visible = player.health > 0
	health_bar.value = 100*player.health/player.max_health

func _on_enemy_death() -> void:
	enemy_kill_count += 1
	kill_count_text.text = str(enemy_kill_count)
