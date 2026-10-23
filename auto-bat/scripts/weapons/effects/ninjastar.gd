extends Node2D

var time = 0
var speed = 2000.0


func _ready() -> void:
	$spawn.emitting = true
	var tween = create_tween()
	

func _process(delta: float) -> void:
	time += delta
	rotation_degrees += 1000 * delta
	position.y = sin(time * 5.0) * 25.0
	position.x += speed * delta
