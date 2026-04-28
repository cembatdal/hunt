class_name HealthComponent
extends Node

signal died
signal health_changed(current: float, maximum: float)

@export var max_health: float = 100.0

var current_health: float

func _ready() -> void:
	current_health = max_health

func take_damage(amount: float, source: Node = null) -> void:
	if current_health <= 0:
		return
	current_health = clampf(current_health - amount, 0.0, max_health)
	EventBus.entity_damaged.emit(owner, amount, source)
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		_die()

func heal(amount: float) -> void:
	current_health = clampf(current_health + amount, 0.0, max_health)
	health_changed.emit(current_health, max_health)

func _die() -> void:
	EventBus.entity_died.emit(owner)
	died.emit()

func get_health_percent() -> float:
	return current_health / max_health

func is_alive() -> bool:
	return current_health > 0
