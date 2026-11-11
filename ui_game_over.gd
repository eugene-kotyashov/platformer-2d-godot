extends "res://ui_end_screen.gd"
## Defeat screen, shown when the player's health drops to zero.
## All shared behaviour (heading, Restart / Quit, pause) comes from EndScreen.


func _on_player_health_changed(current_health: float, _max_health: float) -> void:
	if current_health > 0.0:
		visible = false
		return
	show_screen()
