class_name Enemy
extends Entity

@export var data: EntityData
@export var detection_range: float = 2000.0 
@export var attack_range: float = 150.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var state_machine: StateMachine = $StateMachine

var target: Node = null

func _ready() -> void:
	super._ready()
	add_to_group("enemy")

	if data:
		health_component.max_health = data.max_health
		health_component.current_health = data.max_health
		entity_name = data.entity_name
		
	# Hasar yediğini anlamak için HealthComponent'in sinyaline bağlanıyoruz
	health_component.health_changed.connect(_on_health_changed)

# VURULMA EFEKTİ FONKSİYONU
func _on_health_changed(_current: float, _max: float) -> void:
	var sprite = $Sprite2D
	if sprite:
		# Tween ile sprite'ı anlık kırmızı yapıp 0.15 saniyede tekrar beyaza (orijinale) çeviriyoruz
		var tween = create_tween()
		sprite.modulate = Color.RED
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)

func on_death() -> void:
	super.on_death()
