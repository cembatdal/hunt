class_name EnemyIdleState
extends State

func update(_delta: float) -> void:
	if entity.target == null:
		return
	var distance = entity.global_position.distance_to(entity.target.global_position)
	if distance <= entity.detection_range:
		state_machine.transition_to("chase")
