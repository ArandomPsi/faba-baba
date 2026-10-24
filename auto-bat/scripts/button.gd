extends Button
var basesizex : float
var baseposx : float
func _ready() -> void:
	basesizex = size.x
	baseposx = position.x
	pivot_offset.x = size.x/2

func _process(delta: float) -> void:
	if is_hovered():
		size.x = lerpf(size.x,basesizex * 1.26,0.15)
	else:
		size.x = lerpf(size.x,basesizex,0.15)
	position.x = baseposx - (size.x - basesizex)/2
