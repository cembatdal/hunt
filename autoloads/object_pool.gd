extends Node
 
var _pools: Dictionary = {}
 
func get_object(scene: PackedScene, initial_count: int = 5) -> Node:
	var key = scene.resource_path
	if not _pools.has(key):
		_pools[key] = []
		_pre_warm(scene, initial_count)
 
	var pool: Array = _pools[key]
	for obj in pool:
		if obj.process_mode == Node.PROCESS_MODE_DISABLED:
			_activate(obj)
			return obj
 
	# Pool dolu, yeni oluştur
	var obj = _create_instance(scene, key)
	_activate(obj)
	return obj
 
func return_object(obj: Node) -> void:
	obj.process_mode = Node.PROCESS_MODE_DISABLED
	obj.visible = false
	if obj.has_method("reset"):
		obj.reset()
 
func _activate(obj: Node) -> void:
	obj.process_mode = Node.PROCESS_MODE_INHERIT
	obj.visible = true
 
func _pre_warm(scene: PackedScene, count: int) -> void:
	var key = scene.resource_path
	for i in range(count):
		_create_instance(scene, key)
 
func _create_instance(scene: PackedScene, key: String) -> Node:
	var obj = scene.instantiate()
	# Başlangıçta devre dışı — visible false tek başına yetmez
	obj.process_mode = Node.PROCESS_MODE_DISABLED
	obj.visible = false
	add_child(obj)
	_pools[key].append(obj)
	return obj
