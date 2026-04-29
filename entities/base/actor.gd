class_name Actor
extends Entity

@export var speed: float = 200.0

# Kontrolcünün (Controller) dolduracağı değişkenler
var move_direction: Vector2 = Vector2.ZERO
var aim_position: Vector2 = Vector2.ZERO
var wants_to_shoot: bool = false

@onready var state_machine: StateMachine = $StateMachine
@onready var muzzle: Marker2D = $Muzzle
@onready var weapon_holder: Node2D = $WeaponHolder

func _ready() -> void:
	super._ready()
	_register_weapons()

func fire() -> void:
	if not health_component.is_alive():
		return
	if weapon_holder.get_child_count() == 0:
		return
	var weapon = weapon_holder.get_child(0)
	if weapon is Weapon:
		var is_weapon_fired = weapon.try_fire(muzzle.global_transform)
		if is_weapon_fired and weapon.data and weapon.data.shoot_sound:
			AudioManager.play_sfx(weapon.data.shoot_sound, 0.8, 1.2)

func on_death() -> void:
	state_machine.transition_to("dead")
	# queue_free yok — dead state halleder

func _register_weapons() -> void:
	for weapon in weapon_holder.get_children():
		if weapon is Weapon:
			weapon.owner_actor = self
