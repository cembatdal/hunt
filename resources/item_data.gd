class_name ItemData
extends Resource

enum ItemType { HEALTH_PACK, AMMO, WEAPON, KEY }

@export var item_name: String = "Item"
@export var item_type: ItemType = ItemType.HEALTH_PACK
@export var value: float = 25.0           # Can paketi için iyileşme miktarı
@export var weapon_data: WeaponData       # Silah item'ı ise
@export var icon: Texture2D
@export var pickup_sound: AudioStream
