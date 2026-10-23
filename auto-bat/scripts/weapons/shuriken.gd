extends weapon


func _on_timer_timeout() -> void:
	var s = preload("res://scenes/weapons/effects/ninjastar.tscn").instantiate()
	get_parent().add_child(s)
	s.global_position = global_position
	await get_tree().create_timer(0.6).timeout
	attack()
	var tween = create_tween()
	tween.tween_property(s,"speed",-2500,0.6).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(0.2).timeout
	attack()
	
	await get_tree().create_timer(2.0).timeout
	s.queue_free()
	
	$Timer.start(basecooldown * cooldownmult)
