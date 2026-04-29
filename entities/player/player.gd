class_name Player
extends Actor

@export var speed: float = 400.0

func _ready() -> void:
	super._ready()
	add_to_group("player")
	health_component.health_changed.connect(_on_health_changed)

func on_death() -> void:
	super.on_death()  # state_machine.transition_to("dead") çağırır

func _on_health_changed(_current: float, _max: float) -> void:
	var sprite = $Sprite2D
	if sprite:
		var tween = create_tween()
		sprite.modulate = Color.RED
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
