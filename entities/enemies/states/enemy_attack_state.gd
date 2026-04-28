class_name EnemyAttackState
extends State

var attack_timer: float = 0.0
@export var attack_cooldown: float = 1.0

func enter() -> void:
	attack_timer = attack_cooldown  # İlk girişte hemen ateş et

func update(delta: float) -> void:
	if entity.target == null:
		state_machine.transition_to("idle")
		return

	var distance = entity.global_position.distance_to(entity.target.global_position)
	if distance > entity.attack_range:
		state_machine.transition_to("chase")
		return

	attack_timer += delta
	if attack_timer >= attack_cooldown:
		attack_timer = 0.0
		_perform_attack()

func _perform_attack() -> void:
	# Alt sınıflar override eder (yakın dövüş, silah, vs.)
	pass
