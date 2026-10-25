extends Label



func newattempt():
	#position = Vector2(406,54)
	position = Vector2(1152/2 - 600,648/2)
	var tween = create_tween()
	tween.tween_property(self,"position:x",1500,5)
