extends Camera2D

var camerashake : int = 0

func _process(delta: float) -> void:
	camerashake -= 1
	camerashake = clamp(camerashake,0,20)
	offset = lerp(offset,Vector2(randf_range(-1,1),randf_range(1,1)) * 15, 0.1) + (Vector2(randf_range(-1,1),randf_range(-1,1)) * camerashake * 20)#shaky cam + camera shake
	if get_parent().hp > 0:
		zoom = lerp(zoom,Vector2(1,1),0.05)
