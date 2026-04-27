class_name Player
extends Entity

@export var speed: float = 400.0
@export var shoot_sound: AudioStream

@onready var muzzle: Marker2D = $Muzzle
@onready var camera: Camera2D = $Camera2D
@onready var weapon_holder: Node2D = $WeaponHolder

func _ready() -> void:
	super._ready()

func _physics_process(_delta: float) -> void:
	if not health_component.is_alive():
		return
	_handle_movement()
	_handle_aim()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		fire()

func _handle_movement() -> void:
	var direction := Input.get_vector("west", "east", "north", "south")
	velocity = direction * speed
	move_and_slide()

func _handle_aim() -> void:
	look_at(get_global_mouse_position())

func fire() -> void:
	if not health_component.is_alive():
		return
	if weapon_holder.get_child_count() == 0:
		return
	var weapon = weapon_holder.get_child(0)
	if weapon is Weapon:
		weapon.try_fire(muzzle.global_transform)
		if shoot_sound:
			AudioManager.play_sfx(shoot_sound, 0.8, 1.2)

func on_death() -> void:
	EventBus.player_died.emit()
	super.on_death()
