class_name Bullet
extends Area2D

@export var speed: float = 1500.0
@export var damage: float = 10.0

@onready var hitbox: HitboxComponent = $HitboxComponent

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered) # Duvarlara (Body) çarpma sinyali

func _process(delta: float) -> void:
	position += transform.x * speed * delta

func _draw() -> void:
	draw_rect(Rect2(Vector2(0, -1), Vector2(6, 2)), Color(1, 0.7, 0.1, 1))

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		_destroy_bullet()

func _on_body_entered(_body: Node2D) -> void:
	# Duvara çarptığında da yok olsun
	_destroy_bullet()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_destroy_bullet()

func _destroy_bullet() -> void:
	# DİKKAT: call_deferred kullanarak fizik motorunun mevcut frame'deki 
	# diğer hesaplamaları (düşmana hasar verme vb.) bitirmesini bekliyoruz.
	ObjectPool.call_deferred("return_object", self)

func reset() -> void:
	damage = 10.0
	speed = 1500.0
	if hitbox:
		hitbox.damage = damage
		hitbox.owner_entity = null

func set_damage(value: float, shooter: Node = null) -> void:
	damage = value
	if hitbox:
		hitbox.damage = value
		hitbox.owner_entity = shooter
		
func setup_collision(is_enemy: bool) -> void:
	
	# Collision Layer Haritası (project.godot ile senkron):
	# Layer 1  (bit mask 1)  : world
	# Layer 2  (bit mask 2)  : player
	# Layer 3  (bit mask 4)  : enemies
	# Layer 4  (bit mask 8)  : player_bullets
	# Layer 5  (bit mask 16) : enemy_bullets
	
	var target_layer = 16 if is_enemy else 8
	var target_mask = 3 if is_enemy else 5
	
	# Hem merminin kendisini hem de içindeki Hitbox'ı güncelliyoruz
	collision_layer = target_layer
	collision_mask = target_mask
	
	if hitbox:
		hitbox.collision_layer = target_layer
		hitbox.collision_mask = target_mask
