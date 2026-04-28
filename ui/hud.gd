extends CanvasLayer

@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer/HealthBar

func _ready() -> void:
	EventBus.entity_damaged.connect(_on_entity_damaged)
	EventBus.player_died.connect(_on_player_died)
	health_bar.value = 100.0

func _on_entity_damaged(entity: Node, _amount: float, _source: Node) -> void:
	if not entity is Player:
		return
	var health: HealthComponent = entity.get_node_or_null("HealthComponent")
	if health:
		health_bar.value = health.get_health_percent() * 100.0

func _on_player_died() -> void:
	health_bar.value = 0.0
	# Game over ekranı göster
