class_name Enemy
extends Actor

@export var data: EntityData
@export var speed: float = 200.0

func _ready() -> void:
	super._ready()
	add_to_group("enemy")

	if data:
		health_component.max_health = data.max_health
		health_component.current_health = data.max_health
		entity_name = data.entity_name
		speed = data.move_speed

	health_component.health_changed.connect(_on_health_changed)

func on_death() -> void:
	super.on_death()  # state_machine.transition_to("dead") çağırır

func _on_health_changed(_current: float, _max: float) -> void:
	var sprite = $Sprite2D
	if sprite:
		var tween = create_tween()
		sprite.modulate = Color.RED
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
