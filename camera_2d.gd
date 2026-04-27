extends Camera2D

var max_offset = 150.0 
var smooth_speed = 5.0 

func _process(delta: float) -> void:
	var global_mouse = get_global_mouse_position()
	var player_pos = get_parent().global_position
	
	var difference = global_mouse - player_pos
	
	var target_offset = difference * 0.3 
	target_offset = target_offset.limit_length(max_offset)
	
	offset = offset.lerp(target_offset, smooth_speed * delta)
