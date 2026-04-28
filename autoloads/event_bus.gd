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

# Enemy Events
signal enemy_died(enemy: Node)
signal enemy_spawned(enemy: Node)

# Weapon Events
signal weapon_fired(weapon: Weapon)
signal weapon_switched(old_weapon: Weapon, new_weapon: Weapon)
signal ammo_changed(current: int, maximum: int)

# Item / Loot Events
signal item_picked_up(item_name: String, picker: Node)
signal item_dropped(item_name: String, position: Vector2)

# Score / Progress Events
signal score_changed(new_score: int)
signal wave_started(wave_number: int)
signal wave_completed(wave_number: int)
