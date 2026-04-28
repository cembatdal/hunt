class_name GameMode
extends Node

signal match_finished(winner_name: String)

var world_ref: Node2D # World sahnesine erişim sağlamak için

# Oyun modu başlatıldığında çağrılır
func setup(world: Node2D) -> void:
	world_ref = world
	EventBus.entity_died.connect(_on_entity_died)

func start_mode() -> void:
	# Alt sınıflar (DuelMode vs.) burayı ezecek (override)
	pass

func _on_entity_died(entity: Node) -> void:
	# Alt sınıflar burayı ezecek
	pass
