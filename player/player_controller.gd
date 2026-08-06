extends Node2D

@export var state_machine : StateMachine
@onready var animations : AnimatedSprite2D = $PhysicsComponent/AnimatedSprite2D
@onready var hurtbox : Area2D = $PhysicsComponent/Hurtbox
@onready var health : HealthComponent = $Health
@onready var physics : PhysicsComponent = $PhysicsComponent
@onready var attack1 : AttackComponent = $PhysicsComponent/Attack1


func get_attack_damage():
	return attack1.damage
	
func _ready() -> void:
	scale.x = 1
	physics.velocity = Vector2.ZERO
	health.reset()

func update_move_dir_from_input():
	var dir_input = Input.get_axis("ui_left", "ui_right")
	# print("dir_input ", dir_input)
	if dir_input > 0:
		return 1
	if dir_input < 0:
		return -1
	return physics.move_direction

func change_move_dir():
	if physics.move_direction > 0:
		animations.flip_h = false
	if physics.move_direction < 0:
		animations.flip_h = true
	
func process_input():
	if !health.is_alive:
		return
	var new_direction=update_move_dir_from_input()
	
	if physics.move_direction != new_direction:
		physics.move_direction = new_direction
		change_move_dir()
		attack1.change_attack_dir(new_direction)
	
	if Input.is_action_pressed("attack"):
		if physics.is_on_floor():
			state_machine.transition(state_machine.attack1)
			return
	if !physics.is_on_floor():
		state_machine.transition(state_machine.air)
		return
	if Input.is_action_just_pressed("ui_accept"):
		# print("ui_accept")
		if physics.is_on_floor():
			state_machine.transition(state_machine.jump)
			return
	if Input.is_action_pressed("ui_left"):
		state_machine.transition(state_machine.walk)
		return
	if Input.is_action_pressed("ui_right"):
		state_machine.transition(state_machine.walk)
		return
	if physics.is_on_floor():
		state_machine.transition(state_machine.idle)

func _physics_process(_delta: float) -> void:
	process_input()
	# print(name + " vx ", velocity.x)

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	print(name, "'s hurtbox area",
	 " entered by ", parent.name,"'s ", area.name )
	if parent is CharacterController:
		var hitter: CharacterController = area.get_parent()
		print(name, " is hit by ", hitter.name )
		var incoming_damage = hitter.get_attack_damage()
		health -= incoming_damage
		print(name, " received damage ",
		incoming_damage, " health ", health)
		if health.is_alive:
			state_machine.transition(state_machine.hurt, true)
		else:
			state_machine.transition(state_machine.death, true)
