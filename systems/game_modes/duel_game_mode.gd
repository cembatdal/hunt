class_name DuelGameMode
extends GameMode

@export var player_scene: PackedScene
@export var enemy_scene: PackedScene

var player_instance: Node
var enemy_instance: Node

func start_mode() -> void:
	print("Duel Mode Başladı! 1v1...")
	_spawn_fighters()

func _spawn_fighters() -> void:
	var map = world_ref.map_container.get_child(0)
	if not map:
		push_error("Harita bulunamadı!")
		return
		
	# Haritadan Marker2D noktalarını alıyoruz
	var p_spawn = map.get_node_or_null("PlayerSpawn")
	var e_spawn = map.get_node_or_null("EnemySpawn")
	
	if not p_spawn or not e_spawn:
		push_error("Spawn noktaları haritada eksik!")
		return

	# Oyuncuyu Spawnla
	player_instance = player_scene.instantiate()
	player_instance.global_position = p_spawn.global_position
	world_ref.entities_container.add_child(player_instance)
	
	# Düşmanı Spawnla
	enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = e_spawn.global_position
	world_ref.entities_container.add_child(enemy_instance)
	
	enemy_instance.target = player_instance

func _on_entity_died(entity: Node) -> void:
	if entity == player_instance:
		print("Düşman Kazandı!")
		match_finished.emit("Enemy")
		GameManager.change_state(GameManager.GameState.GAME_OVER)
	elif entity == enemy_instance:
		print("Oyuncu Kazandı!")
		match_finished.emit("Player")
		GameManager.change_state(GameManager.GameState.GAME_OVER)
