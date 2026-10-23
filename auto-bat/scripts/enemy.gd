extends Sprite2D

var ogpos : Vector2 #just in case

func _ready() -> void:
	ogpos = position


func damage(amount):
	get_parent().enemyhp -= amount
	smallshake()


func smallshake():
	var magnitude : int = 12
	var time : float = 0.02
	var tween = create_tween()
	for i in range(5):
		tween.tween_property(self,"offset",Vector2(randf_range(-1,1),randf_range(-1,1)) * magnitude,time).set_trans(Tween.TRANS_CUBIC).set_delay(0.02)
	tween.tween_property(self,"offset",Vector2(0,0),0.2).set_trans(Tween.TRANS_CUBIC)
