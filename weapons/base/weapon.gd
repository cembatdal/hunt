class_name Weapon
extends Node2D

@export var weapon_name: String = "Weapon"
@export var damage: float = 10.0
@export var fire_rate: float = 0.2      # Atışlar arası saniye
@export var bullet_scene: PackedScene

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

func fire(muzzle_transform: Transform2D) -> void:
	# Alt sınıflar override edebilir
	if bullet_scene == null:
		return
	var bullet := bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_transform = muzzle_transform
	bullet.damage = damage
