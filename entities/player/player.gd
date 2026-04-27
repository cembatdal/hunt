class_name Player
extends Entity

@export var speed: float = 400.0
@export var bullet_scene: PackedScene

@onready var muzzle: Marker2D = $Muzzle
@onready var camera: Camera2D = $Camera2D
@onready var weapon_holder: Node2D = $WeaponHolder

func _ready() -> void:
	super._ready()
	# Player'a özgü sinyal bağlantıları
	EventBus.entity_died.connect(_on_entity_died)

func _physics_process(delta: float) -> void:
	if not health_component.is_alive():
		return
	_handle_movement()
	_handle_aim()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		fire()

func _handle_movement() -> void:
	var direction := Input.get_vector("west", "east", "north", "south")
	velocity = direction * speed
	move_and_slide()

func _handle_aim() -> void:
	look_at(get_global_mouse_position())

func fire() -> void:
	if bullet_scene == null or not health_component.is_alive():
		return
	var bullet := bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_transform = muzzle.global_transform

func _on_entity_died(entity: Node) -> void:
	if entity == self:
		EventBus.player_died.emit()
