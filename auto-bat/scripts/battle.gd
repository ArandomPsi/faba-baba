extends Node2D
var playerhp : int = 100
var enemyhp : int = 100

@export var player : Node2D


func _process(delta: float) -> void:
	$playerhp.value = playerhp
	$enemyhp.value = enemyhp
