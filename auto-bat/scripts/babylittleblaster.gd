extends Node2D

func _process(delta: float) -> void:
	position += transform.x * 1200 * delta
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
