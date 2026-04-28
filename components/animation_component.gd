class_name AnimationComponent
extends Node

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var _current_animation: String = ""

func play(animation_name: String, force: bool = false) -> void:
	if _current_animation == animation_name and not force:
		return
	if not animation_player.has_animation(animation_name):
		push_warning("AnimationComponent: '%s' animasyonu yok" % animation_name)
		return
	_current_animation = animation_name
	animation_player.play(animation_name)

func get_current() -> String:
	return _current_animation
