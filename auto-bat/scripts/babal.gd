extends Node2D
var rotaspeed : int = 0
func _ready() -> void:
	rotaspeed = randf_range(-3,3)
	
func _process(delta: float) -> void:
	position += transform.x * 800 * delta
	rotation += rotaspeed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	var b = preload("res://scenes/hiteffect.tscn").instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position
	queue_free()
