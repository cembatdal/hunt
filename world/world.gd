extends Node2D

@export var starting_map: PackedScene

@onready var map_container: Node2D = $MapContainer
@onready var entities_container: Node2D = $EntitiesContainer
@onready var current_game_mode: GameMode = $DuelGameMode # Mode düğümünü alıyoruz

func _ready() -> void:
	_load_map(starting_map)
	
	# Oyun modunu kur ve başlat
	if current_game_mode:
		current_game_mode.setup(self)
		current_game_mode.start_mode()
	
	GameManager.change_state(GameManager.GameState.PLAYING)

func _load_map(map_scene: PackedScene) -> void:
	if map_scene == null:
		push_error("World: starting_map atanmamış!")
		return

	for child in map_container.get_children():
		child.queue_free()

	var map = map_scene.instantiate()
	map_container.add_child(map)
