extends CanvasLayer


@export var button: Button
@export var player: CharacterController

func _on_player_health_changed():
	visible = player.health <= 0


func _on_restart_button_pressed() -> void:
	get_tree().paused = false  # Unpause first
	get_tree().reload_current_scene()  # Restarts main scene
