class_name ActorDeadState
extends State

func enter() -> void:
	entity.velocity = Vector2.ZERO
	entity.set_process(false)
	entity.set_physics_process(false)
