class_name Player
extends Entity

@export var speed: float = 400.0

@onready var muzzle: Marker2D = $Muzzle
@onready var weapon_holder: Node2D = $WeaponHolder
@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	super._ready()
	add_to_group("player")
	health_component.health_changed.connect(_on_health_changed)

func fire() -> void:
	if not health_component.is_alive():
		return
	if weapon_holder.get_child_count() == 0:
		return
	var weapon = weapon_holder.get_child(0)
	if weapon is Weapon:
		weapon.try_fire(muzzle.global_transform)
		if weapon.data and weapon.data.shoot_sound:
			AudioManager.play_sfx(weapon.data.shoot_sound, 0.8, 1.2)

func on_death() -> void:
	state_machine.transition_to("dead")
	super.on_death()

func _on_health_changed(_current: float, _max: float) -> void:
	var sprite = $Sprite2D
	if sprite:
		var tween = create_tween()
		sprite.modulate = Color.RED
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
