class_name Weapon
extends Node2D

@export var data: WeaponData

var owner_actor: Actor = null

var _can_fire: bool = true
var _fire_timer: float = 0.0

func _process(delta: float) -> void:
	if not _can_fire:
		_fire_timer += delta
		if _fire_timer >= data.fire_rate:
			_can_fire = true
			_fire_timer = 0.0

func try_fire(muzzle_transform: Transform2D) -> bool:
	if not _can_fire or data == null:
		return false
	_can_fire = false
	fire(muzzle_transform)
	return true

func fire(muzzle_transform: Transform2D) -> void:
	if data.bullet_scene == null:
		return

	var bullet = ObjectPool.get_object(data.bullet_scene)
	bullet.global_transform = muzzle_transform
	bullet.speed = data.bullet_speed

	var shooter: Node = owner_actor

	if bullet.has_method("set_damage"):
		bullet.set_damage(data.damage, shooter)
	else:
		bullet.damage = data.damage
		
	if bullet.has_method("setup_collision"):
		bullet.setup_collision(shooter.is_in_group("enemy"))
