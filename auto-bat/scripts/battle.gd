extends Node2D
var playerhp : int = 100
var enemyhp : int = 100


func _process(delta: float) -> void:
	$playerhp.value = playerhp
	$enemyhp.value = enemyhp
