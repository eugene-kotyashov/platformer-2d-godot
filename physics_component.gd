extends CharacterBody2D
class_name PhysicsComponent

@export var move_direction : float = 1

@export var gravity: Vector2 = Vector2(0, 100) 
@export var health : HealthComponent
@export var state_machine : StateMachine

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print(name, "'s hurtbox area",
	 " entered by ", parent.name,"'s ", area.name )
	var hit_attack = area.get_parent() as AttackComponent
	if hit_attack == null: return
	print(name, " is hit by ", hit_attack.name )
	var incoming_damage = hit_attack.damage
	health.current -= incoming_damage
	print(name, " received damage ",
	incoming_damage, " health ", health.current)
	if health.is_alive:
		state_machine.transition(state_machine.hurt, true)
	else:
		state_machine.transition(state_machine.death, true)
