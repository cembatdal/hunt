extends Node

enum GameState { MENU, PLAYING, PAUSED, GAME_OVER }

var current_state: GameState = GameState.MENU
var score: int = 0

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
