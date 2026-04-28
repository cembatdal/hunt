extends Node

var _pools: Dictionary = {}

func _ready() -> void:
	pass

func get_object(scene: PackedScene, initial_count: int = 5) -> Node:
	var key = scene.resource_path
	if not _pools.has(key):
		_pools[key] = []
		_pre_warm(scene, initial_count)

	var pool: Array = _pools[key]
	for obj in pool:
		if not obj.visible:
			obj.visible = true
			return obj

	# Pool dolu, yeni oluştur
	return _create_instance(scene, key)

func return_object(obj: Node) -> void:
	obj.visible = false
	# Gerekirse reset et (position, velocity vs.)
	if obj.has_method("reset"):
		obj.reset()

func _pre_warm(scene: PackedScene, count: int) -> void:
	var key = scene.resource_path
	for i in range(count):
		_create_instance(scene, key)

func _create_instance(scene: PackedScene, key: String) -> Node:
	var obj = scene.instantiate()
	obj.visible = false
	add_child(obj)
	_pools[key].append(obj)
	return obj
