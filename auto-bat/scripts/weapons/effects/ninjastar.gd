extends Node2D

var time = 0
var speed = 1500.0
@onready var hitbox: Area2D = $hitbox


func _process(delta: float) -> void:
	time += delta
	rotation_degrees += 1440 * delta
	position.y = sin(time * 5.0) * 25.0
	position.x += speed * delta
