extends Node2D

@export var player_scene: PackedScene
@export var starting_map: PackedScene

@onready var map_container: Node2D = $MapContainer
@onready var entities_container: Node2D = $EntitiesContainer

func _ready() -> void:
	_load_map(starting_map)
	GameManager.change_state(GameManager.GameState.PLAYING)

func _load_map(map_scene: PackedScene) -> void:
	if map_scene == null:
		push_error("World: starting_map atanmamış!")
		return

	# Önceki haritayı temizle
	for child in map_container.get_children():
		child.queue_free()

	var map = map_scene.instantiate()
	map_container.add_child(map)

	_spawn_player(map)

func _spawn_player(map: Node) -> void:
	if player_scene == null:
		push_error("World: player_scene atanmamış!")
		return

	# Eski player'ı temizle
	for child in entities_container.get_children():
		child.queue_free()

	var spawn_point = map.get_node_or_null("PlayerSpawnPoint")
	var spawn_position = spawn_point.global_position if spawn_point else Vector2.ZERO

	var player = player_scene.instantiate()
	entities_container.add_child(player)
	player.global_position = spawn_position
