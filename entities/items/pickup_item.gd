class_name PickupItem
extends Area2D

@export var item_data: ItemData

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if not area.owner is Player:
		return
	_apply_to(area.owner)
	EventBus.item_picked_up.emit(item_data.item_name, area.owner)
	if item_data.pickup_sound:
		AudioManager.play_sfx(item_data.pickup_sound)
	queue_free()

func _apply_to(player: Player) -> void:
	match item_data.item_type:
		ItemData.ItemType.HEALTH_PACK:
			var health: HealthComponent = player.get_node_or_null("HealthComponent")
			if health:
				health.heal(item_data.value)
		ItemData.ItemType.WEAPON:
			pass  # Silah değiştirme mantığı buraya
