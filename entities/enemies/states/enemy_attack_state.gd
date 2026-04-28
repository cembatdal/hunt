class_name EnemyAttackState
extends State

var attack_timer: float = 0.0
@export var attack_cooldown: float = 1.0
@export var damage: float = 10.0 # Düşman hasarı

func enter() -> void:
	attack_timer = attack_cooldown  # İlk girişte hemen vurması için

func update(delta: float) -> void:
	# Hedef yoksa veya öldüyse Idle'a dön
	if not is_instance_valid(entity.target):
		state_machine.transition_to("idle")
		return

	var distance = entity.global_position.distance_to(entity.target.global_position)
	
	# Hedef uzaklaştıysa tekrar kovalamaya başla
	if distance > entity.attack_range:
		state_machine.transition_to("chase")
		return

	attack_timer += delta
	if attack_timer >= attack_cooldown:
		attack_timer = 0.0
		_perform_attack()

func _perform_attack() -> void:
	print("Düşman saldırdı!") # Konsolda çalıştığını görmek için
	
	# Hedefin can bileşenini bul ve hasar ver
	var target_health = entity.target.get_node_or_null("HealthComponent")
	if target_health:
		target_health.take_damage(damage, entity)
