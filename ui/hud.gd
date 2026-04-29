extends CanvasLayer

@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer/HealthBar

func _ready() -> void:
	EventBus.player_health_changed.connect(_on_player_health_changed)
	EventBus.player_died.connect(_on_player_died)
	health_bar.value = 100.0

func _on_player_health_changed(current: float, maximum: float) -> void:
	health_bar.value = (current / maximum) * 100.0

func _on_player_died() -> void:
	health_bar.value = 0.0
	# Game over ekranı göster
