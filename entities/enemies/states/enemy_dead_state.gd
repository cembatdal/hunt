class_name EnemyDeadState
extends ActorDeadState

func enter() -> void:
	super.enter()
	EventBus.enemy_died.emit(entity)
	await entity.get_tree().create_timer(0.5).timeout
	entity.queue_free()
