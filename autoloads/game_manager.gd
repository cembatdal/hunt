extends Node

enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }

var current_state: GameState = GameState.MENU
var score: int = 0
var wave_number: int = 0
var enemies_remaining: int = 0

func change_state(new_state: GameState) -> void:
	current_state = new_state
	match new_state:
		GameState.PAUSED:
			get_tree().paused = true
			EventBus.game_paused.emit()
		GameState.PLAYING:
			get_tree().paused = false
			EventBus.game_resumed.emit()
		GameState.GAME_OVER:
			get_tree().paused = true

func add_score(amount: int) -> void:
	score += amount

func start_wave(number: int, enemy_count: int) -> void:
	wave_number = number
	enemies_remaining = enemy_count
	EventBus.wave_started.emit(wave_number)
	change_state(GameState.PLAYING)

func on_enemy_killed() -> void:
	enemies_remaining -= 1
	add_score(100)
	EventBus.score_changed.emit(score)
	if enemies_remaining <= 0:
		_complete_wave()

func _complete_wave() -> void:
	EventBus.wave_completed.emit(wave_number)
	# Kısa bir bekleme sonra yeni dalga
	await get_tree().create_timer(3.0).timeout
	start_wave(wave_number + 1, 5 + wave_number * 2)
