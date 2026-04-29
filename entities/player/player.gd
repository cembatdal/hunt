class_name Player
extends Actor

func _ready() -> void:
	super._ready()
	speed = 400.0
	add_to_group("player")
	# entity_damaged yerine doğrudan HealthComponent sinyalini dinle
	health_component.health_changed.connect(_on_health_changed)

func on_death() -> void:
	super.on_death()

func _on_health_changed(current: float, maximum: float) -> void:
	# EventBus üzerinden yayınla — HUD ve başka sistemler buradan dinleyebilir
	EventBus.player_health_changed.emit(current, maximum)

	# Hasar flash efekti
	var sprite = $Sprite2D
	if sprite:
		var tween = create_tween()
		sprite.modulate = Color.RED
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
