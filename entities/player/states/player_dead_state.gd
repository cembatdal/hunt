class_name PlayerDeadState
extends State

func enter() -> void:
	entity.velocity = Vector2.ZERO
	entity.set_process(false)
	entity.set_physics_process(false)
	EventBus.player_died.emit()
	# Player queue_free olmaz — Game Over ekranı açılacak (ileride)
