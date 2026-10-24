extends Node2D
var velocity : Vector2

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()

func _ready() -> void:
	rotation_degrees += randi_range(-50,50)

func _process(delta: float) -> void:
	velocity = 500 * transform.x
	position += velocity * delta
	rotation = lerp_angle(rotation,0.0,0.08)
