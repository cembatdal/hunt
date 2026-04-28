class_name Enemy
extends Entity

@export var data: EntityData
@export var detection_range: float = 300.0
@export var attack_range: float = 150.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var state_machine: StateMachine = $StateMachine

var target: Node = null

func _ready() -> void:
	super._ready()
	add_to_group("enemy")
	await get_tree().process_frame
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		target = players[0]

func on_death() -> void:
	GameManager.on_enemy_killed()
	super.on_death()
