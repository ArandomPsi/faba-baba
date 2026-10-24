extends Node2D
var velocity : Vector2

func _ready() -> void:
	velocity.x = randf_range(200,1500)
	velocity.y = randf_range(500,800) * -1

func _process(delta: float) -> void:
	velocity.y += 900 * delta
	position += velocity * delta
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	var b = preload("res://scenes/hiteffect.tscn").instantiate()
	get_tree().current_scene.add_child(b)
	b.position = position
	queue_free()
