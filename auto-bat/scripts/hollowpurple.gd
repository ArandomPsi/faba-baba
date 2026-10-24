extends Node2D

var velocity : Vector2
var reversevelocity : Vector2
var times : int = 0

#make this like a buzzsaw hit

func _ready() -> void:
	velocity.x = randf_range(800,1000)
	velocity.y = randf_range(500,-500)
	reversevelocity = -velocity
	var tween = create_tween()
	tween.tween_property(self,"velocity",reversevelocity,1).set_trans(Tween.TRANS_CUBIC)
	

func _process(delta: float) -> void:
	position += velocity * delta
	if position.x < -50:
		times += 1
		position.x = 1250
		if times > 1:
			queue_free()
