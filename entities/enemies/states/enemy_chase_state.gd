class_name EnemyChaseState
extends State

func physics_update(_delta: float) -> void:
	if entity.target == null:
		state_machine.transition_to("idle")
		return

	var distance = entity.global_position.distance_to(entity.target.global_position)

	if distance <= entity.attack_range:
		state_machine.transition_to("attack")
		return

	if distance > entity.detection_range * 1.5:
		state_machine.transition_to("idle")
		return

	entity.navigation_agent.target_position = entity.target.global_position
	var next_pos = entity.navigation_agent.get_next_path_position()
	var direction = (next_pos - entity.global_position).normalized()
	entity.velocity = direction * entity.data.move_speed
	entity.move_and_slide()
	entity.look_at(entity.target.global_position)
