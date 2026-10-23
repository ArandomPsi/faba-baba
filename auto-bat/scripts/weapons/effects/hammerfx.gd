extends Node2D

signal tween_fin

var tween 

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	tween = create_tween().set_parallel(true)
	tween.tween_property($Sprite2D, "modulate:a", 1.0, 0.2)
	tween.tween_property($Sprite2D, "rotation_degrees", 120.0, 0.3).set_delay(0.05).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	tween.tween_method(baba,0.0,1.0,0.01)
	tween.tween_property($Sprite2D, "modulate:a", 0.0, 0.2).set_delay(0.3)
	await tween.finished
	tween_fin.emit()

func baba(va):
	$GPUParticles2D.emitting = true
