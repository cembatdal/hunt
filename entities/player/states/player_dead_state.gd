class_name PlayerDeadState
extends State

func enter() -> void:
	EventBus.player_died.emit()
	entity.velocity = Vector2.ZERO
	# Animasyon tetiklenebilir
	# entity.get_node("AnimationPlayer").play("death")
