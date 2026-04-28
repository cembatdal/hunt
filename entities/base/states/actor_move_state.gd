class_name ActorMoveState
extends State

func physics_update(_delta: float) -> void:
	# Karakteri hareket ettir
	entity.velocity = entity.move_direction * entity.speed
	entity.move_and_slide()
	
	# Hedefe bak
	if entity.aim_position != Vector2.ZERO:
		entity.look_at(entity.aim_position)

	# Tetiğe basılıysa ateş et (Top-down shooter'larda yürürken ateş edilebilir)
	if entity.wants_to_shoot:
		entity.fire()
