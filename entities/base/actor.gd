class_name Actor
extends Entity

@export var data: EntityData

# Kontrolcünün (Controller) dolduracağı değişkenler
var move_direction: Vector2 = Vector2.ZERO
var aim_position: Vector2 = Vector2.ZERO
var wants_to_shoot: bool = false

var speed: float = 200.0

@onready var state_machine: StateMachine = $StateMachine
@onready var muzzle: Marker2D = $Muzzle
@onready var weapon_holder: Node2D = $WeaponHolder

func _ready() -> void:
	super._ready()
	# Eğer EntityData varsa hızını oradan al (Düşmanlar için)
	if "data" in self and self.data:
		speed = self.data.move_speed
	# Oyuncu için manuel speed atanmışsa o kalır

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
