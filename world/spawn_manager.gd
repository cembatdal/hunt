class_name SpawnManager
extends Node

@export var enemy_scenes: Array[PackedScene] = []
@export var spawn_interval: float = 5.0
@export var max_enemies: int = 10
@export var spawn_radius: float = 600.0
@export var entities_container: Node2D  # Inspector'dan bağlanacak

var _spawn_timer: float = 0.0
var _player: Node = null

func _ready() -> void:
	await get_tree().process_frame
	_find_player()

func _find_player() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		_player = players[0]

func _process(delta: float) -> void:
	if enemy_scenes.is_empty():
		return

	# Player ölmüşse referansı yenile veya dur
	if not is_instance_valid(_player):
		_find_player()
		return

	var current_enemies = get_tree().get_nodes_in_group("enemy").size()
	if current_enemies >= max_enemies:
		return

	_spawn_timer += delta
	if _spawn_timer >= spawn_interval:
		_spawn_timer = 0.0
		_spawn_enemy()

func _spawn_enemy() -> void:
	if entities_container == null:
		push_error("SpawnManager: entities_container Inspector'dan bağlanmamış!")
		return

	var angle = randf() * TAU
	var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
	var spawn_pos = _player.global_position + offset

	var scene = enemy_scenes.pick_random()
	var enemy = scene.instantiate()
	entities_container.add_child(enemy)
	enemy.global_position = spawn_pos
	# Grubu buradan eklemeye gerek yok — enemy.gd _ready()'de zaten ekliyor
