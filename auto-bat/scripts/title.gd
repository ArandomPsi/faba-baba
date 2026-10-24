extends Control

var ogshippos : Vector2
func _ready() -> void:
	ogshippos = $ship.position

func _process(delta: float) -> void:
	shipstuff()

func shipstuff():
	$ship.position = lerp($ship.position,ogshippos + Vector2(randf_range(-1,1),randf_range(-1,1)) * 30,0.05)
