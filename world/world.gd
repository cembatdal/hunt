extends Node2D

@export var starting_map: PackedScene
@export var game_mode_scene: PackedScene  # Inspector'dan atanır

@onready var map_container: Node2D = $MapContainer
@onready var entities_container: Node2D = $EntitiesContainer

var current_game_mode: GameMode

func _ready() -> void:
	_load_map(starting_map)
	_setup_game_mode()
	GameManager.change_state(GameManager.GameState.PLAYING)

func _setup_game_mode() -> void:
	if game_mode_scene == null:
		push_error("World: game_mode_scene atanmamış!")
		return
	current_game_mode = game_mode_scene.instantiate()
	add_child(current_game_mode)
	current_game_mode.setup(self)
	current_game_mode.start_mode()

func _load_map(map_scene: PackedScene) -> void:
	if map_scene == null:
		push_error("World: starting_map atanmamış!")
		return
	for child in map_container.get_children():
		child.queue_free()
	var map = map_scene.instantiate()
	map_container.add_child(map)
