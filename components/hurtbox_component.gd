class_name HurtboxComponent
extends Area2D

@export var health_component: NodePath

@onready var _health: HealthComponent = get_node(health_component) if health_component else null

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if _health:
			_health.take_damage(area.damage, area.owner)
