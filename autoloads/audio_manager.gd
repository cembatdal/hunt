extends Node

# Ses çalmak için basit wrapper. İleride pooling eklenebilir.
func play_sfx(stream: AudioStream, pitch_min: float = 1.0, pitch_max: float = 1.0) -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = stream
	player.pitch_scale = randf_range(pitch_min, pitch_max)
	player.play()
	player.finished.connect(player.queue_free)
