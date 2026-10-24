extends Camera2D

func _process(delta: float) -> void:
	offset = lerp(offset,Vector2(randf_range(-1,1),randf_range(1,1)) * 15, 0.1)
