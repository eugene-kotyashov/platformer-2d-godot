extends Node2D
class_name AttackComponent

@export var damage: float
@export var state : State
@export var player: AnimationComponent 
@onready var area: Area2D = $AttackArea
@export var attack_target_in_range : RayCast2D
@export var attack_area_dir_offset:float = 8
@export var attack_target_range_offset:float = 20

	
func change_attack_dir(new_direction):
	if new_direction > 0:
		area.position.x = attack_area_dir_offset
		if attack_target_in_range == null: return
		attack_target_in_range.target_position.x = attack_target_range_offset
	else:
		area.position.x = -attack_area_dir_offset
		if attack_target_in_range == null: return
		attack_target_in_range.target_position.x = -attack_target_range_offset
