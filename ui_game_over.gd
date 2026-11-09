extends CanvasLayer


@export var button: Button
## Seconds to let the death animation finish before freezing the game.
@export var pause_delay: float = 1.0

var _game_over: bool = false

func _ready() -> void:
	# Keep working while the world is paused so Restart stays clickable.
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_player_health_changed(current_health: float, _max_health: float) -> void:
	if current_health > 0.0:
		visible = false
		return
	if _game_over:
		return
	_game_over = true
	visible = true
	await get_tree().create_timer(pause_delay).timeout
	get_tree().paused = true


func _on_restart_button_pressed() -> void:
	get_tree().paused = false  # Unpause first
	get_tree().reload_current_scene()  # Restarts main scene
