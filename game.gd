extends Node2D

const EndScreenScript := preload("res://ui_end_screen.gd")

@onready var win_screen: EndScreenScript = $WinScreen


func _on_level_exit_area_entered(_area: Area2D) -> void:
	win_screen.show_screen()
