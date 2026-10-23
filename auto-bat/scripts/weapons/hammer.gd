extends weapon


func _on_timer_timeout() -> void:
	var s = preload("res://scenes/weapons/effects/hammerfx.tscn").instantiate()
	get_parent().add_child(s)
	s.global_position = get_tree().current_scene.enemy.global_position - Vector2(50, 150)
	await s.tween_fin
	attack()
	s.queue_free()
	
	$Timer.start(basecooldown * cooldownmult)
