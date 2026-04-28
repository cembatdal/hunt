class_name AIController
extends Node

@export var attack_range: float = 150.0

@onready var actor: Actor = get_parent()
@onready var nav_agent: NavigationAgent2D = $"../NavigationAgent2D"

var target: Node2D = null

func _physics_process(_delta: float) -> void:
	if not actor.health_component.is_alive() or target == null or not is_instance_valid(target):
		actor.move_direction = Vector2.ZERO
		actor.wants_to_shoot = false
		return

	# Hedefin pozisyonunu Actor'ün nişangahına veriyoruz
	actor.aim_position = target.global_position
	var distance = actor.global_position.distance_to(target.global_position)

	# Eğer uzaktaysa yürü, yakındaysa dur ve ateş et
	if distance > attack_range:
		nav_agent.target_position = target.global_position
		var next_pos = nav_agent.get_next_path_position()
		actor.move_direction = (next_pos - actor.global_position).normalized()
		actor.wants_to_shoot = false
	else:
		actor.move_direction = Vector2.ZERO
		actor.wants_to_shoot = true
