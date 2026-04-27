extends Node

# Entity Events
signal entity_died(entity: Node)
signal entity_damaged(entity: Node, amount: float, source: Node)

# Player Events
signal player_died()
signal player_health_changed(current: float, maximum: float)

# Game Events
signal game_paused()
signal game_resumed()
signal scene_change_requested(scene_path: String)
