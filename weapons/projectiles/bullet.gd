class_name Bullet
extends Area2D

@export var speed: float = 1500.0
@export var damage: float = 10.0

@onready var hitbox: HitboxComponent = $HitboxComponent

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	position += transform.x * speed * delta

func _draw() -> void:
	draw_rect(Rect2(Vector2(0, -1), Vector2(6, 2)), Color(1, 0.7, 0.1, 1))

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		ObjectPool.return_object(self)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	ObjectPool.return_object(self)

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
