extends Node2D


func _process(delta: float) -> void:
	position += 400 * delta * transform.x


func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
