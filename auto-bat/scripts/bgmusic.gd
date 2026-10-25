extends AudioStreamPlayer

func _process(delta: float) -> void:
	pitch_scale = lerp(pitch_scale,Engine.time_scale,0.05)
