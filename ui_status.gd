extends CanvasLayer

@export var health_bar: ProgressBar
@onready var kill_count_text = $MarginContainer/VBoxContainer/HBoxContainer/KillCounText
var enemy_kill_count = 0

func _ready() -> void:
	enemy_kill_count = 0
	health_bar.value = 100
	
func _on_player_health_changed(current_health: float, max_health: float):
	visible = current_health > 0
	health_bar.value = 100*current_health/max_health

func _on_enemy_death() -> void:
	enemy_kill_count += 1
	kill_count_text.text = str(enemy_kill_count) # Replace with function body.
