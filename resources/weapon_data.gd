class_name WeaponData
extends Resource

@export var weapon_name: String = "Weapon"
@export var damage: float = 10.0
@export var fire_rate: float = 0.2
@export var bullet_speed: float = 1500.0
@export var bullet_scene: PackedScene
@export var shoot_sound: AudioStream
@export var muzzle_flash_scene: PackedScene  # İleride
@export var icon: Texture2D                  # UI için
