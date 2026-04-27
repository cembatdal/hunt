extends Area2D

var speed = 1500.0

func _process(delta: float) -> void:
	position += transform.x * speed * delta
	
func _draw() -> void:
	draw_rect(Rect2(Vector2(0, -1), Vector2(6, 2)), Color(1, 0.7, 0.1, 1))

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
