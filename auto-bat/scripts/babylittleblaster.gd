extends Node2D

func _process(delta: float) -> void:
	position += transform.x * 1200 * delta
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	var b = preload("res://scenes/hiteffect.tscn").instantiate()
	get_tree().current_scene.add_child(b)
	if "hp" in body:
		body.hp -= 1
	b.position = position
	b.scale *= 0.4
	b.modulate = Color("70d4ff")
	queue_free()
