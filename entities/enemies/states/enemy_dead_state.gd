class_name EnemyDeadState
extends State

func enter() -> void:
	entity.velocity = Vector2.ZERO
	entity.set_process(false)
	entity.set_physics_process(false)
	EventBus.enemy_died.emit(entity)
	# İleride: ölüm animasyonu, loot drop vs.
	await entity.get_tree().create_timer(0.5).timeout
	entity.queue_free()
