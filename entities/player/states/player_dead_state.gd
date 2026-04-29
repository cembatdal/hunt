class_name PlayerDeadState
extends ActorDeadState

func enter() -> void:
	super.enter()
	EventBus.player_died.emit()
