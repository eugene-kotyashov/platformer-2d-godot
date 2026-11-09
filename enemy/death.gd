extends State

## When true the enemy is removed from the scene once its death animation ends.
@export var remove_after_death: bool = true

func _ready() -> void:
	name = "death_state"

func on_enter() -> void:
	super.on_enter()
	_disable_combat()
	if remove_after_death:
		_free_when_finished()

func _disable_combat() -> void:
	var physics := get_parent().get_parent().get_node_or_null("PhysicsComponent")
	if physics == null:
		return
	var hurtbox := physics.get_node_or_null("Hurtbox")
	if hurtbox is CollisionObject2D:
		hurtbox.set_deferred("monitoring", false)
		hurtbox.set_deferred("monitorable", false)
	var attack_area := physics.get_node_or_null("Attack1/AttackArea")
	if attack_area is CollisionObject2D:
		attack_area.set_deferred("monitoring", false)
		attack_area.set_deferred("monitorable", false)

func _free_when_finished() -> void:
	if animations == null or animations.player == null or not animations.player.is_playing():
		_remove_self()
		return
	await animations.player.animation_finished
	_remove_self()

func _remove_self() -> void:
	var enemy := get_parent().get_parent()
	if is_instance_valid(enemy):
		enemy.queue_free()
