class_name Weapon
extends Node2D

@export var weapon_name: String = "Weapon"
@export var damage: float = 10.0
@export var fire_rate: float = 0.15      # Atışlar arası saniye

var _can_fire: bool = true
var _fire_timer: float = 0.0

func _process(delta: float) -> void:
	if not _can_fire:
		_fire_timer += delta
		if _fire_timer >= fire_rate:
			_can_fire = true
			_fire_timer = 0.0

func try_fire(muzzle_transform: Transform2D) -> void:
	if not _can_fire:
		return
	_can_fire = false
	fire(muzzle_transform)
	
func fire() -> void:
	if not health_component.is_alive():
		return
	if weapon_holder.get_child_count() == 0:
		return
	var weapon = weapon_holder.get_child(0)
	if weapon is Weapon:
		weapon.try_fire(muzzle.global_transform)
