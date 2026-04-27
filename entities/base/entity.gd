class_name Entity
extends CharacterBody2D

@export var entity_name: String = "Entity"

@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	EventBus.entity_died.connect(_on_any_entity_died)

func _on_any_entity_died(entity: Node) -> void:
	if entity == self:
		on_death()

func on_death() -> void:
	# Alt sınıflar override eder
	queue_free()
