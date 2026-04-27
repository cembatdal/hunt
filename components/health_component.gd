class_name HealthComponent
extends Node

@export var max_health: float = 100.0

var current_health: float

func _ready() -> void:
	current_health = max_health

func take_damage(amount: float, source: Node = null) -> void:
	if current_health <= 0:
		return
	current_health = clampf(current_health - amount, 0.0, max_health)
	EventBus.entity_damaged.emit(owner, amount, source)
	if current_health <= 0:
		die()

func heal(amount: float) -> void:
	current_health = clampf(current_health + amount, 0.0, max_health)

func die() -> void:
	EventBus.entity_died.emit(owner)

func get_health_percent() -> float:
	return current_health / max_health

func is_alive() -> bool:
	return current_health > 0
