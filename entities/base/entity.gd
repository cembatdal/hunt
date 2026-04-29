class_name Entity
extends CharacterBody2D

@export var entity_name: String = "Entity"

@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	health_component.died.connect(on_death)

func on_death() -> void:
	pass
